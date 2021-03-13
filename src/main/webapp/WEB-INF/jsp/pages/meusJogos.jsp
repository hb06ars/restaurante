<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!-- HEADER -->
<!-- MODAL -->
<jsp:include page="includes/modais/modalConfirmarPlacar.jsp" />
<!-- TABELAS COM FILTRO -->
<jsp:include page="includes/jquery/filtro.jsp" />
<script type="text/javascript" src="https://code.jquery.com/jquery-1.7.2.min.js"></script> 
<script type="text/javascript" src="includes/jquery/script.js"></script>
<link href="script.js" rel="stylesheet" id="style">
<!-- TABELAS COM FILTRO -->
<!-- DOWNLOAD EXCEL -->
<jsp:include page="includes/jquery/excel/downloadExcel.jsp" />
<!-- DOWNLOAD EXCEL -->

<div class="card mb-4">
<div
	class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h4">&nbsp&nbsp Meus Jogos</h1>
	<div>
		<button class="shadow btn btn-sm btn-outline-dark" onclick="tableToExcel('tabela', 'Documento')"><span class="material-icons icon">save</span></button>
		&nbsp&nbsp
	</div>
</div>


<div class="card" >
<div class="card-body p-0 border-0" style="overflow: auto; width: 100%">
	<table id="tabela" class="table-responsive table-striped table-sm">
		<thead>
		<tr>
		<th style="text-align: center;">Validado</th>
		<th style="text-align: center;">Data</th>
		<th style="text-align: center;">Mandante</th>
		<th style="text-align: center;">Placar</th>
		<th>X</th>
		<th style="text-align: center;">Placar</th>
		<th style="text-align: center;">Visitante</th>
		
		<th>Confirmação do Placar</th>
		<th>Cancelar jogo</th>
		
		<tr>
		<th><input style="min-width:40px;max-width:40px" type="text" id="filtro1"/></th>
		<th><input type="text" id="filtro2"/></th>
		<th><input type="text" id="filtro3"/></th>
		<th><input style="min-width:40px;max-width:40px" type="text" id="filtro4"/></th>
		<th>X</th>
		<th><input style="min-width:40px;max-width:40px" type="text" id="filtro5"/></th>
		<th><input type="text" id="filtro6"/></th>
		
		<th></th>
		</tr>
		
		</thead>
		<tbody>
		<tr>
		
		
		
		<c:forEach items="${meusJogos}" var="r">
			<c:if test="${r.confirmado_jogador1 == true && r.confirmado_jogador2 == true }">
				<td style="min-width:40px;max-width:40px; color:blue"> Sim
			</c:if>
			<c:if test="${r.confirmado_jogador1 == false || r.confirmado_jogador2 == false }">
				<td style="min-width:40px;max-width:40px; color:red"> Não
			</c:if>
			
			<td> ${r.dataAjustada}
			<td style="text-align: center;">
				<c:set var="tel" value="${r.jogador1.telefone}" />
				<c:set var="tel" value="${fn:replace(tel,'(', '')}" />
				<c:set var="tel" value="${fn:replace(tel,')', '')}" />
				<c:set var="tel" value="${fn:replace(tel,' ', '')}" />
				<c:set var="tel" value="${fn:replace(tel,'-', '')}" />
				<a href="https://wa.me/55${tel}" > ${r.jogador1.nome} </a>
			<td style="text-align: center;">
				<c:if test="${r.confirmado_jogador1 == true && r.confirmado_jogador2 == true}">${r.jogador1_placar}</c:if>
				<c:if test="${r.confirmado_jogador1 == false || r.confirmado_jogador2 == false}">?</c:if>
			<td style="text-align: center;"> X
			<td style="text-align: center;"> 
				<c:if test="${r.confirmado_jogador1 == true && r.confirmado_jogador2 == true}">${r.jogador2_placar}</c:if>
				<c:if test="${r.confirmado_jogador1 == false || r.confirmado_jogador2 == false}">?</c:if>
			<td style="text-align: center;"> 
				<c:set var="tel" value="${r.jogador2.telefone}" />
				<c:set var="tel" value="${fn:replace(tel,'(', '')}" />
				<c:set var="tel" value="${fn:replace(tel,')', '')}" />
				<c:set var="tel" value="${fn:replace(tel,' ', '')}" />
				<c:set var="tel" value="${fn:replace(tel,'-', '')}" />
				<a href="https://wa.me/55${tel}" > ${r.jogador2.nome} </a>
			
			<c:if test="${r.confirmado_jogador1 == true && r.confirmado_jogador2 == true }">
				<td style="text-align: center;"> <span class="material-icons icon" style="cursor:default;color:green" >thumb_up_alt</span></td>
			</c:if>
			<c:if test="${r.confirmado_jogador1 == false || r.confirmado_jogador2 == false }">
				<td style="text-align: center;"> <span class="material-icons icon" style="cursor:default;" onclick="modalConfirmaPlacar(${r.id})" >pending</span></td>
			</c:if>
	
			<c:if test="${r.data gt now && (r.confirmado_jogador1 == false || r.confirmado_jogador2 == false)}">
				<td style="text-align: center;" ><span class="material-icons icon" style="cursor:pointer" onclick="modalDeletar('meusJogos', ${r.id})" >delete</span></td>
			</c:if>
			<c:if test="${r.data lt now}">
				<td style="text-align: center;" ></td>
			</c:if>
			<tr>	
		</c:forEach>
		</tbody>
	</table>
	</div>
</div>

<br>

</div>

<!-- FOOTER -->
<jsp:include page="includes/barraFooter.jsp" />
<!-- FOOTER -->
<!-- FOOTER -->
<jsp:include page="includes/footer.jsp" />
<!-- FOOTER -->

