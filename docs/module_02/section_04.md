# Estructuras de Control

Como en cualquier otro lenguaje las estructuras de control son elementos del lenguaje que permiten controlar el flujo de ejecución de un programa, determinando qué código se ejecuta y bajo qué condiciones.

Tenemos distintos tipos:

- Estructuras Condicionales
- Estructuras de Repetición
- Estructuras de Control de Flujo
- Estructuras de Inclusión
- Estructuras de Manejo de Excepciones

## Estructuras Condicionales

### if, else, elseif

```php
$edad = 18;

if ($edad < 18) {
    echo "Menor de edad";
} elseif ($edad >= 18 && $edad < 65) {
    echo "Adulto";
} else {
    echo "Adulto mayor";
}
```

### switch

```php
$dia = 3;

switch ($dia) {
    case 1:
        echo "Lunes";
        break;
    case 2:
        echo "Martes";
        break;
    case 3:
        echo "Miércoles";
        break;
    default:
        echo "Otro día";
}
```

### match (PHP 8.0+)

```php
$tipo = "admin";

$permisos = match($tipo) {
    "admin" => "Acceso total",
    "user" => "Acceso limitado",
    "guest" => "Solo lectura",
    default => "Sin acceso"
};
```

## Estructuras de Repetición (Bucles)

### for

```php
for ($i = 0; $i < 5; $i++) {
    echo "Iteración: $i\n";
}

// Con arrays
$numeros = [1, 2, 3, 4, 5];
for ($i = 0; $i < count($numeros); $i++) {
    echo $numeros[$i] . " ";
}
```

### foreach

```php
$usuarios = ["Ana", "Juan", "María"];

// Solo valores
foreach ($usuarios as $usuario) {
    echo $usuario . "\n";
}

// Con clave y valor
$edades = ["Ana" => 25, "Juan" => 30, "María" => 28];
foreach ($edades as $nombre => $edad) {
    echo "$nombre tiene $edad años\n";
}
```

### while

```php
$contador = 0;

while ($contador < 5) {
    echo "Contador: $contador\n";
    $contador++;
}

// Lectura de archivos
while ($linea = fgets($archivo)) {
    echo $linea;
}
```

### do-while
```php
$contador = 0;

do {
    echo "Contador: $contador\n";
    $contador++;
} while ($contador < 5);
```

## Estructuras de Control de Flujo

### break

```php
for ($i = 0; $i < 10; $i++) {
    if ($i === 5) {
        break; // Sale del bucle
    }
    echo $i . " ";
}
// Output: 0 1 2 3 4
```

### continue

```php
for ($i = 0; $i < 5; $i++) {
    if ($i === 2) {
        continue; // Salta esta iteración
    }
    echo $i . " ";
}
// Output: 0 1 3 4
```

### goto (uso limitado)

```php
$contador = 0;

inicio:
echo $contador . " ";
$contador++;
if ($contador < 5) {
    goto inicio;
}
```

## Estructuras de Inclusión

### include

```php
include 'header.php';
include 'config.php';
```

### require

```php
require 'database.php'; // Si falla, detiene la ejecución
```

### include_once / require_once

```php
include_once 'funciones.php'; // Evita inclusiones duplicadas
require_once 'clases.php';
```

## Estructuras de Manejo de Excepciones

### try-catch

```php
try {
    // Código que puede generar excepciones
    $resultado = 10 / 0;
} catch (DivisionByZeroError $e) {
    echo "Error: División por cero";
} catch (Exception $e) {
    echo "Error general: " . $e->getMessage();
} finally {
    echo "Esto siempre se ejecuta";
}
```

### throw

```php
function verificarEdad($edad) {
    if ($edad < 0) {
        throw new InvalidArgumentException("La edad no puede ser negativa");
    }
    return $edad >= 18;
}
```

## Novedades en PHP 8.4 para Estructuras de Control

### Mejoras en la Expresión match()

```php
// Mejor soporte para condiciones complejas
$puntuacion = 85;

$resultado = match(true) {
    $puntuacion >= 90 && $puntuacion <= 100 => 'Excelente',
    $puntuacion >= 80 && $puntuacion < 90 => 'Muy Bueno',
    $puntuacion >= 70 && $puntuacion < 80 => 'Bueno',
    default => 'Necesita mejorar'
};

// Ahora permite múltiples condiciones en un solo case
$categoria = match($edad) {
    0, 1, 2, 3, 4 => 'Primera Infancia',
    5, 6, 7, 8, 9, 10, 11 => 'Niñez',
    12, 13, 14, 15, 16, 17 => 'Adolescencia',
    default => 'Adulto'
};
```

### Mejoras en el Null Safe Operator con Estructuras

```php
// Mejor integración con estructuras de control
$usuario = obtenerUsuario();

if ($nombre = $usuario?->getPerfil()?->getNombre()) {
    echo "Bienvenido, $nombre";
} else {
    echo "Usuario no encontrado";
}

// Con arrays en estructuras de control
foreach ($objeto?->getItems() ?? [] as $item) {
    echo $item->nombre;
}
```

## Optimizaciones en Bucles

```php
// Mejor rendimiento en bucles foreach con arrays grandes
$arrayGrande = range(1, 100000);

// PHP 8.4 optimiza el uso de memoria en este tipo de bucles
foreach ($arrayGrande as $clave => $valor) {
    // Procesamiento más eficiente
    procesar($valor);
}

// Mejor manejo de bucles anidados
foreach ($arrayExterno as $externo) {
    foreach ($externo->getInternos() as $interno) {
        // Optimizado para reducir overhead
        echo $interno->valor;
    }
}
```

### Nuevo Comportamiento en switch

```php
// Mejoras en la detección de fallos por falta de 'break'
$opcion = 1;

switch ($opcion) {
    case 1:
        echo "Opción 1";
        // PHP 8.4 genera advertencias más específicas si falta break
    case 2:
        echo "Opción 2";
        break;
}
```

### Mejoras en Manejo de Excepciones

```php
// Mejores mensajes de error en estructuras de control
try {
    $resultado = procesoRiesgoso();
} catch (TypeError $e) {
    // PHP 8.4 proporciona mejor información del contexto
    logError("Error de tipo en: " . $e->getFile() . " línea " . $e->getLine());
} catch (Throwable $e) {
    // Mejor soporte para todos los tipos de errores
    manejarError($e);
}

// Nuevas excepciones específicas para estructuras de control
try {
    foreach ($objetoNoIterable as $item) {
        // ...
    }
} catch (NotIterableException $e) {
    echo "El objeto no es iterable";
}
```

### Mejoras en Condicionales con Tipos Union

```php
// Mejor manejo de tipos en condiciones
function procesarValor(int|string|float $valor): void {
    if (is_int($valor)) {
        echo "Es entero: $valor";
    } elseif (is_string($valor)) {
        echo "Es string: $valor";
    } else {
        echo "Es float: $valor";
    }
}

// Mejor optimización con instanceof y tipos union
if ($objeto instanceof ModelA || $objeto instanceof ModelB) {
    $objeto->procesar();
}
```

### Nuevas Funciones para Control de Flujo

```php
// Mejoras en funciones que afectan el flujo
$array = [1, 2, 3, 4, 5];

// array_find integrado mejor con estructuras
$encontrado = array_find($array, fn($n) => $n > 3);
if ($encontrado !== null) {
    echo "Encontrado: $encontrado";
}

// Mejor integración con estructuras de control existentes
while ($item = array_shift($cola)) {
    procesarItem($item);
}
```

### Mejoras en Rendimiento

```php
// Optimizaciones internas que afectan todas las estructuras
for ($i = 0; $i < 1000000; $i++) {
    // Ejecución más rápida en PHP 8.4
    $resultado = $i * 2;
}

// Mejor manejo de memoria en estructuras anidadas
foreach ($arrayGrande as $item) {
    if ($item->cumpleCondicion()) {
        while ($item->tieneElementos()) {
            // Menor consumo de memoria
            procesar($item->siguiente());
        }
    }
}
```

### Mejoras en Depuración

```php
// Mejores mensajes de error para estructuras de control mal formadas
if ($condicion) 
    echo "Una línea"; // PHP 8.4 da mejor feedback sobre posibles errores
    echo "Otra línea"; // Esta línea siempre se ejecuta

// Mejor información en stack traces para estructuras complejas
try {
    funcionConProblemas();
} catch (Exception $e) {
    // Stack trace más claro indicando la estructura de control involucrada
    logError($e->getTraceAsString());
}
```

```php title="Buenas Prácticas en PHP 8.4"
// Usar match() en lugar de switch cuando sea posible
$estado = match($codigo) {
    200 => 'success',
    404 => 'not found',
    500 => 'error',
    default => 'unknown'
};

// Usar null safe operator para evitar condiciones complejas
$nombre = $usuario?->getPerfil()?->getNombre() ?? 'Invitado';

// Aprovechar las optimizaciones de foreach
foreach ($array as $clave => &$valor) {
    $valor = procesar($valor); // Más eficiente en PHP 8.4
}
```
