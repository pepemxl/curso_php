# Programación Orientada a Objectos con PHP

## Clases y Objetos

### Definición Básica

```php
class Usuario {
    // Propiedades
    public string $nombre;
    public string $email;
    private int $edad;
    
    // Constructor
    public function __construct(string $nombre, string $email, int $edad) {
        $this->nombre = $nombre;
        $this->email = $email;
        $this->edad = $edad;
    }
    
    // Métodos
    public function saludar(): string {
        return "Hola, soy {$this->nombre}";
    }
    
    public function getEdad(): int {
        return $this->edad;
    }
}

// Crear objeto
$usuario = new Usuario("Ana", "ana@email.com", 25);
echo $usuario->saludar();
```

### Modificadores de Acceso

```php
class EjemploAcceso {
    public $publico = "Acceso público";
    protected $protegido = "Acceso desde clase y herederas";
    private $privado = "Solo acceso desde esta clase";
    
    public function mostrarPrivado(): string {
        return $this->privado; // ✅ Acceso permitido
    }
}

$ejemplo = new EjemploAcceso();
echo $ejemplo->publico;    // ✅ Acceso permitido
// echo $ejemplo->protegido; // ❌ Error
// echo $ejemplo->privado;   // ❌ Error
```

### Herencia

```php
class Persona {
    public function __construct(
        protected string $nombre,
        protected int $edad
    ) {}
    
    public function presentarse(): string {
        return "Soy {$this->nombre} y tengo {$this->edad} años";
    }
}

class Empleado extends Persona {
    public function __construct(
        string $nombre,
        int $edad,
        private string $puesto,
        private float $salario
    ) {
        parent::__construct($nombre, $edad);
    }
    
    public function getInfoTrabajo(): string {
        return "Puesto: {$this->puesto}, Salario: \${$this->salario}";
    }
}

$empleado = new Empleado("Carlos", 30, "Desarrollador", 50000);
echo $empleado->presentarse(); // Soy Carlos y tengo 30 años
echo $empleado->getInfoTrabajo(); // Puesto: Desarrollador, Salario: $50000
```

### Polimorfismo

```php
interface Forma {
    public function area(): float;
    public function perimetro(): float;
}

class Cuadrado implements Forma {
    public function __construct(private float $lado) {}
    
    public function area(): float {
        return $this->lado * $this->lado;
    }
    
    public function perimetro(): float {
        return 4 * $this->lado;
    }
}

class Circulo implements Forma {
    public function __construct(private float $radio) {}
    
    public function area(): float {
        return pi() * $this->radio * $this->radio;
    }
    
    public function perimetro(): float {
        return 2 * pi() * $this->radio;
    }
}

function calcularForma(Forma $forma): array {
    return [
        'area' => $forma->area(),
        'perimetro' => $forma->perimetro()
    ];
}

$cuadrado = new Cuadrado(5);
$circulo = new Circulo(3);
print_r(calcularForma($cuadrado));
print_r(calcularForma($circulo));
```

### Abstracción

```php
abstract class Animal {
    public function __construct(protected string $nombre) {}
    
    abstract public function hacerSonido(): string;
    
    public function presentarse(): string {
        return "Soy un {$this->nombre}";
    }
}

class Perro extends Animal {
    public function hacerSonido(): string {
        return "¡Guau guau!";
    }
}

class Gato extends Animal {
    public function hacerSonido(): string {
        return "¡Miau miau!";
    }
}
```

### Encapsulamiento

```php
class CuentaBancaria {
    private float $saldo;
    private string $titular;
    
    public function __construct(string $titular, float $saldoInicial = 0) {
        $this->titular = $titular;
        $this->saldo = max(0, $saldoInicial);
    }
    
    public function depositar(float $monto): bool {
        if ($monto > 0) {
            $this->saldo += $monto;
            return true;
        }
        return false;
    }
    
    public function retirar(float $monto): bool {
        if ($monto > 0 && $this->saldo >= $monto) {
            $this->saldo -= $monto;
            return true;
        }
        return false;
    }
    
    public function getSaldo(): float {
        return $this->saldo;
    }
    
    public function getTitular(): string {
        return $this->titular;
    }
}
```

### Static Properties and Methods

```php
class Contador {
    private static int $instancias = 0;
    public static string $version = "1.0";
    
    public function __construct() {
        self::$instancias++;
    }
    
    public static function getInstancias(): int {
        return self::$instancias;
    }
    
    public static function reset(): void {
        self::$instancias = 0;
    }
}

$c1 = new Contador();
$c2 = new Contador();
echo Contador::getInstancias(); // 2
echo Contador::$version; // 1.0
```

### Traits

```php
trait Logger {
    public function log(string $mensaje): void {
        echo "[" . date('Y-m-d H:i:s') . "] $mensaje\n";
    }
}

trait Timestamps {
    public function getTimestamp(): string {
        return date('Y-m-d H:i:s');
    }
}

class Sistema {
    use Logger, Timestamps;
    
    public function procesar(): void {
        $this->log("Proceso iniciado a las " . $this->getTimestamp());
        // Lógica del proceso
        $this->log("Proceso completado");
    }
}
```

### Interfaces

```php
interface Authenticatable {
    public function login(string $usuario, string $password): bool;
    public function logout(): void;
    public function isAuthenticated(): bool;
}

interface Authorizable {
    public function hasPermission(string $permiso): bool;
    public function getRoles(): array;
}

class Usuario implements Authenticatable, Authorizable {
    private bool $autenticado = false;
    private array $roles = [];
    
    public function login(string $usuario, string $password): bool {
        // Lógica de autenticación
        $this->autenticado = true;
        return true;
    }
    
    public function logout(): void {
        $this->autenticado = false;
    }
    
    public function isAuthenticated(): bool {
        return $this->autenticado;
    }
    
    public function hasPermission(string $permiso): bool {
        // Lógica de permisos
        return in_array($permiso, ['read', 'write']);
    }
    
    public function getRoles(): array {
        return $this->roles;
    }
}
```

## Novedades en PHP 8.4

### Mejoras en Enums (PHP 8.1+)

```php
// Enums con métodos y casos
enum EstadoPedido: string {
    case PENDIENTE = 'pendiente';
    case PROCESANDO = 'procesando';
    case COMPLETADO = 'completado';
    case CANCELADO = 'cancelado';
    
    public function esFinal(): bool {
        return match($this) {
            self::COMPLETADO, self::CANCELADO => true,
            default => false
        };
    }
    
    public function getColor(): string {
        return match($this) {
            self::PENDIENTE => 'amarillo',
            self::PROCESANDO => 'azul',
            self::COMPLETADO => 'verde',
            self::CANCELADO => 'rojo'
        };
    }
}

// Uso mejorado en PHP 8.4
$estado = EstadoPedido::PROCESANDO;
echo $estado->value; // 'procesando'
echo $estado->esFinal(); // false
echo $estado->getColor(); // 'azul'

// Enums backed con mejor soporte
enum TipoUsuario: int {
    case ADMIN = 1;
    case USUARIO = 2;
    case INVITADO = 3;
    
    public static function fromValue(int $value): self {
        return match($value) {
            1 => self::ADMIN,
            2 => self::USUARIO,
            3 => self::INVITADO,
            default => throw new ValueError("Valor inválido: $value")
        };
    }
}
```

### Readonly Properties Mejoradas (PHP 8.2+)

```php
class Configuracion {
    public function __construct(
        public readonly string $nombre,
        public readonly array $opciones,
        public readonly DateTime $creadoEn
    ) {
        $this->creadoEn = new DateTime(); // ✅ Permitido en constructor
    }
    
    // PHP 8.4: Mejor soporte para métodos que retornan readonly
    public function getOpcionesReadonly(): readonly array {
        return $this->opciones;
    }
}

// PHP 8.4: Mejor integración con clases anónimas
$config = new class('mi_app') extends Configuracion {
    public function __construct(string $nombre) {
        parent::__construct($nombre, ['debug' => true], new DateTime());
    }
};
```

### Mejoras en Constructor Property Promotion

```php
// PHP 8.0: Promoción de propiedades del constructor
class Producto {
    public function __construct(
        public string $nombre,
        public float $precio,
        public readonly string $sku,
        private ?string $descripcion = null
    ) {}
}

// PHP 8.4: Mejor soporte para tipos complejos
class Pedido {
    public function __construct(
        public array $items,
        public readonly Usuario $usuario,
        public EstadoPedido $estado = EstadoPedido::PENDIENTE,
        public ?DateTime $fechaEntrega = null
    ) {
        $this->validarItems();
    }
    
    private function validarItems(): void {
        if (empty($this->items)) {
            throw new InvalidArgumentException("El pedido debe tener items");
        }
    }
}
```

### Nuevo Sistema de Atributos (Attributes)

```php
// Definición de atributos personalizados
#[Attribute(Attribute::TARGET_CLASS | Attribute::TARGET_METHOD)]
class Autenticado {
    public function __construct(
        public array $roles = [],
        public string $redirect = '/login'
    ) {}
}

#[Attribute(Attribute::TARGET_METHOD)]
class Ruta {
    public function __construct(
        public string $path,
        public string $method = 'GET'
    ) {}
}

// Uso en clases y métodos
#[Autenticado(roles: ['admin', 'user'])]
class ControladorUsuario {
    #[Ruta('/usuarios', 'GET')]
    public function listarUsuarios(): array {
        return ['usuarios' => []];
    }
    
    #[Ruta('/usuarios/{id}', 'GET')]
    #[Autenticado(roles: ['admin'])]
    public function obtenerUsuario(int $id): array {
        return ['usuario' => ['id' => $id]];
    }
}

// PHP 8.4: Mejor reflexión con atributos
$reflection = new ReflectionClass(ControladorUsuario::class);
$atributos = $reflection->getAttributes(Autenticado::class);

foreach ($atributos as $atributo) {
    $instancia = $atributo->newInstance();
    print_r($instancia->roles); // ['admin', 'user']
}
```

### Mejoras en Tipos Union y Intersection

```php
// PHP 8.4: Mejor soporte para tipos intersection
interface Loggeable {
    public function log(string $mensaje): void;
}

interface Cacheable {
    public function cache(): void;
}

class Servicio implements Loggeable, Cacheable {
    public function log(string $mensaje): void {
        // Implementación
    }
    
    public function cache(): void {
        // Implementación
    }
}

function procesarServicio(Loggeable&Cacheable $servicio): void {
    $servicio->log("Procesando servicio");
    $servicio->cache();
}

// PHP 8.4: Mejor inferencia de tipos en herencia
abstract class Repository {
    abstract public function find(int $id): object|null;
}

class UserRepository extends Repository {
    public function find(int $id): Usuario|null {
        // PHP 8.4 mejora la verificación de tipos de retorno
        return $this->buscarEnBD($id);
    }
}
```

### Mejoras en Métodos Mágicos

```php
class ContenedorDinamico {
    private array $datos = [];
    
    // PHP 8.4: Mejor manejo de métodos mágicos
    public function __get(string $nombre): mixed {
        return $this->datos[$nombre] ?? null;
    }
    
    public function __set(string $nombre, mixed $valor): void {
        $this->datos[$nombre] = $valor;
    }
    
    public function __call(string $metodo, array $argumentos): mixed {
        if (str_starts_with($metodo, 'get')) {
            $propiedad = strtolower(substr($metodo, 3));
            return $this->datos[$propiedad] ?? null;
        }
        throw new BadMethodCallException("Método $metodo no existe");
    }
    
    // PHP 8.4: __serialize y __unserialize mejorados
    public function __serialize(): array {
        return [
            'datos' => $this->datos,
            'metadata' => ['version' => '1.0', 'fecha' => time()]
        ];
    }
    
    public function __unserialize(array $data): void {
        $this->datos = $data['datos'] ?? [];
    }
}
```

### Mejoras en Genéricos (Propuestas)

```php
// PHP 8.4: Mejor soporte para patrones genéricos (experimental)
class Coleccion<T> {
    private array $elementos = [];
    
    public function agregar(T $elemento): void {
        $this->elementos[] = $elemento;
    }
    
    public function obtener(int $indice): T {
        return $this->elementos[$indice];
    }
    
    public function filtrar(callable $callback): Coleccion<T> {
        $filtrados = array_filter($this->elementos, $callback);
        $nuevaColeccion = new Coleccion();
        $nuevaColeccion->elementos = $filtrados;
        return $nuevaColeccion;
    }
}

// Uso con tipos específicos
$usuarios = new Coleccion<Usuario>();
$usuarios->agregar(new Usuario("Ana", "ana@email.com", 25));

$productos = new Coleccion<Producto>();
$productos->agregar(new Producto("Laptop", 999.99));
```

### Mejoras en Clases Anónimas

```php
// PHP 8.4: Mejor soporte para clases anónimas con constructores
interface Ejecutable {
    public function ejecutar(): mixed;
}

$tarea = new class('tarea_importante') implements Ejecutable {
    public function __construct(private string $nombre) {}
    
    public function ejecutar(): string {
        return "Ejecutando: {$this->nombre}";
    }
};

echo $tarea->ejecutar();

// Mejor integración con enums en clases anónimas
$procesador = new class extends EstadoPedido {
    public function procesar(EstadoPedido $estado): string {
        return match($estado) {
            self::PENDIENTE => 'En cola',
            self::PROCESANDO => 'Procesando',
            self::COMPLETADO => 'Finalizado',
            self::CANCELADO => 'Cancelado'
        };
    }
};
```

### Mejoras en Serialización

```php
// PHP 8.4: Serialización más segura y eficiente
class EntidadSegura implements Serializable {
    private string $claveSecreta;
    private array $datosSensibles;
    
    public function __construct() {
        $this->claveSecreta = bin2hex(random_bytes(32));
        $this->datosSensibles = ['token' => 'secreto'];
    }
    
    public function serialize(): string {
        return serialize([
            'datos' => $this->datosSensibles,
            'hash' => hash_hmac('sha256', serialize($this->datosSensibles), $this->claveSecreta)
        ]);
    }
    
    public function unserialize(string $data): void {
        $datos = unserialize($data);
        
        // Verificar integridad
        $hashCalculado = hash_hmac('sha256', serialize($datos['datos']), $this->claveSecreta);
        if (!hash_equals($datos['hash'], $hashCalculado)) {
            throw new RuntimeException("Datos corruptos");
        }
        
        $this->datosSensibles = $datos['datos'];
    }
}
```

### Mejoras en Rendimiento de POO

```php
// PHP 8.4: Optimizaciones internas para herencia múltiple vía traits
trait A {
    public function metodoA(): string { return "A"; }
}

trait B {
    public function metodoB(): string { return "B"; }
}

trait C {
    public function metodoC(): string { return "C"; }
}

class Optimizada {
    use A, B, C;
    
    // PHP 8.4 optimiza la resolución de conflictos en traits
    public function metodoA(): string {
        return "A mejorada: " . parent::metodoA();
    }
}

// Mejor rendimiento en llamadas a métodos
$objeto = new Optimizada();
for ($i = 0; $i < 1000000; $i++) {
    $objeto->metodoA(); // Más rápido en PHP 8.4
}
```

```php title="Buenas Prácticas en PHP 8.4" linenums="1"
// Usar propiedades readonly para inmutabilidad
final class ValorInmutable {
    public function __construct(
        public readonly string $id,
        public readonly mixed $valor,
        public readonly DateTime $creadoEn = new DateTime()
    ) {}
}

// Aprovechar enums para dominios definidos
enum TipoArchivo: string {
    case IMAGEN = 'image/jpeg';
    case PDF = 'application/pdf';
    case TEXTO = 'text/plain';
    
    public function getExtension(): string {
        return match($this) {
            self::IMAGEN => 'jpg',
            self::PDF => 'pdf',
            self::TEXTO => 'txt'
        };
    }
}

// Usar atributos para metadatos
#[Entidad(tabla: 'usuarios')]
class Usuario {
    #[Campo(tipo: 'string', longitud: 255)]
    public string $nombre;
    
    #[Campo(tipo: 'string', unico: true)]
    public string $email;
}
```

