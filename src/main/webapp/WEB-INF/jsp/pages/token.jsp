<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!-- HEADER -->
<!-- MODAL -->
<jsp:include page="includes/modais/modalToken.jsp" />
<!-- TABELAS COM FILTRO -->
<jsp:include page="includes/jquery/filtro.jsp" />
<script type="text/javascript" src="https://code.jquery.com/jquery-1.7.2.min.js"></script> 
<script type="text/javascript" src="includes/jquery/script.js"></script>
<link href="script.js" rel="stylesheet" id="style">
<!-- TABELAS COM FILTRO -->
<!-- UPLOAD EXCEL -->
<jsp:include page="includes/modais/modalDeletarTudo.jsp" />
<jsp:include page="includes/modais/modalUploadExcel.jsp" />
<!-- UPLOAD EXCEL -->


<div class="card mb-4">
<div
	class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h4">&nbsp&nbsp Tokens</h1>
	<div>
		<c:if test="${usuarioSessao.perfil.admin}">
			<button class="shadow btn btn-sm btn-outline-dark" onclick="modalNovoToken()"><span class="material-icons icon">person_add</span></button>
		</c:if>
		&nbsp&nbsp
	</div>
</div>


<div class="card" >
<div class="card-body p-2 border-0" style="overflow: auto; width: 100%">
	<table id="tabela" class="table-responsive table-striped table-sm">
		<thead>
		<tr>
		<th>Ativo</th> <th>ID</th><th>Acesso</th><th>Nome</th>
		
		<c:if test="${usuarioSessao.perfil.admin}">
			<th>Excluir</th> 
		</c:if>
		
		<tr>
			<th><input type="text" id="filtro1"/></th>
			<th><input style="min-width:40px;max-width:40px" type="text" id="filtro2"/></th>
			<th><input type="text" id="filtro3"/></th>
			<th><input type="text" id="filtro4"/></th>
		</tr>
		</thead>
		<tbody>
		<tr>
		<c:forEach items="${tokens}" var="t">
			<td><c:if test="${t.ativo}">Sim</c:if> <c:if test="${!t.ativo}">Não</c:if>
			<td>${t.id}
			<td>${t.acesso}
			<td>${t.nome}
			<c:if test="${usuarioSessao.perfil.admin}">
				<td><span class="material-icons icon" style="cursor:pointer" onclick="modalDeletar('token', ${t.id})" >delete</span></td>
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

