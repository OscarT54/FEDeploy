# Use PHP 8.2 FPM as base image
FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Create app user
RUN useradd -m -u 1000 appuser

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY --chown=appuser:appuser . /var/www/html

# Set permissions
RUN chown -R appuser:appuser /var/www/html \
    && chmod -R 755 /var/www/html

# Switch to app user
USER appuser

# Expose PHP-FPM port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]