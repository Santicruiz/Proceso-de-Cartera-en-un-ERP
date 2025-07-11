
# 🤖 Agente de Cartera Automatizado con n8n, Supabase, WhatsApp y Telegram

Este proyecto implementa un sistema automatizado para la gestión de cartera usando:
- **n8n** para la lógica y automatización
- **Supabase** como base de datos
- **WhatsApp y Telegram** como canales de atención al cliente
- **Funciones SQL y triggers** para lógica avanzada de pagos

---

## 🧠 Funcionalidad General

1. **Recepción de mensajes por WhatsApp y Telegram**
2. **Identificación del usuario** mediante número de cédula
3. **Consulta de datos de cartera** como facturas vencidas o saldo pendiente
4. **Respuesta automática** a mensajes comunes
5. **Trigger en Supabase** que actualiza el estado de facturas automáticamente al registrar un pago
6. **Historial de cobranzas** registrado en cada acción

---

## 🧰 Herramientas Utilizadas

- `n8n.cloud`
- `Supabase`
- `Twilio API` (para WhatsApp)
- `Telegram Bot API`
- `PostgreSQL` (con funciones y triggers)
- `GitHub` (para versionado del proyecto)

---

## 📁 Estructura del Repositorio

```
📦 agente-cartera-n8n
├── workflows/
│   ├── telegram_workflow.json
│   ├── whatsapp_workflow.json
│   └── funciones_utiles_n8n.md
├── sql/
│   ├── schema.sql
│   ├── funciones.sql
│   ├── triggers.sql
│   └── ejemplos_inserts.sql
├── README.md
```

---

## 🔄 Cómo Ejecutar

### 1. Configura Supabase
- Crea las tablas: `clientes`, `facturas`, `pagos`, `sesiones_telegram`, `historial_cobranzas`
- Ejecuta los archivos en `/sql/schema.sql`
- Crea las funciones y triggers con `funciones.sql` y `triggers.sql`

### 2. Configura n8n
- Importa los workflows desde la carpeta `/workflows`
- Configura tus credenciales de:
  - Twilio (para WhatsApp)
  - Telegram
  - Supabase (API Key, URL)

### 3. Prueba el sistema
- Envía mensajes como: `Hola`, `52838383`, `saldo`, `facturas`
- Observa cómo responde el bot y actualiza los datos

---

## 📦 Funciones SQL Avanzadas

- `aplicar_pago()`: función que aplica el monto de un pago a las facturas más antiguas del cliente (FIFO), actualiza estados y registra el evento.
- `trigger_aplicar_pago`: se ejecuta automáticamente después de insertar un nuevo pago.

---

## 📸 Screenshots

> Agrega capturas de tu n8n, respuestas en Telegram o Supabase para mejor documentación visual.

---

## 📄 Licencia

MIT © Santiago Castro
