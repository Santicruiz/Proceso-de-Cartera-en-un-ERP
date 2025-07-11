-- Borrar datos de sesiones
DELETE FROM sesiones_telegram;

-- Borrar pagos, facturas y clientes
DELETE FROM pagos;
DELETE FROM facturas;
DELETE FROM clientes;
DELETE FROM historial_cobranzas;
