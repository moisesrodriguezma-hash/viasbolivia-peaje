-- VíasBolivia: modelo relacional (MySQL/MariaDB)
CREATE DATABASE IF NOT EXISTS viasbolivia CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE viasbolivia;

CREATE TABLE rol (
  id_rol      TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre      VARCHAR(30)  NOT NULL,
  descripcion VARCHAR(150) NULL,
  PRIMARY KEY (id_rol),
  UNIQUE KEY uq_rol_nombre (nombre)
) ENGINE=InnoDB;

CREATE TABLE usuario (
  id_usuario       INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_rol           TINYINT UNSIGNED NOT NULL,
  nombre_completo  VARCHAR(100) NOT NULL,
  nombre_usuario   VARCHAR(30)  NOT NULL,
  correo           VARCHAR(100) NOT NULL,
  contrasena_hash  VARCHAR(255) NOT NULL,
  estado           ENUM('pendiente','activo','inactivo') NOT NULL DEFAULT 'pendiente',
  fecha_solicitud  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_aprobacion DATETIME NULL,
  id_aprobador     INT UNSIGNED NULL,
  PRIMARY KEY (id_usuario),
  UNIQUE KEY uq_usuario_nombre (nombre_usuario),
  UNIQUE KEY uq_usuario_correo (correo),
  CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES rol (id_rol),
  CONSTRAINT fk_usuario_aprobador FOREIGN KEY (id_aprobador) REFERENCES usuario (id_usuario)
) ENGINE=InnoDB;

CREATE TABLE carril (
  id_carril TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  numero    TINYINT UNSIGNED NOT NULL,
  sentido   ENUM('BAJADA','SUBIDA') NOT NULL,
  estado    ENUM('habilitado','deshabilitado') NOT NULL DEFAULT 'habilitado',
  PRIMARY KEY (id_carril),
  UNIQUE KEY uq_carril (numero, sentido),
  CONSTRAINT ck_carril_numero CHECK (numero BETWEEN 1 AND 3)
) ENGINE=InnoDB;

CREATE TABLE categoria_vehicular (
  id_categoria TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre       VARCHAR(40)  NOT NULL,
  descripcion  VARCHAR(150) NULL,
  PRIMARY KEY (id_categoria),
  UNIQUE KEY uq_categoria_nombre (nombre)
) ENGINE=InnoDB;

CREATE TABLE tarifa (
  id_tarifa     INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_categoria  TINYINT UNSIGNED NOT NULL,
  id_usuario    INT UNSIGNED NOT NULL,
  monto         DECIMAL(8,2) NOT NULL,
  vigente_desde DATE NOT NULL,
  vigente_hasta DATE NULL,
  PRIMARY KEY (id_tarifa),
  CONSTRAINT ck_tarifa_monto CHECK (monto >= 0),
  CONSTRAINT fk_tarifa_categoria FOREIGN KEY (id_categoria) REFERENCES categoria_vehicular (id_categoria),
  CONSTRAINT fk_tarifa_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
) ENGINE=InnoDB;

CREATE TABLE paso_vehicular (
  id_paso              BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_carril            TINYINT UNSIGNED NOT NULL,
  id_tarifa            INT UNSIGNED NOT NULL,
  id_usuario_validador INT UNSIGNED NULL,
  placa_reconocida     VARCHAR(10) NOT NULL,
  fecha_hora           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  confianza_lectura    DECIMAL(5,2) NOT NULL,
  ruta_imagen          VARCHAR(255) NULL,
  estado_validacion    ENUM('automatico','corregido','observado') NOT NULL DEFAULT 'automatico',
  PRIMARY KEY (id_paso),
  KEY idx_paso_placa (placa_reconocida),
  KEY idx_paso_fecha (fecha_hora),
  CONSTRAINT ck_paso_confianza CHECK (confianza_lectura BETWEEN 0 AND 100),
  CONSTRAINT fk_paso_carril FOREIGN KEY (id_carril) REFERENCES carril (id_carril),
  CONSTRAINT fk_paso_tarifa FOREIGN KEY (id_tarifa) REFERENCES tarifa (id_tarifa),
  CONSTRAINT fk_paso_validador FOREIGN KEY (id_usuario_validador) REFERENCES usuario (id_usuario)
) ENGINE=InnoDB;

CREATE TABLE bitacora (
  id_bitacora BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_usuario  INT UNSIGNED NOT NULL,
  accion      VARCHAR(60)  NOT NULL,
  detalle     VARCHAR(255) NULL,
  fecha_hora  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_bitacora),
  CONSTRAINT fk_bitacora_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
) ENGINE=InnoDB;
