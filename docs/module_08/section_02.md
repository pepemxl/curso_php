#  Multithreading en PHP

PHP 8.4 no introduce cambios nativos o revolucionarios en el multithreading, ya que el núcleo de PHP sigue siendo single-threaded (un solo hilo por defecto). El multithreading real (ejecución paralela en múltiples hilos que aprovechan varios núcleos de CPU) no es parte del lenguaje base, sino que se logra mediante extensiones externas.

La principal es la extensión **parallel**, desarrollada por Joe Watkins, que proporciona una API sencilla para concurrencia paralela. Esta extensión es compatible con PHP 8.0+.

Anteriormente, se usaba **pthreads** (para PHP 7.x), pero fue descontinuada después de PHP 7.4 debido a problemas (o.O)!. **Parallel** ofrece un enfoque más seguro y abstracto, enfocándose en tareas paralelas sin exponer directamente la complejidad de los hilos. Es ideal para tareas CPU-bound, como cálculos pesados o procesamiento de datos grandes, pero no es recomendable para web apps simples, donde la concurrencia se maneja mejor con procesos múltiples.

## Fundamentos del Multithreading con Parallel

### Modelo

Parallel crea **runtimes** (entornos de ejecución independientes) que spawnean hilos separados. Cada runtime ejecuta código PHP en paralelo al hilo principal, permitiendo verdadero paralelismo, es decir, el uso de múltiples núcleos.

### Componentes Clave

- **Runtime**: Un intérprete PHP en un hilo separado. Se crea para ejecutar tareas.
- **Future**: Representa el resultado de una tarea paralela. Permite obtener el valor sin bloquear el hilo principal (usando `value()`).
- **Channel**: Para comunicación segura entre hilos (envío/recepción de datos).
- **Sync**: Para sincronización y acceso seguro a recursos compartidos (evita race conditions).
- **Events**: Para programación `event-driven`, manejando loops de eventos con múltiples `futures` o `channels`.

### Cómo Funciona

1. Crea un `Runtime`.
2. Ejecuta una closure (función anónima) en paralelo con `run()`.
3. Obtén resultados vía `Future`.
4. Usa `channels` o `sync` para manejar datos compartidos y evitar problemas como race conditions los cuales occurent cuando hilos modifican datos simultáneamente o deadlocks al tener hilos esperando recursos mutuamente.

### Limitaciones

- Requiere compilación ZTS (Zend Thread Safe) de PHP.
- No todas las extensiones PHP son thread-safe; por lo que se debe verificar la compatibilidad.
- Gestión de memoria: PHP garbage collector es single-threaded, así que evita hilos largos con mucho memoria.
- No es para I/O bound task, para ellos se puede usar `Fibers`.


### Instalación

Se instala via PECL (para Linux/macOS: `pecl install parallel`). Para Windows, se descarga el DLL y se agrega a `php.ini` (`extension=php_parallel.dll`). 

Se verifica con `extension_loaded('parallel')`.

## Buenas Prácticas

- Evitar estado compartido; pasa datos a tareas y retorna resultados, es decir, funcional.
- Usa `Sync` para recursos compartidos.
- Libera memoria explícitamente (ej. `unset()`).
- Prueba en producción para compatibilidad.

En PHP 8.4, el rendimiento general mejora (optimizaciones en JIT y GC), beneficiando indirectamente al parallel, pero no hay features nuevas específicas.

## Ejemplos

```php title="Ejecutar una Tarea en Paralelo" linenums="1"
<?php
use parallel\{Runtime, Future};

// Crea un runtime
$runtime = new Runtime();

try {
    // Ejecuta una tarea en paralelo
    $future = $runtime->run(function() {
        // Simula trabajo pesado
        $sum = 0;
        for ($i = 0; $i < 1000000; $i++) {
            $sum += $i;
        }
        return $sum;
    });

    // Código principal continúa mientras la tarea corre
    echo "Tarea principal ejecutándose...\n";

    // Obtiene el resultado (bloquea si no está listo)
    echo "Resultado paralelo: " . $future->value() . "\n";
} catch (parallel\Runtime\Error $e) {
    echo "Error en runtime: " . $e->getMessage();
} catch (parallel\Future\Error $e) {
    echo "Error en future: " . $e->getMessage();
}
?>
```

Crea un hilo paralelo para calcular una suma grande. El hilo principal no se bloquea hasta que necesita el resultado. Salida aproximada: "Tarea principal ejecutándose..." seguido de "Resultado paralelo: 499999500000".

```php title="Ejemplo con Channels: Comunicación entre Hilos" linenums="1"
<?php
use parallel\{Runtime, Channel};

// Crea un canal infinito
$channel = Channel::make("mi_canal", Channel::Infinite);

$runtime = new Runtime();
$runtime->run(function($channel) {
    $channel->send("Datos desde el hilo paralelo!");
}, [$channel]);

// Recibe del canal en el hilo principal
echo $channel->recv() . "\n";
?>
```

El hilo paralelo envía un mensaje via channel, y el principal lo recibe. Ideal para pasar datos sin race conditions.

```php title="Ejemplo con Sync: Sincronización para Recursos Compartidos" linenums="1"
<?php
use parallel\{Runtime, Sync};

$sync = new Sync(0); // Inicializa con valor 0

$runtime = new Runtime();
$future = $runtime->run(function($sync) {
    $sync->lock(); // Bloquea acceso
    $value = $sync->get();
    $sync->set($value + 1); // Modifica seguro
    $sync->unlock(); // Libera
    return $sync->get();
}, [$sync]);

echo "Valor final: " . $future->value() . "\n"; // Salida: Valor final: 1
?>
```

Evita race conditions al bloquear el acceso al valor compartido durante la modificación.


```php title="Ejemplo con Events: Manejo de Múltiples Tareas" linenums="1"
<?php
use parallel\{Runtime, Events, Future};

$runtime = new Runtime();
$events = new Events();

$future1 = $runtime->run(function() {
    sleep(1);
    return "Tarea 1 completada";
});

$future2 = $runtime->run(function() {
    sleep(2);
    return "Tarea 2 completada";
});

$events->addFuture($future1);
$events->addFuture($future2);

foreach ($events as $event) {
    echo $event->value() . "\n";
}
?>
```

Crea un loop de eventos para manejar múltiples futures asincrónicamente. Imprime resultados a medida que completan.

