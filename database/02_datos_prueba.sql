USE viasbolivia;

INSERT INTO rol (nombre, descripcion) VALUES
 ('administrador', 'Gestiona usuarios, tarifas, carriles y reportes'),
 ('operador',      'Realiza tareas operativas; no puede eliminar usuarios');

INSERT INTO usuario (id_rol, nombre_completo, nombre_usuario, correo, contrasena_hash, estado, fecha_aprobacion) VALUES
 (1, 'Moises Rodriguez Mamani', 'admin', 'admin@viasbolivia.test', 'HASH_ADMIN', 'activo', NOW()),
 (2, 'Operador de Prueba',      'op1',   'op1@viasbolivia.test',   'HASH_OP1',   'activo', NOW());
UPDATE usuario SET id_aprobador = 1 WHERE id_usuario = 2;

INSERT INTO carril (numero, sentido) VALUES
 (1,'BAJADA'),(2,'BAJADA'),(3,'BAJADA'),
 (1,'SUBIDA'),(2,'SUBIDA'),(3,'SUBIDA');

INSERT INTO categoria_vehicular (nombre, descripcion) VALUES
 ('liviano', 'Automóviles, vagonetas y camionetas'),
 ('pesado',  'Camiones y buses');

INSERT INTO tarifa (id_categoria, id_usuario, monto, vigente_desde) VALUES
 (1, 1, 2.00, '2026-08-01'),
 (2, 1, 5.00, '2026-08-01');

INSERT INTO paso_vehicular
 (id_carril, id_tarifa, id_usuario_validador, placa_reconocida, fecha_hora, confianza_lectura, estado_validacion) VALUES
 (1, 1, NULL, '2845KLM', '2026-10-20 07:15:10', 96.40, 'automatico'),
 (1, 1, NULL, '1932BDF', '2026-10-20 07:15:42', 91.10, 'automatico'),
 (2, 2, NULL, '3310TRX', '2026-10-20 07:16:05', 88.75, 'automatico'),
 (4, 1, 2,    '5521HJK', '2026-10-20 07:16:30', 62.30, 'corregido'),
 (5, 1, NULL, '2845KLM', '2026-10-20 18:40:12', 94.80, 'automatico'),
 (6, 2, NULL, '7710WQP', '2026-10-20 18:41:03', 58.90, 'observado');
