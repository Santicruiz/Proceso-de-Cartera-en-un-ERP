-- Función que aplica el pago y actualiza las facturas
CREATE OR REPLACE FUNCTION aplicar_pago()
RETURNS TRIGGER AS $$
DECLARE
  pago_monto NUMERIC;
  cliente UUID;
  factura RECORD;
  monto_restante NUMERIC;
BEGIN
  -- Obtener el monto y cliente del nuevo pago
  pago_monto := NEW.monto;
  SELECT cliente_id INTO cliente FROM facturas WHERE id = NEW.factura_id;

  -- Aplicar el pago a las facturas más antiguas del cliente
  FOR factura IN
    SELECT * FROM facturas
    WHERE cliente_id = cliente AND estado != 'pagada'
    ORDER BY fecha_emision
  LOOP
    IF pago_monto <= 0 THEN
      EXIT;
    END IF;

    monto_restante := factura.total - (
      SELECT COALESCE(SUM(monto), 0)
      FROM pagos
      WHERE factura_id = factura.id
    );

    IF monto_restante <= 0 THEN
      CONTINUE;
    END IF;

    IF pago_monto >= monto_restante THEN
      UPDATE facturas SET estado = 'pagada' WHERE id = factura.id;
      pago_monto := pago_monto - monto_restante;
    ELSE
      UPDATE facturas SET estado = 'parcialmente_pagada' WHERE id = factura.id;
      pago_monto := 0;
    END IF;
  END LOOP;

  -- Registrar evento en historial de cobranzas
  INSERT INTO historial_cobranzas (cliente_id, fecha_contacto, medio_contacto, observaciones)
  VALUES (
    cliente,
    now(),
    'sistema',
    'Se aplicó un pago nuevo y se actualizó el estado de las facturas.'
  );

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que activa la función
DROP TRIGGER IF EXISTS trigger_aplicar_pago ON pagos;

CREATE TRIGGER trigger_aplicar_pago
AFTER INSERT ON pagos
FOR EACH ROW
EXECUTE FUNCTION aplicar_pago();
