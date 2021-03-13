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
<!-- UPLOAD EXCEL -->

<script>
alterar(){
	document.getElement.ById("alterar").value="1"
	document.getElement.ById("formSenha").submit()
}
</script>


<form action="<c:url value='/senha'/>" id="formSenha" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
	<div class="card mb-4">
	<div
		class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
		<h1 class="h4">&nbsp&nbsp Alterar a senha</h1>
	</div>
	<div class="card" >
		<div class="card-body p-4 border-0" style="overflow: auto; width: 100%">
			<div>
				<div class="input-group mb-1">
		  			<div>
		  			Senha Atual:
		  			</div>
		  			<div class="input-group mb-1">
		  				<input class="form-control" id="senhaAtual" name="senhaAtual" type="password" required aria-describedby="inputGroup-sizing-default">
					</div>
				</div>
				<div class="input-group mb-1">
		  			<div>
		  			Nova Senha:
		  			</div>
		  			<div class="input-group mb-1">
		  				<input class="form-control" id="novaSenha" name="novaSenha" type="password" required aria-describedby="inputGroup-sizing-default">
					</div>
				</div>
				<div class="input-group mb-1">
		  			<div>
		  			Confirme a nova Senha:
		  			</div>
		  			<div class="input-group mb-1">
		  				<input class="form-control" id="confirmaSenha" name="confirmaSenha" type="password" required aria-describedby="inputGroup-sizing-default">
					</div>
				</div>
	      	</div>
		      <div class="modal-footer">
		      	<input type="hidden" id="alterar" name="alterar" value="1">
		      	<button onclick="alterar()" class="btn btn-primary" >Alterar</button>
		      </div>
		</div>
		
		</div>
	</div>
</form>




<br>
</div>

<!-- FOOTER -->
<jsp:include page="includes/barraFooter.jsp" />
<!-- FOOTER -->
<!-- FOOTER -->
<jsp:include page="includes/footer.jsp" />
<!-- FOOTER -->

