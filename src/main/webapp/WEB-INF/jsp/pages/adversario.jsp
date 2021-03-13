<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!-- HEADER -->
<!-- MODAL -->
<jsp:include page="includes/modais/modalMarcarJogo.jsp" />
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
	<h1 class="h4">&nbsp&nbspAdversário</h1>
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
		<c:if test="${usuarioSessao.perfil.admin}">
			<th>Excluir</th>
		</c:if>
		<th>Nome</th>
		<th>Login</th>
		<th>Marcar Jogo</th>
		<th>Disponibilidade</th>
		<th>Observação</th>
		</tr>
		
		<tr>
		<c:if test="${usuarioSessao.perfil.admin}">
			<th></th>
		</c:if>
		<th><input type="text" id="filtro1"/></th>
		<th><input type="text" id="filtro2"/></th>
		
		</thead>
		<tbody>
		
		<c:forEach items="${adversario}" var="a">
			<c:if test="${usuarioSessao.perfil.admin}">
				<td><span class="material-icons icon" style="cursor:pointer" onclick="modalDeletar('excluirUsuario', ${a.id})" >delete</span></td>
			</c:if>
			<c:set var="tel" value="${a.telefone}" />
			<c:set var="tel" value="${fn:replace(tel,'(', '')}" />
			<c:set var="tel" value="${fn:replace(tel,')', '')}" />
			<c:set var="tel" value="${fn:replace(tel,' ', '')}" />
			<c:set var="tel" value="${fn:replace(tel,'-', '')}" />
			<td> <a href="https://wa.me/55${tel}" > ${a.nome} </a>
			<td> ${a.login}
			<c:if test="${a.disponivel == true }">
				<td style="text-align: center;"> <span class="material-icons icon" onclick="modalMarcarJogo(${a.id},'${a.nome}')" style="cursor:default;color:green" >task_alt</span></td>
			</c:if>
			<c:if test="${a.disponivel == false }">
				<td style="text-align: center;"> <span class="material-icons icon" style="cursor:default;color:red" >unpublished</span></td>
			</c:if>
			<td> <fmt:formatDate pattern="dd/MM/yyyy" value="${a.dataDisponibilidade}" />
			<td> ${a.msg}
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

