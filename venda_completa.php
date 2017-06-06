<?php
include_once ("classes/login/seguranca.php");
include_once ("classes/ClassExtra.php");
include_once ("classes/ClassVenda.php");
protegePagina();

$ClassExtra = new Extra();
$ClassVenda = new Venda();
if(! isset($_GET["ven_id"]) || $_GET["ven_id"] <= 0){
	exit();
}
?>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width" charset="utf-8">
<title>Dist. Ciclone</title>
<!-- JQUERY e plugins -->
<script src="plugins/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<style>
@media print {
   body {
      -webkit-print-color-adjust: exact;
   }
}

#main {
	margin: 20px;
}
</style>
<body>
	<?php
	$Venda = $ClassVenda->SelectVendaCompleta($_GET["ven_id"]);
	if(! $Venda){
		ECHO "Sem ID da venda";
		die();
	}
	//modal fade
	?>
	<div id="main">
		<table class="table">
			<tr>
				<th class="text-center" colspan=8><h4>Venda <?php ECHO $Venda[0];?></h4></th>
			</tr>
			<tr>
				<td colspan=3>Cliente: <?php ECHO $Venda[1];?></td>
				<td>Data: <?php ECHO $ClassExtra->InvertDateTimeFromMysql($Venda[4]);?></td>
			</tr>
			<tr>
				<td colspan=3>CNPJ: <?php ECHO $Venda[3];?></td>
				<td>CPF: <?php ECHO $Venda[2];?></td>
			</tr>
			<tr>
				<td colspan=3>Pagamento: <?php
				if($Venda[6] == 0){
					ECHO "dinheiro";
				} else if($Venda[6] == 1){
					ECHO "cartão débito";
				} else if($Venda[6] == 2){
					ECHO "cartão crédito";
				} else if($Venda[6] == 3){
					ECHO "cheque";
				}
				?>
			</td>
				<td>
			Parcelas:
			<?php
			if($Venda[5] == 1){
				ECHO "à vista";
			} else if($Venda[5] == 2){
				ECHO "20";
			} else if($Venda[5] == 3){
				ECHO "30";
			} else if($Venda[5] == 4){
				ECHO "40";
			}
			?>
			</td>
			</tr>
		</table>
		<table class="table text-center">
			<tr>
				<th class="text-center">ID</th>
				<th class="text-center">Produto</th>
				<th class="text-center">Qnt.</th>
				<th class="text-center">Valor Uni.</th>
				<th class="text-center">Total</th>
			</tr>
		<?php
		$dadosV = $ClassVenda->SelectVendaListaProdutos($_GET["ven_id"]);
		
		while($dadosV = $ClassVenda->RetornaLinha()){
			ECHO "<tr><td>";
			ECHO $dadosV[0] . "</td>";
			ECHO "<td>" . $dadosV[1] . "</td>";
			ECHO "<td>" . $dadosV[2] . "</td>";
			ECHO "<td>R$" . str_replace(".", ",", $dadosV[3]) . "</td>";
			ECHO "<td>R$" . str_replace(".", ",", $dadosV[4]);
			ECHO "</td></tr>";
		}
		?>
	</table>
		<table class="table">
			<tr>
				<th>Total:</th>
				<td>R$<?php ECHO str_replace(".", ",", $Venda[7]); ?></td>
			</tr>
		</table>
		<div style="margin-left: 10px;">
			<h4>Ass.:</h4>
			<div style="width: 99%; height: 1px; background: black !important; overflow: hidden;"></div>
		</div>
	</div>
</body>
</html>