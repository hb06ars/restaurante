<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!-- HEADER -->
<link href="script.js" rel="stylesheet" id="style">
<!-- HEADER -->
<jsp:include page="includes/modais/modalCategoria.jsp" />
<!-- TABELAS COM FILTRO -->
<jsp:include page="includes/jquery/filtro.jsp" />
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.2.min.js"></script> 
<script type="text/javascript" src="includes/jquery/script.js"></script>
<!-- TABELAS COM FILTRO -->
<!-- DOWNLOAD EXCEL -->
<jsp:include page="includes/jquery/excel/downloadExcel.jsp" />
<!-- DOWNLOAD EXCEL -->
<!-- UPLOAD EXCEL -->
<jsp:include page="includes/modais/modalUploadExcel.jsp" />
<!-- UPLOAD EXCEL -->


<div class="card mb-4">
	<div
		class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-1 border-bottom">
		<h1 class="h4">&nbsp&nbsp Categorias</h1>
		<c:if test="${usuarioSessao.perfil.admin}">
			<div class="col text-right">
	            <div style="cursor:pointer;background-color:blue; color:white" onclick="modalNovoCategoria()" class="icon icon-40 rounded-circle mb-2 "><span class="material-icons">library_add</span></div>
				<div style="cursor:pointer;background-color:green; color:white" onclick="tableToExcel('tabela', 'Documento')()" class="icon icon-40 rounded-circle mb-2"><span class="material-icons">text_snippet</span></div>
	        </div>
        </c:if>
	</div>
	<div class="card" >
		<div class="card-body p-4 border-0" style="overflow: auto; width: 100%">
			<div class="input-group mb-1">
				<table id="tabela" class="table table-striped table-bordered table-sm">
					<thead>
					<tr>
					<c:if test="${usuarioSessao.perfil.admin}">
						<th>Editar </th>
					</c:if> <th>Descrição</th>
					<c:if test="${usuarioSessao.perfil.admin}">
						<th>Excluir</th> 
					</c:if>
					<tr>
					<th></th>
					<th><input type="text" id="filtro1"/></th>
					<th></th>
					</tr>
					</thead>
					<tbody>
						<tr>
						<c:forEach items="${categorias}" var="c">
							<c:if test="${usuarioSessao.perfil.admin}">
								<td>
									<span class="material-icons" style="cursor:pointer" onclick="modalEditarCategoria('${c.id}','${c.descricao}')">create</span>
								</td>
							</c:if>
							<td>${c.descricao} 
							<c:if test="${usuarioSessao.perfil.admin}">
								<td>
									<span class="material-icons" style="cursor:pointer" onclick="modalDeletar('categoria', ${c.id})">delete_forever</span>
								</td>
							</c:if>
							<tr>	
						</c:forEach>
					</tbody>		
				</table>
			</div>
		</div>
	</div>
</div>








<!-- FOOTER -->
<jsp:include page="includes/barraFooter.jsp" />
<!-- FOOTER -->
<!-- FOOTER -->
<jsp:include page="includes/footer.jsp" />
<!-- FOOTER -->


