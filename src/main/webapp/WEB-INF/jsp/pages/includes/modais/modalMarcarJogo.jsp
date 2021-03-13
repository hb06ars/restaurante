<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<jsp:include page="../mascaras/mascaras.jsp" />

<!--  EDITAR FUNCIONARIO -->
<script>
function modalMarcarJogo(id, nome){
	document.getElementById("id_adv").value = id;
	document.getElementById("tituloNome").innerHTML = "Marcar jogo com "+nome+".";
	$("#modalMarcarJogo").modal().show();
}
</script>


<form action="<c:url value='/adversario'/>" id="formMarcarJogo" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<div class="modal fade" id="modalMarcarJogo" tabindex="-1" role="dialog" aria-labelledby="TituloModalCentralizado" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="TituloModalCentralizado">Marcar Jogo</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body input-group mb-3">
      	<div class="input-group mb-3">
  			<div>
  				Selecione a Data do Jogo:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="data" name="data" type="date" required aria-describedby="inputGroup-sizing-default">
			</div>
			<div>
  				Selecione a Hora do Jogo:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="hora" name="hora" type="time" required aria-describedby="inputGroup-sizing-default">
			</div>
			<div id="tituloNome">Marcar jogo.<br></div>
		</div>
      </div>
      <div class="modal-footer">
      	<input type="hidden" name="id_adv" id="id_adv" value="0" >
      	<input type="submit" name="submit" class="btn btn-primary" value="Confirmar">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>
</form>
<!--  EDITAR FUNCIONARIO -->


