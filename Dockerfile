# Usar una imagen base con Ruby y Node.js
FROM ruby:3.2-alpine

# Instalar dependencias del sistema
RUN apk add --no-cache \
    build-base \
    nodejs \
    npm \
    git \
    bash

# Crear directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias primero (para mejor cache)
COPY Gemfile Gemfile.lock* ./
COPY package*.json ./

# Instalar dependencias de Ruby
RUN bundle install

# Instalar dependencias de Node.js
RUN npm install

# Copiar el resto del código
COPY . .

# Exponer puerto para Jekyll
EXPOSE 4000

# Comando por defecto para desarrollo
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000", "--livereload", "--livereload-port", "35729"] 