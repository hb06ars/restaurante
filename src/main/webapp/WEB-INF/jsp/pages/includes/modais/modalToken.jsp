<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<jsp:include page="../mascaras/mascaras.jsp" />

<!--  EDITAR FUNCIONARIO -->
<script>
function modalNovoToken(){
	$("#modalEditarToken").modal().show();
}
</script>


<form action="<c:url value='/token'/>" id="formCriarToken" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<div class="modal fade" id="modalEditarToken" tabindex="-1" role="dialog" aria-labelledby="TituloModalCentralizado" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="TituloModalCentralizado">Criar Token</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body input-group mb-3">
      	<div class="input-group mb-3">
  			<div>
  			Nome:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="nome" name="nome" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Token de Acesso:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="acesso" name="acesso" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
      </div>
      <div class="modal-footer">
      	<input type="hidden" id="criarToken" name="criarToken" value="1">
      	<input type="submit" name="submit" class="btn btn-primary" value="Gerar">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>
</form>
<!--  EDITAR FUNCIONARIO -->


