# Variables de variables

Es una característica de PHP que permite usar el valor de una variable como nombre de otra variable.


Aunque es muy útil, en sake del mantenimiento para proyectos grandes recomiendo que usen diccionarios y eviten usar variables de variables.


## Sintaxis básica

```php title="Ejemplo de variables de variables"
$nombre = "edad";
$$nombre = 25; // Crea $edad = 25

echo $edad; // Output: 25
```

### Ejemplos prácticos

```php title="Ejemplo de variables dinámicas"
// Ejemplo 1: Variables dinámicas
$foo = "bar";
$bar = "Hola Mundo";
echo $$foo; // Output: Hola Mundo

// Ejemplo 2: Múltiples niveles
$a = "hello";
$$a = "world";
echo $hello; // Output: world

// Ejemplo 3: Con arrays
$var = "usuarios";
$$var = ["Juan", "María"];
print_r($usuarios); // Array con los usuarios
```

## Novedades en PHP 8.4

### Nuevo Modo de Autenticación HTTP

```php title="Novedades en 8.4"
// Nuevo sistema de autenticación HTTP nativo
$auth = new HttpAuthentication();
$user = $auth->getUser();
```

### Mejoras en el Sistema de Tipos

```php title="Novedades en 8.4"
// Tipos más estrictos en arrays
function procesar(array<int, string> $datos): array<string, int> {
    return array_flip($datos);
}
```

### Nuevas Funciones para Arrays

```php title="Novedades en 8.4"
$array = [1, 2, 3, 4, 5];

// array_find() - Encuentra el primer elemento que cumple condición
$resultado = array_find($array, fn($n) => $n > 3); // 4

// array_find_key() - Encuentra la primera clave que cumple condición
$clave = array_find_key($array, fn($k) => $k === 2); // 2
```

### Mejoras en JIT (Just-In-Time Compiler)

- Mejor optimización para aplicaciones de alto rendimiento
- Soporte mejorado para arquitecturas ARM

### Nuevas Funciones de String

```php title="Otras novedades"
$texto = "Hola Mundo PHP";

// str_contains() ahora más eficiente
if (str_contains($texto, "PHP")) {
    echo "Encontrado PHP";
}

// Nuevas funciones para manipulación de strings
$trimmed = str_trim_multiple("   texto   "); // Elimina espacios múltiples
```

### Mejoras en Sobrecarga de Métodos

```php title="Otras novedades"
class Calculadora {
    public function sumar(int|float ...$numeros): int|float {
        return array_sum($numeros);
    }
}
```

### Mejoras de Rendimiento

- Optimización del garbage collector
- Mejor manejo de memoria en aplicaciones de larga duración
- Reducción del consumo de memoria en arrays grandes

### Nuevo Sistema de Logs Integrado

```php title="Otras novedades en logs"
// Logger nativo mejorado
$logger = new PhpLogger();
$logger->info("Usuario conectado", ["user_id" => 123]);
```

### Mejoras en Enums

```php title="Otras novedades"
enum Estado: string {
    case ACTIVO = 'activo';
    case INACTIVO = 'inactivo';
    
    // Nuevos métodos disponibles
    public function esActivo(): bool {
        return $this === self::ACTIVO;
    }
}
```

### Ventajas

- Flexibilidad para crear nombres dinámicos
- Útil en ciertos patrones de metaprogramación

### Desventajas

- Dificulta el debugging
- Puede hacer el código menos legible
- Riesgos de seguridad si se usan con datos no confiables

### Alternativas recomendadas

```php
// En lugar de variables de variables, usar arrays
$datos = [];
$clave = "nombre";
$datos[$clave] = "Juan"; // Más seguro y mantenible
```

