# Operadores

Tenemos todos lo operadores clásicos.


## Clasificación de Operadores

### Operadores Aritméticos

```php
$a = 10;
$b = 3;

echo $a + $b;  // 13 - Suma
echo $a - $b;  // 7  - Resta
echo $a * $b;  // 30 - Multiplicación
echo $a / $b;  // 3.333... - División
echo $a % $b;  // 1  - Módulo
echo $a ** $b; // 1000 - Exponenciación (PHP 5.6+)
```

### Operadores de Asignación

```php
$a = 5;        // Asignación básica
$a += 3;       // $a = $a + 3 → 8
$a -= 2;       // $a = $a - 2 → 6
$a *= 4;       // $a = $a * 4 → 24
$a /= 3;       // $a = $a / 3 → 8
$a %= 5;       // $a = $a % 5 → 3
$a **= 2;      // $a = $a ** 2 → 9
```

### Operadores de Comparación

```php
$a = 5;
$b = "5";

var_dump($a == $b);   // true - Igualdad en valor
var_dump($a === $b);  // false - Igualdad en valor y tipo
var_dump($a != $b);   // false - Diferente en valor
var_dump($a !== $b);  // true - Diferente en valor o tipo
var_dump($a < $b);    // false
var_dump($a > $b);    // false
var_dump($a <= $b);   // true
var_dump($a >= $b);   // true

// Operador de nave espacial (PHP 7+)
var_dump($a <=> $b);  // 0 - igual, 1 mayor, -1 menor
```

### Operadores Lógicos

```php
$a = true;
$b = false;

var_dump($a && $b);   // false - AND
var_dump($a || $b);   // true - OR
var_dump(!$a);        // false - NOT
var_dump($a and $b);  // false - AND (baja precedencia)
var_dump($a or $b);   // true - OR (baja precedencia)
var_dump($a xor $b);  // true - XOR (uno verdadero, no ambos)
```

### Operadores de Incremento/Decremento

```php
$a = 5;
echo ++$a; // 6 - Pre-incremento
echo $a++; // 6 - Post-incremento (luego $a = 7)
echo --$a; // 6 - Pre-decremento
echo $a--; // 6 - Post-decremento (luego $a = 5)
```

### Operadores de String

```php
$nombre = "Juan";
$apellido = "Pérez";

echo $nombre . " " . $apellido; // "Juan Pérez" - Concatenación
$nombre .= " Carlos"; // $nombre = "Juan Carlos" - Concatenación y asignación
```

### Operadores de Array

```php
$array1 = [1, 2];
$array2 = [3, 4];

$union = $array1 + $array2;        // Unión
$igual = $array1 == $array2;       // Igualdad
$identico = $array1 === $array2;   // Identidad
```

### Operador de Ejecución

```php
$output = `ls -la`; // Ejecuta comando del sistema
echo $output;
```

### Operadores de Control de Errores

```php
$valor = @$variableNoDefinida; // Suprime errores (no recomendado)
```

### Operador Null Coalescing (PHP 7+)

```php
$valor = $a ?? $b ?? "valor por defecto";
// Retorna el primer valor que exista y no sea null
```

### Null Safe Operator (PHP 8+)

```php
$resultado = $objeto?->metodo()?->propiedad;
// Solo ejecuta si el objeto no es null
```

### Operador Ternario

```php
$edad = 18;
$mensaje = $edad >= 18 ? "Mayor de edad" : "Menor de edad";
```

### Operador Match (PHP 8+)

```php
$tipo = 2;
$resultado = match($tipo) {
    1 => "Administrador",
    2 => "Usuario",
    3 => "Invitado",
    default => "Desconocido"
};
```

## Novedades en Operadores de PHP 8.4

### Mejoras en el Operador Match

```php
// Ahora permite condiciones más complejas
$valor = 15;
$resultado = match(true) {
    $valor < 10 => "Bajo",
    $valor >= 10 && $valor < 20 => "Medio",
    $valor >= 20 => "Alto"
};

// Soporte mejorado para múltiples condiciones
$categoria = match($edad) {
    0, 1, 2 => "Bebé",
    3, 4, 5 => "Niño pequeño",
    default => "Otra categoría"
};
```

### Null Safe Operator Mejorado

```php
// Mejor soporte para arrays y propiedades
$valor = $objeto?->propiedad?->subpropiedad[0] ?? "default";

// Ahora funciona mejor con métodos que retornan void
$objeto?->metodoQueRetornaVoid();
```


### Mejoras en Operadores Aritméticos

```php
// Mejor manejo de errores en divisiones por cero
$resultado = @($a / 0); // Ahora con mejores mensajes de error

// Optimizaciones en operaciones con números grandes
$bigNumber = 10 ** 1000; // Mejor rendimiento
```

### Operadores con Tipos Mejorados

```php
// Mejor soporte para operaciones con tipos union
function procesar(int|float $a, int|float $b): int|float {
    return $a + $b; // Operador + ahora maneja mejor tipos mixtos
}
```

### Nuevos Operadores de Array (Propuestos)

```php
// array_merge ahora más eficiente con el operador spread
$array1 = [1, 2, 3];
$array2 = [4, 5, 6];
$resultado = [...$array1, ...$array2]; // Mejor rendimiento en PHP 8.4
```

### Mejoras en Operadores Lógicos

```php
// Short-circuit evaluation más eficiente
if ($a && $b && $c) {
    // Evaluación más rápida
}

// Mejor manejo de tipos en comparaciones
var_dump(0 == "0"); // true, pero con mejoras internas
```

## Precedencia de Operadores

```php
// Orden de evaluación (de mayor a menor precedencia)
// 1. ** (exponenciación)
// 2. ++ -- ~ (int) (float) (string) (array) (object) (bool) @
// 3. * / %
// 4. + - .
// 5. << >>
// 6. < <= > >=
// 7. == != === !== <=>
// 8. &
// 9. ^
// 10. |
// 11. &&
// 12. ||
// 13. ?? ?:
// 14. = += -= *= **= /= .= %= &= |= ^= <<= >>=
```

