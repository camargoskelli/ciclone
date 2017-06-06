<?php
include_once ("classes/login/seguranca.php");
$_SESSION["pagina"] = "venda";
$_SESSION["subpagina"] = "";
?>
<!DOCTYPE html>
<HTML>
<HEAD>
<meta name="viewport" charset="utf-8" content="initial-scale=1.0, maximum-scale=1.0, width=device-width">
<title>Dist. Ciclone</title>
<!-- JQUERY e plugins -->
<script src="plugins/jquery-3.1.1.min.js"></script>
<script src="plugins/masked-input-plugin.js"></script>
<script src="js/utilidades.js"></script>
<!-- Latest compiled JavaScript -->
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-select.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/bootstrap-select.min.css">
<!-- CSS personalizados -->
<link rel="stylesheet" href="css/style2.css">
<link rel="stylesheet" href="css/style3.css">
<link rel="stylesheet" href="css/style4.css">
<script src="js/venda_calculos.js"></script>
<script src="js/venda.js"></script>
<link href="css/select2.min.css" rel="stylesheet" />
<link href="css/dtl-style.css" rel="stylesheet" />
</HEAD>
<body>
	<?php
	include_once ("modulos/menu.php");
	include_once ("modulos/controle_pagina.php");
	?>
</body>
</HTML>