</div>
    <footer style="background-color: #2c3e50; color: white; text-align: center; padding: 1rem; position: relative; bottom: 0; width: 100%;">
        <p>&copy; <?php echo date('Y'); ?> Curso PHP. Todos los derechos reservados. Desarrollado por Pepe</p>
    </footer>
</body>
</html>
<?php
if (isset($db)) {
    $db->close();
}
?>