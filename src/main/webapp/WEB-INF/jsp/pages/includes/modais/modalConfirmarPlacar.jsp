<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<jsp:include page="../mascaras/mascaras.jsp" />
<jsp:include page="../jquery/excel/downloadExcel.jsp" />

<!--  EDITAR Recado -->
<script>
var pl1_anterior = 0;
var pl2_anterior = 0;

function modalConfirmaPlacar(id){
	pl1_anterior = 0;
	pl2_anterior = 0;
	document.getElementById("placar_jogador1").value = pl1_anterior;
	document.getElementById("placar_jogador2").value = pl2_anterior;
	
	var codigo = 0;
	<c:forEach items="${meusJogos}" var="r">
		codigo =  ${r.id};
		if(codigo == id){
			document.getElementById("jogador1").innerHTML = "${r.jogador1.nome}";
			document.getElementById("jogador2").innerHTML = "${r.jogador2.nome}";
			document.getElementById("adv_jogador1").innerHTML = "${r.jogador1.nome}";
			document.getElementById("adv_jogador2").innerHTML = "${r.jogador2.nome}";
			document.getElementById("adv_jogador1_placar").value = "${r.jogador1_placar}";
			document.getElementById("adv_jogador2_placar").value = "${r.jogador2_placar}";
			document.getElementById("id").value = "${r.id}";
			
			var jog1 = ${r.confirmado_jogador1}
			var jog2 = ${r.confirmado_jogador2}
			if(!jog1 && !jog2){
				document.getElementById("texto_confirmacaoAdversario").style.display = "none";
				document.getElementById("texto_confirmacaoAdversario2").style.display = "none";
				document.getElementById("btEnviar").style.display = "block";
				document.getElementById("texto_confirmacao2").style.display = "block";
				document.getElementById("informacao").innerHTML = "<b>AGUARDE A CONFIRMAÇÃO DO ADVERSÁRIO ABAIXO:</b>";
				document.getElementById("btConcordar").style.display = "none";
				document.getElementById("btRejeitar").style.display = "none";
			}
			else if((jog1 && ${r.jogador1.id == usuarioSessao.id}) || (jog2 && ${r.jogador2.id == usuarioSessao.id})){
				document.getElementById("informacao").innerHTML = "<b>AGUARDE A CONFIRMAÇÃO DO ADVERSÁRIO ABAIXO:</b>";
				document.getElementById("texto_confirmacaoAdversario").style.display = "block";
				document.getElementById("texto_confirmacaoAdversario2").style.display = "block";
				document.getElementById("texto_confirmacao2").style.display = "none";
				document.getElementById("btEnviar").style.display = "none";
				document.getElementById("btConcordar").style.display = "none";
				document.getElementById("btRejeitar").style.display = "none";
			} else{
				document.getElementById("btEnviar").style.display = "none";
				document.getElementById("informacao").innerHTML = "<b>PLACAR QUE TE ENVIARAM:</b>";
				document.getElementById("texto_confirmacaoAdversario2").style.display = "block";
			}
			
			
			
			
			
			
			
			
		}
	</c:forEach>
	
	$("#modalConfirmarPlacar").modal().show();
}


function passarMouseConcordar(){
	pl1_anterior = document.getElementById("placar_jogador1").value;
	pl2_anterior = document.getElementById("placar_jogador2").value;
	document.getElementById("placar_jogador1").value = document.getElementById("adv_jogador1_placar").value;
	document.getElementById("placar_jogador2").value = document.getElementById("adv_jogador2_placar").value;
}

function sairMouseConcordar(){
	document.getElementById("placar_jogador1").value = pl1_anterior;
	document.getElementById("placar_jogador2").value = pl2_anterior;
}

function concordar(){
	document.getElementById("concordar").value = 1;
	document.getElementById("formPlacar").submit();
}

function rejeitar(){
	document.getElementById("concordar").value = 0;
	document.getElementById("formPlacar").submit();
}


</script>


<form action="<c:url value='/meusJogos'/>" id="formPlacar" method="post" enctype="multipart/form-data" accept-charset="UTF-8" >
<div class="modal fade" id="modalConfirmarPlacar" tabindex="-1" role="dialog" aria-labelledby="TituloModalCentralizado" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
			    <h5 class="modal-title" id="TituloModalCentralizado">Confirmação de Placar</h5>
			    <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
			    	<span aria-hidden="true">&times;</span>
				</button>
		    </div>
			<div id="texto_confirmacao2" class="modal-body input-group mb-12 col-lg-12">
		  		<div class="row">
					<div class="col-lg-4 text-center">
						<div id="jogador1">JOGADOR 1:</div>
						<input class="form-control text-center" id="placar_jogador1" name="placar_jogador1" type="number" min=0 value="0" required aria-describedby="inputGroup-sizing-default">
					</div>
					<div class="col-lg-4 text-center">X</div>
					<div class="col-lg-4 text-center">
						<div id="jogador2">JOGADOR 2:</div>
						<input class="form-control text-center" id="placar_jogador2" name="placar_jogador2" type="number" min=0 value="0" required aria-describedby="inputGroup-sizing-default">
					</div>
				</div>
			</div>
			
			<div id="texto_confirmacaoAdversario" class="modal-body input-group mb-12 col-lg-12">
		  		<div class="row">
					<div id="informacao" class="col-lg-12 text-center">
						<b>AGUARDE A CONFIRMAÇÃO DO ADVERSÁRIO ABAIXO:</b>						
					</div>
				</div>
			</div>
			
			<div id="texto_confirmacaoAdversario2" class="modal-body input-group mb-12 col-lg-12">
		  		<div class="row">
					<div class="col-lg-4 text-center">
						<div id="adv_jogador1">JOGADOR 1:</div>
						<input class="form-control text-center" id="adv_jogador1_placar" type="text" value="?" disabled aria-describedby="inputGroup-sizing-default">
					</div>
					<div class="col-lg-4 text-center">X</div>
					<div class="col-lg-4 text-center">
						<div id="adv_jogador2">JOGADOR 2:</div>
						<input class="form-control text-center" id="adv_jogador2_placar" type="text" value="?" disabled aria-describedby="inputGroup-sizing-default">
					</div>
				</div>
			</div>
			
			<div class="modal-footer">
				<input type="hidden" name="concordar" id="concordar">
				<input type="hidden" name="id" id="id">
				<span id="btEnviar" onclick="concordar()" class="btn btn-secondary" >Enviar</span>
			    <span id="btConcordar" onmouseover="passarMouseConcordar()" onmouseout="sairMouseConcordar()" onclick="concordar()" class="btn btn-primary" >Concordar</span>
			    <span id="btRejeitar" onclick="rejeitar()" class="btn btn-danger" >Rejeitar</span>
			</div>
		</div>
	</div>
</div>
</form>
<!--  EDITAR Recado -->


