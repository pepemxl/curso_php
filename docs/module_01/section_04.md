# ¿Qué es exactamente Composer?


**Composer** es el gestor de dependencias más popular para PHP. Piensa en él como el "npm" de Node.js o el "pip" de Python, pero específicamente para PHP.

## Definición Simple

Composer es una herramienta que:

- **Gestiona librerías** que tu proyecto necesita
- **Descarga automáticamente** las dependencias
- **Maneja las versiones** compatibles
- **Genera un autoloader** automático para tus clases

## Funciones Principales

### 1. **Gestión de Dependencias**

```json
{
    "require": {
        "monolog/monolog": "^2.0",
        "guzzlehttp/guzzle": "^7.0"
    }
}
```

### 2. **Autoloading Automático**

```php title="Ejemplo de autoloading"
// Sin Composer
require_once 'vendor/monolog/monolog/src/Monolog/Logger.php';
require_once 'vendor/monolog/monolog/src/Monolog/Handler/StreamHandler.php';

// Con Composer
require_once 'vendor/autoload.php';
$log = new Monolog\Logger('name');
```

## Instalación

### En Linux/macOS

```bash
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

### En Windows

Descargar el instalador desde [getcomposer.org](https://getcomposer.org/)

## Uso Práctico

### Inicializar un proyecto

```bash title="Inicializar un proyecto"
composer init
```

### Instalar dependencias

```bash title="Instalar dependencias"
# Instala todas las dependencias listadas en composer.json
composer install

# Agregar una nueva dependencia
composer require monolog/monolog
```

### Archivos importantes

- **`composer.json`** - Define las dependencias y configuración
- **`composer.lock`** - Bloquea las versiones exactas (no modificar manualmente)
- **`vendor/`** - Directorio donde se instalan las dependencias

## Ejemplo

```json title="composer.json" linenums="1"
{
    "name": "mi-proyecto/app",
    "description": "Mi aplicación PHP",
    "type": "project",
    "require": {
        "php": "^8.0",
        "monolog/monolog": "^2.0",
        "illuminate/database": "^8.0"
    },
    "require-dev": {
        "phpunit/phpunit": "^9.0"
    },
    "autoload": {
        "psr-4": {
            "App\\": "src/"
        }
    },
    "autoload-dev": {
        "psr-4": {
            "Tests\\": "tests/"
        }
    },
    "scripts": {
        "test": "phpunit",
        "deploy": "php deploy.php"
    }
}
```

```php title="Ejemplo de Uso" linenums="1"
<?php
// Esto carga TODAS las dependencias y tu código
require 'vendor/autoload.php';

// Ahora puedes usar cualquier librería instalada
use Monolog\Logger;
use Monolog\Handler\StreamHandler;

$log = new Logger('name');
$log->pushHandler(new StreamHandler('app.log', Logger::WARNING));
$log->warning('Este es un warning!');
```

## Comandos Esenciales

```bash title="Comandos Esenciales"
# Ver ayuda
composer

# Instalar dependencias
composer install

# Agregar nueva dependencia
composer require vendor/paquete

# Actualizar dependencias
composer update

# Actualizar solo una dependencia
composer update vendor/paquete

# Ver dependencias instaladas
composer show

# Ejecutar scripts definidos
composer run-script test
```

### Ventajas

1. **No reinventes la rueda** - Usa código ya probado
2. **Control de versiones** - Maneja dependencias conflictivas
3. **Autoloading automático** - Olvídate de los `require`
4. **Ecosistema enorme** - Packagist tiene +300,000 paquetes
5. **Entorno reproducible** - `composer.lock` garantiza mismas versiones

### Ejemplo de flujo común de trabajo

```bash title="Ejemplo de flujo de trabajo"
# Clonas un proyecto existente
git clone mi-proyecto
cd mi-proyecto

# Instalas las dependencias exactas
composer install

# Agregas una nueva funcionalidad
composer require firebase/php-jwt

# ¡Ahora si a programar!
```

## Packagist.org

Es el repositorio principal de paquetes PHP. Cuando ejecutas `composer require`, busca aquí los paquetes.

### Ejemplos de paquetes

- `guzzlehttp/guzzle` - Cliente HTTP
- `monolog/monolog` - Logging
- `illuminate/database` - Eloquent ORM (Laravel)
- `symfony/http-foundation` - Componentes HTTP
