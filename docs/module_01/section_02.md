# Paradigmas de Programación en PHP

Contrario a lo que muchos programadores creen, PHP se ha actualizado con el tiempo permitiendo una variedad de los nuevos features y paradigmas de programación creados para lenguages modernos.

PHP, como lenguaje de programación, es **multiparadigma**, lo que significa que soporta varios paradigmas de programación, permitiendo a los programadores elegir el enfoque que mejor se adapte a sus necesidades.

## Paradigmas de Programación Soportados por PHP

1. **Programación Imperativa**
   - **Descripción**: Se basa en instrucciones explícitas que describen cómo debe ejecutarse el programa, paso a paso, manipulando directamente el estado del sistema. PHP, en sus inicios, era principalmente imperativo, especialmente para scripts web.
   - **Características en PHP**: Uso de bucles, condicionales y asignaciones directas.
   - **Ejemplo**:
     ```php
     <?php
     $sum = 0;
     for ($i = 1; $i <= 10; $i++) {
         $sum += $i;
     }
     echo "Suma: $sum"; // Salida: Suma: 55
     ?>
     ```

2. **Programación Orientada a Objetos (OOP)**
   - **Descripción**: Organiza el código en objetos que combinan datos (propiedades) y comportamientos (métodos). PHP tiene un soporte robusto para OOP desde la versión 5, con mejoras significativas en 7.x y 8.x.
   - **Características en PHP**: Clases, objetos, herencia, interfaces, traits, encapsulación, polimorfismo, y desde PHP 8, atributos (anotaciones).
   - **Ejemplo**:
     ```php
     <?php
     class Persona {
         private string $nombre;
         public function __construct(string $nombre) {
             $this->nombre = $nombre;
         }
         public function saludar(): string {
             return "Hola, soy $this->nombre";
         }
     }
     $persona = new Persona("Pepe");
     echo $persona->saludar(); // Salida: Hola, soy Pepe
     ?>
     ```

3. **Programación Funcional**
   - **Descripción**: Enfoca el código en funciones puras, evitando efectos secundarios y estado mutable. Aunque PHP no es un lenguaje funcional puro, desde la versión 7.4 y 8.x, se han incorporado características como funciones anónimas, cierres, funciones de orden superior y el operador arrow (`fn`).
   - **Características en PHP**: `array_map`, `array_filter`, `array_reduce`, funciones anónimas, y tipado estricto para funciones.
   - **Ejemplo**:
     ```php
     <?php
     declare(strict_types=1);
     $numeros = [1, 2, 3, 4];
     $cuadrados = array_map(fn(int $n): int => $n * $n, $numeros);
     print_r($cuadrados); // Salida: [1, 4, 9, 16]
     ?>
     ```

4. **Programación Procedural**
   - **Descripción**: Una variante de la programación imperativa que organiza el código en procedimientos o funciones que operan sobre datos. Es el estilo clásico de PHP para scripts rápidos y aplicaciones web simples.
   - **Características en PHP**: Funciones definidas con `function`, sin necesidad de clases.
   - **Ejemplo**:
     ```php
     <?php
     function calcularAreaCirculo(float $radio): float {
         return pi() * $radio * $radio;
     }
     echo calcularAreaCirculo(5); // Salida: 78.53
     ?>
     ```

5. **Programación Orientada a Eventos**
   - **Descripción**: El flujo del programa está determinado por eventos, como acciones del usuario o respuestas del sistema. Aunque PHP no es típicamente un lenguaje para aplicaciones orientadas a eventos (como JavaScript), se usa en frameworks como Laravel para manejar eventos y colas.
   - **Características en PHP**: Uso de sistemas de eventos en frameworks (e.g., Laravel Events) o librerías como `ReactPHP` para aplicaciones asíncronas.
   - **Ejemplo con Laravel** (simplificado):
     ```php
     <?php
     use Illuminate\Support\Facades\Event;
     Event::listen('user.registered', function ($user) {
         echo "Usuario registrado: {$user->name}";
     });
     Event::dispatch('user.registered', ['name' => 'Pepe']);
     ?>
     ```

6. **Programación Estructurada**
   - **Descripción**: Organiza el código en bloques lógicos (condicionales, bucles) evitando saltos descontrolados como `goto`. PHP lo soporta de forma nativa como evolución de su diseño imperativo.
   - **Características en PHP**: Uso de `if`, `switch`, `for`, `while` para estructurar el flujo.
   - **Ejemplo**:
     ```php
     <?php
     $numero = 5;
     if ($numero > 0) {
         echo "El número es positivo";
     } else {
         echo "El número es negativo o cero";
     }
     ?>
     ```

## **PHP 8.4 y Paradigmas**


PHP permite combinar paradigmas en un mismo proyecto. Por ejemplo, puedes usar OOP en un framework como Laravel y funciones procedurales para scripts rápidos.

PHP 8.4 (lanzado en noviembre de 2024) refuerza OOP y funcional con mejoras como tipos de unión más robustos, propiedades tipadas y JIT mejorado, lo que hace que la programación funcional y OOP sea más eficiente.




