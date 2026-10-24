USE viasbolivia;

-- Consulta 1: pasos y recaudación por carril en un día
SELECT c.sentido, c.numero AS carril, COUNT(p.id_paso) AS total_pasos, SUM(t.monto) AS recaudado_bs
FROM paso_vehicular p
JOIN carril c ON c.id_carril = p.id_carril
JOIN tarifa t ON t.id_tarifa = p.id_tarifa
WHERE DATE(p.fecha_hora) = '2026-10-20'
GROUP BY c.sentido, c.numero
ORDER BY c.sentido, c.numero;

-- Consulta 2: lecturas OCR de baja confianza pendientes de revisión
SELECT p.id_paso, p.placa_reconocida, p.fecha_hora, p.confianza_lectura,
       CONCAT(c.sentido, ' - carril ', c.numero) AS carril, p.estado_validacion
FROM paso_vehicular p
JOIN carril c ON c.id_carril = p.id_carril
WHERE p.confianza_lectura < 80 AND p.estado_validacion <> 'corregido'
ORDER BY p.confianza_lectura ASC;

-- Consulta 3: historial de pasos de una placa
SELECT p.fecha_hora, p.placa_reconocida, cv.nombre AS categoria, t.monto AS tarifa_bs, c.sentido, c.numero AS carril
FROM paso_vehicular p
JOIN carril c ON c.id_carril = p.id_carril
JOIN tarifa t ON t.id_tarifa = p.id_tarifa
JOIN categoria_vehicular cv ON cv.id_categoria = t.id_categoria
WHERE p.placa_reconocida = '2845KLM'
ORDER BY p.fecha_hora DESC;
