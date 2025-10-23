# Threading en PHP

## PHP NO es multithreading

PHP fue diseñado desde sus inicios con un modelo **sin estado (stateless)** y **multiproceso mediante procesos separados**, no mediante hilos. 

## Modelo Tradicional de PHP

### Procesos Independientes (Multi-process)

```bash
# Cada solicitud PHP genera un proceso independiente
Request 1 → PHP Process 1
Request 2 → PHP Process 2
Request 3 → PHP Process 3
```

##*Evolución hacia el Paralelismo

### 1. PHP 4 y 5 - Procesos CGI/FastCGI

- **Múltiples procesos** pero **NO hilos**
- Cada Request(Solicitud) = Proceso separado
- **Sin shared memory** entre solicitudes

### 2. PHP 5.3 (2009) - pthreads extensión

```php
// Primera aproximación a threads (experimental)
class MyThread extends Thread {
    public function run() {
        echo "Hilo ejecutándose\n";
    }
}

$thread = new MyThread();
$thread->start();
```

- **Extensión de terceros**, no incluida en el core
- Muy inestable y con limitaciones

### 3. PHP 7.x - Mejoras en el Zend Engine

- Mejor soporte para **executores concurrentes**
- **PHP-FPM** (FastCGI Process Manager) para manejar pools de procesos
- Pero aún **sin threading nativo**

### 4. PHP 8.x - Paralelismo Moderno

#### Extensión `parallel` (sucesora de pthreads)
```php
<?php
// PHP 8.0+ con extensión parallel
$runtime = new \Parallel\Runtime();

$future = $runtime->run(function() {
    return calculateSomethingComplex();
});

$result = $future->value();
```

#### Fibers en PHP 8.1 (2021)
```php
<?php
// PHP 8.1 - Fibers para código asíncrono
$fiber = new Fiber(function() {
    echo "En fiber...\n";
    Fiber::suspend();
    echo "Fiber reanudado\n";
});

echo "Iniciando...\n";
$fiber->start();
echo "Suspendido...\n";
$fiber->resume();
```

## Estado Actual en PHP 8.4

### Multiprocesing

- **PHP-FPM**: Múltiples procesos/worker
- **Process Control (PCNTL)**: Para crear procesos hijos
```php
$pid = pcntl_fork();
if ($pid == -1) {
    die('No se pudo hacer fork');
} elseif ($pid) {
    // Proceso padre
    pcntl_wait($status);
} else {
    // Proceso hijo
    exit();
}
```

### Multithreading Limitado ⚠️

- **No hay threading nativo en el core**
- **Extensión `parallel`** para threading real
- **Fibers** para concurrencia cooperativa

## ¿Por qué PHP no es tradicionalmente multithreading?

1. **Arquitectura stateless**: Cada request es independiente
2. **Problemas con extensiones**: Muchas extensiones no son thread-safe
3. **Simplicidad**: El modelo de procesos es más simple y robusto
4. **Shared-nothing architecture**: Evita problemas de concurrencia

## Alternativas para Paralelismo en PHP

### 1. Múltiples Procesos (Recomendado)

```php
// Usando procesos para paralelismo
$processes = [];
for ($i = 0; $i < 4; $i++) {
    $process = new Process(['php', 'worker.php', $i]);
    $process->start();
    $processes[] = $process;
}

// Esperar a que terminen
foreach ($processes as $process) {
    $process->wait();
}
```

### 2. Servicios Externos

- **Message Queues** (Redis, RabbitMQ)
- **Microservicios**
- **Workers independientes**

