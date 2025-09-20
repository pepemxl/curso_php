# Usa la imagen oficial de PHP 8.4 con Apache
FROM php:8.4-apache

# Instala dependencias del sistema necesarias para las extensiones PHP
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zlib1g-dev \
    libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Configura y instala extensiones PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) pdo_mysql mysqli gd curl zip

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configura Apache para servir archivos desde /var/www/html
RUN a2enmod rewrite
ENV APACHE_DOCUMENT_ROOT /var/www/html
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Copia el código de tu aplicación (opcional, ya que usaremos volúmenes)
COPY . /var/www/html/

# Expone el puerto 80
EXPOSE 80

# Comando por defecto para iniciar Apache
CMD ["apache2-foreground"]