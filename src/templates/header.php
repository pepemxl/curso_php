<?php
// Start the session if needed
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proyecto PHP - <?php echo htmlspecialchars($pageTitle ?? 'Inicio'); ?></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }
        header {
            background-color: #2c3e50;
            color: white;
            padding: 1rem;
            text-align: center;
        }
        nav {
            background-color: #34495e;
            padding: 1rem;
        }
        nav a {
            color: white;
            text-decoration: none;
            margin: 0 1rem;
        }
        nav a:hover {
            text-decoration: underline;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
    </style>
</head>
<body>
    <header>
        <h1>Curso PHP </h1>
    </header>
    <nav>
        <a href="/index.php">Inicio</a>
        <?php
        $modules = glob('module_*', GLOB_ONLYDIR);
        foreach ($modules as $module) {
            $moduleName = basename($module);
            echo '<a href="/' . htmlspecialchars($moduleName) . '/index.php">' . htmlspecialchars($moduleName) . '</a>';
        }
        ?>
    </nav>
    <div class="container">