# Multiprocesing en PHP

El **multiprocessing** en PHP no existe de forma nativa como en lenguajes como C o Python (con `multiprocessing`), porque PHP está diseñado principalmente para **ejecución secuencial** en entornos web (como Apache o Nginx con mod_php o PHP-FPM). Sin embargo,  es posible simular o implementar multiprocessing.

## Opción 1: **Procesos en paralelo con `pcntl_fork()`** (Solo en CLI)

```php linenums="1"
<?php
if (!function_exists('pcntl_fork')) {
    die("pcntl_fork no está disponible. Solo funciona en CLI con extensión pcntl.\n");
}

$pids = [];

for ($i = 0; $i < 3; $i++) {
    $pid = pcntl_fork();
    
    if ($pid == -1) {
        die("Error al hacer fork\n");
    } elseif ($pid == 0) {
        // Código del proceso hijo
        echo "Hijo " . ($i + 1) . " (PID: " . getmypid() . ") ejecutándose...\n";
        sleep(2);
        echo "Hijo " . ($i + 1) . " terminado.\n";
        exit(0); // Importante: salir del hijo
    } else {
        // Proceso padre
        $pids[] = $pid;
        echo "Padre creó hijo con PID: $pid\n";
    }
}

// Esperar a que todos los hijos terminen
foreach ($pids as $pid) {
    pcntl_waitpid($pid, $status);
}

echo "Todos los procesos terminaron.\n";
```

- Ejecutar en **CLI** (no en web).
- Extensión `pcntl` habilitada (`php -m | grep pcntl`).
- Solo en **Linux/Unix** (no en Windows).


## Opción 2: **Ejecutar comandos en paralelo con `exec()` o `shell_exec()`**

```php linenums="1"
<?php
$commands = [
    'php tarea1.php',
    'php tarea2.php',
    'php tarea3.php'
];

$processes = [];

foreach ($commands as $cmd) {
    $processes[] = popen($cmd . ' > /dev/null 2>&1 &', 'r');
}

echo "Procesos lanzados en segundo plano.\n";

// Opcional: cerrar handles
foreach ($processes as $p) {
    pclose($p);
}
```

 Útil para lanzar scripts PHP independientes en paralelo.

## Opción 3: **Usar `popen()` + `&` (fondo)**

```php linenums="1"
<?php
popen('php heavy_task.php arg1 arg2 > log.txt 2>&1 &', 'r');
echo "Tarea pesada lanzada en background.\n";
```

## Opción 4: **Colas de trabajos (Job Queues) – Recomendado en producción**

Usa sistemas externos:

| Sistema | Descripción |
|--------|-------------|
| **Redis + Queue** | `enqueue()`, `dequeue()` con workers |
| **RabbitMQ** | Mensajería avanzada |
| **Laravel Queue** | Integrado con Redis, DB, etc. |
| **Symfony Messenger** | Similar |

**Ejemplo con Redis (usando `predis`):**

```php linenums="1"
<?php
require 'vendor/autoload.php';

$client = new Predis\Client();

// Worker 1 (en un terminal)
while (true) {
    $job = $client->brpop('jobs', 5);
    if ($job) {
        echo "Procesando: " . $job[1] . "\n";
        // Procesar...
    }
}

// En otro script: encolar trabajos
$client->lpush('jobs', 'tarea_importante_1');
$client->lpush('jobs', 'tarea_importante_2');
```

## Opción 5: **ReactPHP o Swoole (asíncrono, no multiprocessing)**

- **ReactPHP**: Event loop asíncrono.
- **Swoole**: Extensión poderosa con **coroutines** y **workers reales**.

**Ejemplo con Swoole (multiproceso real):**

```php linenums="1"
<?php
$server = new Swoole\Server("127.0.0.1", 9501, SWOOLE_PROCESS);

$server->set([
    'worker_num' => 4, // 4 procesos trabajadores
]);

$server->on('receive', function ($server, $fd, $reactor_id, $data) {
    echo "Recibido: $data\n";
    $server->send($fd, "OK\n");
});

$server->start();
```

Swoole permite **verdadero multiprocessing** y alto rendimiento.

En resumen!

| Necesidad | Solución recomendada |
|---------|------------------------|
| Scripts CLI paralelos | `pcntl_fork()` |
| Tareas en background | `popen()` + `&` |
| Aplicación web escalable | **Colas (Redis + Workers)** |
| Alto rendimiento | **Swoole** |
| Web tradicional | **No uses multiprocessing directo** |

