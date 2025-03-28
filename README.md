# 📦 Repositorio de Infraestructura (Infra)

Este repositorio contiene la configuración de la infraestructura utilizando Docker Compose para orquestar los servicios necesarios de la aplicación.

## 📁 Contenido del Repositorio

- **compose/**: Archivo `docker-compose.yml` para levantar los servicios de la aplicación.
- **.env**: Archivo de configuración de variables de entorno.
- **README.md**: Documentación del repositorio.

---

## ✅ Requisitos Previos

Asegúrate de tener instaladas las siguientes herramientas en tu sistema:

- 🐳 [Docker](https://www.docker.com/) (version 20.x o superior)
- 📜 [Docker Compose](https://docs.docker.com/compose/) (version 1.29 o superior)
- 🌐 Git

---

## 📥 Clonación del Repositorio

Para clonar este repositorio, ejecuta el siguiente comando:

```bash
git clone <URL-DEL-REPOSITORIO>
cd infra
```

---

## ⚙️ Configuración

1. **Variables de entorno**

   - El archivo `.Template_env` se copiara y se renombrara `.env`
   - El archivo `.Template_env.dev` se copiara y se renombrara `.env.dev`, aqui se encuentran todas las variables para levantar los servicios en desarrollo.
   - Estas variables son esenciales para los puertos y servers de todos los servicios.


2. **Estructura de Directorios**

   El repositorio presupone que los servicios `api-gateway`, `auth-service`, etc, están ubicados en directorios adyacentes a la carpeta de infraestructura:

   ```
   /infra
   /gateway-api
   /auth-service
   /competition-service
   /qa-service
   ```

---

## 🚀 Uso
**Nota:** Ojo con los archivos .sh, desde vscode cambiar el CRLf a LF (abajo a la derecha)
(TODO_26/3/25: Hacer en auto)

1. **Construir y Levantar los Servicios**
   Este repo como solo es de infraestructura no hay nada que instalar, solo debemos estar en el directorio donde esta el `docker-compose.yml` y desde alli:
   - Ejecuta el siguiente comando para construir y levantar los servicios:

   ```bash
   docker-compose up --build
   ```

   Esto iniciará los servicios.

2. **Verificar Servicios Activos**

   Puedes verificar los servicios activos utilizando el siguiente comando:

   ```bash
   docker ps
   ```
   o un listado mas elegante:
   ```bash
   docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
   ```
   ![Listado de servicios](imagenes/lista_servicios.png)


### TODO 25/3/25 Editar hacia abajo segun vaya probando
3. **Acceso a los Servicios**

   - 🌐 **API Gateway:** Disponible en [http://localhost:5000](http://localhost:5000)
   - 🔒 **Auth Service:** Disponible en [http://localhost:5001](http://localhost:5001)

4. **Prueba ENDPOINT**
   Verificar endopints basicos con curl
   - Home
   ```bash
   curl -X GET http://localhost:5000
   ```  
   Deberia responder con unos datos simples para chequeo de que funciona
   - Register
   ```bash
   curl -X POST http://localhost:5000/auth/register \
   -H "Content-Type: application/json" \
   -d '{"username":"test01", "email": "test01@test.com", "password": "1234"}'
   ```
   - Login
   ```bash
   curl -X POST http://localhost:5000/auth/login \
   -H "Content-Type: application/json" \
   -d '{"email": "fom6@test.com", "password": "1234"}'
   ```
   Deberia retrnar un token. Con ese token podemos listar los usuarios:
   - Listado de usuarios ruta protegida, token y user admin
   ```bash
   curl -X GET http://localhost:5000/auth/list \
   -H "Authorization: Bearer YOUR_TOKEN_HERE"
   ```   
   ---
5. PGAdmin

🔗 Acceder a pgAdmin
Abre tu navegador y ve a http://localhost:5050

Inicia sesión con:

Usuario: admin@example.com

Contraseña: admin1234

Agrega una conexión para cada base de datos.

🔧 Configurar conexiones en pgAdmin
Para agregar cada base de datos:

Ve a Servers → Add New Server

En la pestaña General:

Name: PostgreSQL (o cualquier nombre)

En la pestaña Connection:

Host:

postgres-auth (para la base auth)

postgres-qa (para qa)

postgres-competition (para competition)

Port:

5434 para auth

5432 para qa

5433 para competition

Username y Password: Usa los valores de tu .env

 ![Listado de servicios](imagenes/pg_server_conection.png)

💡 Nota: Si accedes desde fuera de Docker (por ejemplo, con psql en tu PC), usa localhost en lugar del nombre del servicio.


---

## 🗂️ Volúmenes

El `auth-service` utiliza un volumen para compartir la carpeta `instance` con el contenedor:

```yaml
volumes:
  - ../auth-service/instance:/app/instance
```

Asegúrate de que la carpeta `instance` existe en el directorio `auth-service` y contiene los archivos necesarios.

---

## 📜 Scripts (TODO 25/3/25 debo ejecutar algo o no ?)

Este repositorio incluye una carpeta `scripts/` con herramientas para automatizar tareas comunes. A continuación, se detallan los scripts disponibles y su uso:

1. **Inicializar Servicios:**

   Script: `scripts/init-services.sh`

   Uso:
   ```bash
   ./scripts/init-services.sh
   ```
   Este script construye y levanta todos los servicios definidos en `docker-compose.yml`.

2. **Limpiar Recursos:**

   Script: `scripts/clean-resources.sh`

   Uso:
   ```bash
   ./scripts/clean-resources.sh
   ```
   Este script detiene y elimina los contenedores, redes y volúmenes asociados a los servicios.

3. **Verificar Dependencias:**

   Script: `scripts/check-dependencies.sh`

   Uso:
   ```bash
   ./scripts/check-dependencies.sh
   ```
   Este script verifica que Docker, Docker Compose y Git estén instalados y configurados correctamente.

Para ejecutar los scripts, asegúrate de otorgar permisos de ejecución:

```bash
chmod +x ./scripts/*.sh
```

---

## 🛠️ Solución de Problemas

- **Error de Conexión entre Servicios:**
  Verifica que los servicios están configurados para usar el hostname correcto. En Docker Compose, utiliza el nombre del servicio (por ejemplo, `auth-service`) en lugar de `localhost`.

- **Puertos Ocupados:**
  Si los puertos `5000` o `5001` ya están en uso, puedes modificarlos en el archivo `docker-compose.yml`:

  ```yaml
  ports:
    - "nuevo-puerto:5000"  # Para api-gateway
    - "nuevo-puerto:5001"  # Para auth-service
  ```

- **Permisos de Archivos:**
  Si encuentras problemas con permisos, verifica que el usuario que ejecuta Docker tenga acceso a la carpeta `auth-service/instance`.

---

## ⏹️ Apagar los Servicios

Para detener los servicios, utiliza el siguiente comando:

```bash
docker-compose down
```

Esto también eliminará los contenedores creados, pero conservará los volúmenes.

---

## 🤝 Contribuir

Si deseas contribuir al repositorio, abre un pull request o informa de un problema en el repositorio.

---

## 📜 Licencia

Este proyecto está licenciado bajo los términos de [MIT License](LICENSE).

