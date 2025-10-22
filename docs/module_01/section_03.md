# Estructura de un Proyecto en PHP


## Estructura de un Proyecto Simple en PHP

```bash
proyecto-simple/
├── index.php
├── config.php
├── includes/
│   ├── header.php
│   ├── footer.php
│   └── functions.php
├── classes/
├── assets/
│   ├── css/
│   ├── js/
│   └── img/
└── .htaccess
```

## Un poco más de estructura con MVC + Composer


```bash
mi-proyecto-php/
├── public/
│   └── index.php          # Punto de entrada principal
├── src/
│   ├── Controllers/
│   ├── Models/
│   ├── Views/
│   ├── Services/
│   ├── Repositories/
│   ├── Entities/
│   └── Utils/
├── config/
│   ├── database.php
│   ├── app.php
│   └── routes.php
├── tests/
│   ├── Unit/
│   └── Feature/
├── vendor/                # Composer (no versionar)
├── storage/
│   ├── logs/
│   ├── cache/
│   └── sessions/
├── resources/
│   ├── views/
│   ├── assets/
│   │   ├── css/
│   │   ├── js/
│   │   └── images/
│   └── lang/
├── database/
│   ├── migrations/
│   ├── seeds/
│   └── factories/
├── .env                   # Variables de entorno (no versionar)
├── .env.example
├── composer.json
├── composer.lock          # (no versionar)
├── README.md
└── .gitignore
```

### index.php

`index.php` seria algo como lo siguiente:

```php
<?php
require_once __DIR__ . '/../vendor/autoload.php';

// Cargar configuración
$config = require __DIR__ . '/../config/app.php';

// Inicializar aplicación
$app = new App\Core\Application($config);

// Ejecutar la aplicación
$app->run();
```

### composer.json

```json
{
    "name": "tu-nombre/mi-proyecto",
    "description": "Descripción del proyecto",
    "type": "project",
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
    "require": {
        "php": "^8.4"
    },
    "require-dev": {
        "phpunit/phpunit": "^9.0"
    },
    "scripts": {
        "test": "phpunit"
    }
}
```

### .gitignore

```bash
/vendor/
.env
/storage/logs/*.log
/storage/cache/*
/composer.lock
```

Nunca se les olvide ignorar `.env` en cualquier proyecto!!! Si desean un mock usen `.env.example`

 que tengra una estructura similar a 

 ```bash
APP_NAME=MiProyecto
APP_ENV=local
APP_DEBUG=true

DB_HOST=localhost
DB_NAME=mi_base_datos
DB_USER=usuario
DB_PASS=password

# Otras configuraciones...
 ```


### Controllers


```php title="Ejemplo src/Controller/UserController.php" linenums="1"
<?php
namespace App\Controllers;

use App\Models\User;
use App\Services\UserService;

class UserController
{
    private UserService $userService;

    public function __construct(UserService $userService)
    {
        $this->userService = $userService;
    }

    public function index(): string
    {
        $users = $this->userService->getAllUsers();
        return json_encode($users);
    }

    public function show(int $id): string
    {
        $user = $this->userService->getUserById($id);
        return json_encode($user);
    }
}
```

### Models

```php title="Ejemplo src/Models/User.php" linenums="1"
<?php
namespace App\Models;

class User
{
    private ?int $id;
    private string $name;
    private string $email;

    // Getters y Setters
    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function setName(string $name): void
    {
        $this->name = $name;
    }

    // ... más métodos
}
```

### Services

```php title="Ejemplo src/Services/UserService.php" linenums="1"
<?php
namespace App\Services;

use App\Repositories\UserRepository;

class UserService
{
    private UserRepository $userRepository;

    public function __construct(UserRepository $userRepository)
    {
        $this->userRepository = $userRepository;
    }

    public function getAllUsers(): array
    {
        return $this->userRepository->findAll();
    }

    public function getUserById(int $id): ?array
    {
        return $this->userRepository->findById($id);
    }
}
```



## Ejemplo de script para inicializar un proyecto


```bash title="Ejemplo de script" linenums="1"
# Crear directorio del proyecto
mkdir mi-proyecto-php
cd mi-proyecto-php

# Inicializar Composer
composer init

# Crear estructura de directorios
mkdir -p public src/Controllers src/Models src/Views
mkdir -p src/Services src/Repositories src/Entities src/Utils
mkdir -p config tests/Unit tests/Feature
mkdir -p storage/logs storage/cache storage/sessions
mkdir -p resources/views resources/assets/{css,js,images} database/migrations
mkdir -p database/migrations database/seeds database/factories

# Crear archivos básicos
touch public/index.php .env .env.example .gitignore README.md
```



