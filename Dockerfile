##! Dockerfile (Define cómo se construye el entorno de tu aplicación)

#* Usa la imagen oficial ligera de Node.js 20 basada en Debian
FROM node:20-slim

#* Establece /app como directorio de trabajo dentro del contenedor
WORKDIR /app

#* Copia primero solo package.json y package-lock.json para aprovechar la caché de Docker
COPY package*.json ./

#* Instala las dependencias del proyecto dentro del contenedor
RUN npm install

#* Copia el resto del código de tu proyecto hacia /app (respetando el .dockerignore)
COPY . .

#* Documenta que el contenedor escucha en el puerto 3003 (coincidiendo con docker-compose.yml)
EXPOSE 3003

#* Ejecuta el servidor en modo desarrollo al iniciar el contenedor
CMD ["npm", "run", "dev"]


# FROM node:20-slim

# WORKDIR /app

# #! Primero solo package*.json: así Docker cachea npm install
# #! y no lo repite salvo que cambien las dependencias

# COPY package*.json ./
# RUN npm install
# COPY . .
# EXPOSE 3000
# CMD ["npm", "run", "dev"]
