<?php
error_reporting(0);
include_once ("classes/login/seguranca.php");
$_SESSION["pagina"] = "index";
?>
<HTML>
<HEAD>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width" charset="utf-8">
<title>::Dist. Ciclone::</title>
<link rel="icon" href="img/logo-ciclone.ico" type="image/x-icon" />
<!-- JQUERY e plugins -->
<script src="plugins/jquery-3.1.1.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="js/login.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-select.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/bootstrap-select.min.css">
<!-- CSS personalizados -->
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/style2.css" />
<link rel="stylesheet" type="text/css" href="css/style3.css" />
<script type="">
$(document).ready(function() {
	$("#limit").on("change", function() {
		this.form.submit();
	});
});
</script>
</HEAD>
<body>
	<?php
	if(usuarioLogado()){
		include_once ("modulos/menu.php");
		include_once ("modulos/alerta_vendas.php");
		include_once ("modulos/alerta_estoque.php");
	} else{
		include_once ("modulos/login.php");
	}
	?>
</body>
</HTML>