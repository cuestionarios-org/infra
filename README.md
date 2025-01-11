# 📦 Repositorio de Infraestructura (Infra)

Este repositorio contiene la configuración de la infraestructura utilizando Docker Compose para orquestar los servicios necesarios de la aplicación. Actualmente incluye los servicios `api-gateway` y `auth-service`.

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

1. **Archivo `.env`**

   Asegúrate de que el archivo `.env` esté presente en el directorio. Contiene configuraciones como el entorno de ejecución:

   ```
   FLASK_ENV=development
   ```

2. **Estructura de Directorios**

   El repositorio presupone que los servicios `api-gateway` y `auth-service` están ubicados en directorios adyacentes a la carpeta de infraestructura:

   ```
   /infra
   /gateway-api
   /auth-service
   ```

---

## 🚀 Uso

1. **Construir y Levantar los Servicios**

   Ejecuta el siguiente comando para construir y levantar los servicios:

   ```bash
   docker-compose up --build
   ```

   Esto iniciará los servicios `api-gateway` y `auth-service`.

2. **Verificar Servicios Activos**

   Puedes verificar los servicios activos utilizando el siguiente comando:

   ```bash
   docker ps
   ```

3. **Acceso a los Servicios**

   - 🌐 **API Gateway:** Disponible en [http://localhost:5000](http://localhost:5000)
   - 🔒 **Auth Service:** Disponible en [http://localhost:5001](http://localhost:5001)

---

## 🗂️ Volúmenes

El `auth-service` utiliza un volumen para compartir la carpeta `instance` con el contenedor:

```yaml
volumes:
  - ../auth-service/instance:/app/instance
```

Asegúrate de que la carpeta `instance` existe en el directorio `auth-service` y contiene los archivos necesarios.

---

## 📜 Scripts

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

