<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!-- HEADER -->
<!-- MODAL -->
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
	<h1 class="h4">&nbsp&nbspClassificação</h1>
	<div>
		<button class="shadow btn btn-sm btn-outline-dark" onclick="tableToExcel('tabela', 'Documento')"><span class="material-icons icon">save</span></button>
		&nbsp&nbsp
		<c:if test="${usuarioSessao.perfil.admin }">
			<button class="shadow btn btn-sm btn-outline-dark" onclick="modalDeletar('classificacao', 0)"><span class="material-icons icon">delete</span></button>
			&nbsp&nbsp
		</c:if>
	</div>
	
</div>


<div class="card" >
<div class="card-body p-0 border-0" style="overflow: auto; width: 100%">
	<table id="tabela" class="table-responsive table-striped table-sm">
		<thead>
		
		<tr>
		<th>Pos</th>
		<th><input type="text" id="filtro1"/></th>
		<th><input type="text" id="filtro2"/></th>
		<th>Pontos</th>
		<th>J&nbsp</th>
		<th>V&nbsp</th>
		<th>E&nbsp</th>
		<th>D&nbsp</th>
		<th>GP</th>
		<th>GC</th>
		<th>SG</th>
		</tr>
		
		</thead>
		<tbody>
		<tr><c:set var="pos" value="1"/>
		<c:forEach items="${classificacao}" var="c">
			<td> ${pos}
			<c:set var="tel" value="${c.jogador.telefone}" />
			<c:set var="tel" value="${fn:replace(tel,'(', '')}" />
			<c:set var="tel" value="${fn:replace(tel,')', '')}" />
			<c:set var="tel" value="${fn:replace(tel,' ', '')}" />
			<c:set var="tel" value="${fn:replace(tel,'-', '')}" />
			<td> <a href="https://wa.me/55${tel}" > ${c.jogador.nome} </a>
			<td> ${c.jogador.login}
			<td> ${c.pontos}
			<td> ${c.jogos}
			<td> ${c.vitorias}
			<td> ${c.empates}
			<td> ${c.derrotas}
			<td> ${c.gp}
			<td> ${c.gc}
			<td> ${c.sg}
			<tr>
		<c:set var="pos" value="${pos+1}"/>
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

