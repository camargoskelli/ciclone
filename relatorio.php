<?php
include_once ("classes/login/seguranca.php");
$_SESSION["pagina"] = "relatorio";
$_SESSION["subpagina"] = "";
?>
<!DOCTYPE html>
<HTML>
<HEAD>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width" charset="utf-8">
<title>Dist. Ciclone</title>
<!-- JQUERY e plugins -->
<script src="plugins/jquery-3.1.1.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="js/bootstrap.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- CSS personalizados -->
<link rel="stylesheet" href="css/style2.css">
<link rel="stylesheet" href="css/style3.css">
</HEAD>
<body>
	<?php
	include_once ("modulos/menu.php");
	include_once ("modulos/controle_pagina.php");
	?>
</body>
</HTML>