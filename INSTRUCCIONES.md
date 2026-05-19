# ⚽ Mundial 2026 — Guía de instalación

App de quiniela para predecir los 72 partidos de la fase de grupos del Mundial 2026, con base de datos compartida para todos tus amigos.

**Sistema de puntos:**
- 🎯 Marcador exacto: **3 puntos**
- ✓ Solo ganador correcto: **1 punto**
- ✗ Sin acierto: **0 puntos**

---

## 📦 Qué incluye este proyecto

```
MUNDIAL 2026/
├── index.html              ← La app completa (un solo archivo)
├── supabase-schema.sql     ← SQL para crear las tablas
├── vercel.json             ← Config de Vercel
├── .gitignore
└── INSTRUCCIONES.md        ← Este archivo
```

Solo necesitas hacer 3 pasos: **(1) crear Supabase**, **(2) pegar las claves en `index.html`**, **(3) subir a Vercel**.

---

## 🟢 PASO 1 — Crear cuenta y proyecto en Supabase (5 min)

1. Ve a **https://supabase.com** y crea cuenta gratis (puedes usar GitHub o Google).
2. Click en **"New Project"**.
3. Pon:
   - **Name:** `mundial2026`
   - **Database password:** una contraseña fuerte (guárdala por si acaso)
   - **Region:** la más cercana a ti (ej. `East US (North Virginia)`)
4. Click **"Create new project"** y espera ~1-2 minutos a que esté listo.

### 1.1 — Ejecutar el SQL para crear las tablas

1. En el menú izquierdo de Supabase, click en el ícono de **SQL Editor** (parece una hoja con `<>`).
2. Click en **"+ New query"**.
3. Abre el archivo **`supabase-schema.sql`** que está en esta carpeta, copia TODO su contenido.
4. Pégalo en el editor de Supabase.
5. Click en **"Run"** (botón verde, arriba a la derecha). Debe decir "Success. No rows returned".

### 1.2 — Copiar las claves de tu proyecto

1. En el menú izquierdo, ve a **Settings** (engranaje) → **API**.
2. Vas a copiar dos valores:
   - **Project URL** (ej: `https://abcdefghij.supabase.co`)
   - **anon public** key (un texto largo que empieza con `eyJhbGc...`)

---

## 🟡 PASO 2 — Pegar las claves en `index.html`

1. Abre **`index.html`** en cualquier editor de texto (Notepad, VS Code, lo que sea).
2. Busca estas líneas (están cerca del inicio del `<script>`, busca `SUPABASE_URL`):

```javascript
const SUPABASE_URL  = "TU_SUPABASE_URL_AQUI";
const SUPABASE_ANON = "TU_SUPABASE_ANON_KEY_AQUI";
const ADMIN_PASSWORD = "admin2026";
```

3. Reemplaza:
   - `TU_SUPABASE_URL_AQUI` por tu **Project URL**
   - `TU_SUPABASE_ANON_KEY_AQUI` por tu **anon public** key
   - `admin2026` por la contraseña que quieras usar para el panel admin (la que tú vas a usar para meter resultados oficiales)

Debe quedar algo así:

```javascript
const SUPABASE_URL  = "https://abcdefghij.supabase.co";
const SUPABASE_ANON = "eyJhbGciOiJIUzI1NiIsInR5cCI6...";
const ADMIN_PASSWORD = "mi_clave_secreta_123";
```

4. **Guarda el archivo.**

### 2.1 — Prueba que funcione localmente (opcional pero recomendado)

Haz doble click en `index.html` — debe abrirse en tu navegador y mostrar la pantalla de login. Si te aparece el mensaje "Falta configurar Supabase", es que no guardaste bien las claves.

Crea una cuenta de prueba (cualquier nombre + cualquier contraseña), verifica que puedas predecir partidos, abre el panel Admin con tu contraseña y prueba meter un resultado. Después borra ese usuario de prueba desde el **Table Editor** de Supabase si quieres.

---

## 🔵 PASO 3 — Subir a Vercel

Tienes dos caminos: el fácil (drag-and-drop) o el de GitHub. Recomiendo el fácil para empezar.

### Opción A — Drag and Drop (3 minutos, sin Git)

1. Ve a **https://vercel.com** y entra con tu cuenta.
2. Click en **"Add New..." → "Project"**.
3. Busca abajo la opción **"deploy from a folder"** o arrastra la carpeta entera **MUNDIAL 2026** a la página.
4. Vercel detectará que es un sitio estático. Click en **"Deploy"**.
5. En 30 segundos tendrás una URL pública del tipo `mundial2026-xxx.vercel.app`. ¡Esa es tu app! Compártela.

### Opción B — Con GitHub (recomendado para actualizaciones futuras)

1. Crea un repositorio nuevo en GitHub (público o privado).
2. Sube los 4 archivos: `index.html`, `supabase-schema.sql`, `vercel.json`, `INSTRUCCIONES.md`.
3. En Vercel: **"Add New" → "Project" → "Import Git Repository"** y selecciona tu repo.
4. Vercel detecta que es estático automáticamente. **Deja TODOS los settings por defecto** (NO toques "Build Command" ni nada — debe estar vacío).
5. Click **"Deploy"**.
6. Listo. Cada vez que hagas push a `main`, Vercel re-despliega solo.

---

## 🎯 Cómo usar la app

### Para tus amigos (usuarios normales)
1. Entran al link de Vercel.
2. Ponen su nombre + una contraseña. Si es la primera vez, se les crea cuenta. Si ya entraron antes, deben usar la misma contraseña.
3. Van a **Mis Picks** y predicen los marcadores. Se guarda automático.
4. Ven la **Tabla** para comparar puntos.

### Para ti (admin)
1. Después de cada partido, entra a la app.
2. Click en **Admin** → mete tu contraseña de admin.
3. Selecciona el grupo, mete los marcadores reales, click **Guardar**.
4. Los puntos de todos los participantes se actualizan automáticamente.

---

## ❓ Problemas comunes

**"Falta configurar Supabase"** → No reemplazaste bien `SUPABASE_URL` o `SUPABASE_ANON` en `index.html`.

**"No se pudo crear el usuario" / "Failed to fetch"** → Olvidaste correr el SQL de `supabase-schema.sql` en Supabase. O el RLS no se aplicó. Vuelve al PASO 1.1.

**No se ven las predicciones de otros usuarios** → Es normal. Cada usuario ve solo SUS predicciones. La tabla común solo muestra los puntos totales (para no spoilear los pronósticos).

**Quiero borrar un usuario o ver toda la data** → Ve a Supabase → Table Editor y verás todas las tablas: `users`, `predictions`, `results`. Puedes editar/borrar lo que quieras desde ahí.

**Quiero cambiar el sistema de puntos** → En `index.html` busca `const SCORING` y cambia los números. Por ejemplo, marcador exacto puede dar 5 pts en lugar de 3.

---

## 💰 Costos

- **Supabase free tier:** 500MB de base de datos + 50,000 solicitudes/mes. Para una quiniela de amigos esto es MUCHÍSIMO más de lo que vas a usar. Gratis para siempre.
- **Vercel hobby tier:** 100GB de ancho de banda al mes. Gratis para siempre.
- **Total:** $0.

¡Listo! Cualquier duda me avisas.
