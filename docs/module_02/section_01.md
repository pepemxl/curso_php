# Variables en PHP

Como en casi todos los lenguajes de programación, PHP permite almacenar datos de distintos tipos en memoria.

Las zonas del código en las que podemos usar variables una vez definidas se llaman alcance, ámbito o contexto (scope).


## Definición y sintaxis de variables

### Reglas para nombrar variables:

- Los nombres de variables comienzan por el simbolo de dolar `$` y puede ser tan largo como quieras.
- Deben empezar con una letra (a-z, A-Z) o un guion bajo (`_`).
- Pueden contener letras, números (0-9) o guiones bajos.
- No se permiten espacios ni caracteres especiales (excepto `_`).
- Los nombres son sensibles a mayúsculas y minúsculas (`$nombre` es diferente de `$Nombre`).


```php title="Ejemplo"
$nombre = "Pepe";
$edad = 41;
$_otroValor = 99.99;
```

## Tipos de datos

PHP es un lenguaje de tipado dinámico, lo que significa que no necesitas declarar explícitamente el tipo de una variable, pero por favor haganlo si quieren que su código sea mantenible!, PHP lo infiere automáticamente según el valor asignado.

Los tipos de datos principales en PHP 8.4 son:

### Escalares

- `int`: Números enteros (ej. `$numero = 42;`)
- `float`: Números con decimales (ej. `$precio = 19.99;`)
- `string`: Cadenas de texto (ej. `$texto = "Hola mundo";`)
- `bool`: Verdadero o falso (ej. `$activo = true;`)

### Compuestos

- `array`: Colecciones de datos (ej. `$colores = ["rojo", "azul", "verde"];`)
- `object`: Instancias de clases (ej. `$objeto = new stdClass;`)

### Especiales

- `null`: Representa la ausencia de valor (ej. `$variable = null;`)
- `resource`: Recursos externos (como conexiones a bases de datos, menos común en PHP moderno).


Aunque posible en PHP, NO recomiendo que hagan lo siguiente en php:

```php title="Ejemplo de tipos dinámicos"
$variable = 42; // int
$variable = "Hola"; // string
$variable = 3.14; // float
$variable = null; // null
```


## Ámbito(Scope) de las variables

El ámbito determina desde dónde se puede acceder a una variable. En PHP, existen tres tipos principales de ámbitos:

### Global

Variables definidas fuera de funciones o clases. No son accesibles directamente dentro de funciones a menos que se usen palabras clave como `global` o el arreglo `$GLOBALS`.

```php title="Ejemplo de variable global" linenums="1"
$globalVar = "Soy global";

function mostrar() {
    global $globalVar; // Accede a la variable global
    echo $globalVar;
}
mostrar(); // Imprime: Soy global
```

### Local

Variables definidas dentro de una función. Solo son accesibles dentro de esa función.

```php title="Ejemplo de variable local" linenums="1"
function ejemplo() {
    $localVar = "Soy local";
    echo $localVar; // Imprime: Soy local
}
ejemplo();
// echo $localVar; // Error: $localVar no está definida fuera de la función
```

### Estático

Variables locales que conservan su valor entre llamadas a una función, usando la palabra clave `static`.

```php title="Ejemplo de variable estatico" linenums="1"
function contador() {
    static $cuenta = 0;
    $cuenta++;
    echo $cuenta;
}
contador(); // Imprime: 1
contador(); // Imprime: 2
```

## Variables por referencia

En PHP, las variables normalmente se pasan por valor, pero puedes pasarlas por referencia usando el símbolo `&`. Esto permite modificar la variable original.

```php title="Ejemplo de variable pasada por referencia" linenums="1"
$numero = 10;

function incrementar(&$valor) {
    $valor++;
}

incrementar($numero);
echo $numero; // Imprime: 11
```

## Variables predefinidas

PHP proporciona varias variables predefinidas (superglobals) que están disponibles en cualquier ámbito:

- `$GLOBALS`: Contiene todas las variables globales.
- `$_SERVER`: Información sobre el servidor y el entorno.
- `$_GET`, `$_POST`: Datos enviados por formularios o URLs.
- `$_SESSION`: Datos de la sesión del usuario.
- `$_COOKIE`: Datos almacenados en cookies.
- `$_FILES`: Archivos subidos por el usuario.
- `$_REQUEST`: Combina datos de `$_GET`, `$_POST` y `$_COOKIE`.

```php  title="Ejemplo de super variable" linenums="1"
echo $_SERVER['HTTP_HOST']; // Imprime el nombre del host del servidor
```

## Novedades en PHP 8.2 relacionadas con variables

PHP 8.2 introdujo varias características y mejoras que afectan el manejo de variables y su uso:

### Constantes en clases como tipos

Ahora puedes usar constantes de clase como tipos en parámetros, propiedades y retornos. Esto no afecta directamente a las variables, pero mejora el tipado en el contexto de objetos.

```php title="Ejemplo de const" linenums="1"
class MiClase {
    const ESTADO_ACTIVO = 'activo';
}

function procesar(string $estado = MiClase::ESTADO_ACTIVO) {
    echo $estado;
}
procesar(); // Imprime: activo
```

**Usa constantes para valores fijos**: En lugar de variables, usa `const` o `define()` para valores que no cambian.



### Mejoras en el tipado dinámico

PHP 8.2 sigue siendo dinámico, pero con un enfoque más estricto en el tipado estático opcional. Puedes declarar tipos explícitos para variables en clases o funciones, lo que reduce errores.

```php  title="Ejemplo de tipado explicito en clases" linenums="1"
class Persona {
    public string $nombre; // Tipado explícito
}

$persona = new Persona();
$persona->nombre = "Ana"; // Correcto
// $persona->nombre = 123; // Error: debe ser string
```

### Deprecation de variables dinámicas creadas con `${}`

En PHP 8.2, el uso de la sintaxis `${}` para crear variables dinámicas (como `${"variable"}`) está marcado como obsoleto, ya que puede generar código confuso.

  ```php title="Ejemplo de declaración deprecada" linenums="1"
  $nombre = "dinamica";
  ${$nombre} = "valor"; // Deprecado en PHP 8.2
  echo $dinamica; // Imprime: valor (pero genera advertencia)
  ```

### Null, true y false como tipos independientes

En PHP 8.2, `null`, `true` y `false` son tipos válidos por sí mismos, lo que permite un control más granular sobre las variables.

```php title="Ejemplo de null" linenums="1"
function devolverNull(): null {
    return null;
}
$resultado = devolverNull();
var_dump($resultado); // Imprime: NULL
```


**Ejemplo de constante:**
```php
define('IVA', 0.21);
$precio = 100;
$total = $precio + ($precio * IVA);
echo $total; // Imprime: 121
```



### Depuración y verificación de variables

PHP ofrece funciones útiles para inspeccionar variables:
- `var_dump($variable)`: Muestra el tipo y valor de una variable.
- `print_r($variable)`: Muestra una representación legible de una variable.
- `isset($variable)`: Verifica si una variable está definida y no es `null`.
- `empty($variable)`: Verifica si una variable está vacía.
- `unset($variable)`: Destruye una variable.


```php title="Ejemplo"
$nombre = "Juan";
var_dump($nombre); // Imprime: string(4) "Juan"
echo isset($nombre) ? "Definida" : "No definida"; // Imprime: Definida
unset($nombre);
echo isset($nombre) ? "Definida" : "No definida"; // Imprime: No definida
```


## Novedades de PHP 8.4 (update!)

### Desestructuración con claves literales en arrays

Ahora puedes usar claves literales directamente en la desestructuración:

```php
// PHP 8.3 y anteriores
$array = ['a' => 1, 'b' => 2];
['a' => $a, 'b' => $b] = $array;

// PHP 8.4 - más conciso
$array = ['a' => 1, 'b' => 2];
['a', 'b'] = $array;

echo $a; // 1
echo $b; // 2
```

### Propiedades typed constants en clases

Las constantes de clase ahora pueden tener tipos explícitos:

```php
class Config {
    public const int MAX_USERS = 100;
    public const string APP_NAME = "MiApp";
    public const array ALLOWED_ROLES = ['admin', 'user'];
    
    // También funciona con union types
    public const int|float MAX_FILE_SIZE = 5.5;
}
```

### Mejoras en el operador nullsafe (`?.`)

Ahora funciona de manera más consistente en expresiones complejas:

```php
$user = null;

// PHP 8.4 - más robusto
$country = $user?->getAddress()?->getCountry()?->getName();

// También en combinación con otros operadores
$code = $user?->getAddress()?->getCountry()?->getCode() ?? 'default';
```

### Mejor manejo de `$this` en contextos estáticos

Se ha mejorado el comportamiento de `$this` para prevenir errores:

```php
class Example {
    private static function staticMethod() {
        // PHP 8.4 detecta mejor este error
        return $this->instanceProperty; // Error más claro
    }
}
```

### Sensibilidad mejorada en análisis de variables

El motor ofrece mensajes de error más precisos:

```php
// PHP 8.4 da mejores mensajes de error
function test($param) {
    echo $param->undefinedProperty; // Mensaje más específico
    echo $undefinedVariable; // Detección mejorada
}
```

### Mejoras en `readonly` properties

Las propiedades readonly son más flexibles:

```php
class User {
    public readonly string $name;
    
    public function __construct(string $name) {
        $this->name = $name;
    }
    
    // Ahora se permite en más contextos
    public function updateFromArray(array $data): void {
        // Mejor manejo de propiedades readonly
    }
}
```

### Nuevas funciones para manejo de variables

Se han añadido funciones útiles:

```php
$data = ['name' => 'Juan', 'age' => 30];

// array_find_key - encuentra clave por callback
$key = array_find_key($data, fn($value) => $value === 'Juan');
echo $key; // 'name'

// Mejoras en array_column con objetos
$users = [/* array de objetos */];
$names = array_column($users, 'name'); // Más eficiente
```

## Mejor inferencia de tipos

El motor infiere tipos de variables más precisamente:

```php
// PHP 8.4 infiere tipos más específicos
function process($items) {
    $result = [];
    foreach ($items as $item) {
        $result[] = $item * 2; // Mejor inferencia del tipo de $result
    }
    return $result;
}
```

## Tratamiento de propiedades dinámicas

Mejor control sobre propiedades dinámicas en clases:

```php
#[AllowDynamicProperties]
class StrictClass {
    public string $name;
}

$obj = new StrictClass();
$obj->name = "Juan"; // OK
$obj->dynamicProp = "valor"; // Advertencia o error según configuración
```

