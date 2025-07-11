-- Tabla de clientes
CREATE TABLE IF NOT EXISTS clientes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre TEXT,
  identificacion TEXT UNIQUE,
  direccion TEXT,
  telefono TEXT,
  email TEXT,
  fecha_creacion TIMESTAMP DEFAULT NOW()
);

-- Tabla de facturas
CREATE TABLE IF NOT EXISTS facturas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cliente_id UUID REFERENCES clientes(id),
  numero_factura TEXT,
  fecha_emision DATE,
  fecha_vencimiento DATE,
  total NUMERIC,
  estado TEXT
);

-- Tabla de pagos
CREATE TABLE IF NOT EXISTS pagos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  factura_id UUID REFERENCES facturas(id),
  fecha DATE,
  monto NUMERIC,
  metodo_pago TEXT
);

-- Tabla historial de cobranzas
CREATE TABLE IF NOT EXISTS historial_cobranzas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cliente_id UUID REFERENCES clientes(id),
  fecha_contacto TIMESTAMP,
  medio_contacto TEXT CHECK (medio_contacto IN ('telefono', 'email', 'sistema')),
  observaciones TEXT
);

-- Tabla sesiones telegram
CREATE TABLE IF NOT EXISTS sesiones_telegram (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  chat_id TEXT,
  cedula TEXT
);
