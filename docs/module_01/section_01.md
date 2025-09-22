# PHP

## Qué es PHP?

PHP (acrónimo para PHP Hypertext Preprocessor) es un lenguaje de scripts generalista y Open Source, especialmente concebido para el desarrollo de aplicaciones web. PHP nacio a mediados de la década de 1990, como referencia python nacio en 1991. 


```php title="Ejemplo de código PHP" linenums="1"
<!DOCTYPE html>
<html>
<head>
<title>Ejemplo</title>
</head>
<body>

<?php
echo "Hola, soy un script PHP!";
?>

</body>
</html>
```

Las páginas PHP contienen fragmentos HTML con código que hace "algo". El código PHP está incluido entre una etiqueta de inicio `<?php` y una etiqueta de fin `?>` que permiten al servidor web pasar al `modo PHP`.

Lo que distingue a PHP de los lenguajes de script como JavaScript, es que el código se ejecuta del lado del servidor, generando así el HTML, que será luego enviado al cliente. 
El cliente solo recibe el resultado del "script", sin ningún medio de acceso al código que produjo dicho resultado. Se puede configurar el servidor web para que analice todos los ficheros HTML como ficheros PHP. Así, no hay manera de distinguir las páginas que son producidas dinámicamente de las páginas estáticas. 

 PHP está principalmente concebido para servir como lenguaje de script del lado del servidor, por lo que puede hacer todo lo que cualquier otro programa CGI puede hacer, como recolectar datos de formularios, generar contenido dinámico, o gestionar cookies. 

Hay dos ámbitos diferentes donde PHP puede destacar.

1. Lenguaje de script del lado del servidor. Este es el uso más tradicional, y también el principal objetivo de PHP. Tres componentes son necesarios para explotarlo: un analizador PHP (CGI o módulo del servidor), un servidor web y un navegador web.
2. Lenguaje de programación en línea de comandos. Un script PHP puede ser ejecutado en línea de comandos, sin la ayuda del servidor web y de un navegador. 


PHP soporta numerosos protocolos como LDAP, IMAP, SNMP, NNTP, POP3, HTTP, COM.
También puede abrir sockets de red, e interactuar con cualquier otro protocolo. PHP soporta el formato complejo WDDX, que permite la comunicación entre todos los lenguajes web. En términos de interconexión, PHP también soporta los objetos Java, y los utiliza de manera transparente como objetos integrados.



