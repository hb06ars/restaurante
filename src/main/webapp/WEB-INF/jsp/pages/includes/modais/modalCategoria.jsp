<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>




<!--  EDITAR Categoria -->
<script>
function modalEditarCategoria(categoriaID, descricao){
	document.getElementById("form").action = "/atualizarCategoria";
	document.getElementById("descricao").value = descricao;
	document.getElementById("descricao").required = true;
	document.getElementById("categoriaID").value = categoriaID;
	document.getElementById("alterarCategoria").value = '1';
	document.getElementById("salvarCategoria").value = '0';
	document.getElementById("pesquisarCategoria").value = '0';
	$("#modalEditarCategoria").modal().show();
}

function modalNovoCategoria(){
	document.getElementById("form").action = "/atualizarCategoria";
	document.getElementById("descricao").value = '';
	document.getElementById("descricao").readOnly = false;
	document.getElementById("descricao").required = true;
	document.getElementById("alterarCategoria").value = '0';
	document.getElementById("salvarCategoria").value = '1';
	document.getElementById("pesquisarCategoria").value = '0';
	$("#modalEditarCategoria").modal().show();
}


function modalPesquisarCategoria(){
	document.getElementById("form").action = "/pesquisarCategoria";
	document.getElementById("descricao").value = '';
	document.getElementById("descricao").readOnly = false;
	document.getElementById("descricao").required = false;
	document.getElementById("alterarCategoria").value = '0';
	document.getElementById("salvarCategoria").value = '0';
	document.getElementById("pesquisarCategoria").value = '1';
	$("#modalEditarCategoria").modal().show();
}
</script>


<form action="<c:url value='/atualizarCategoria'/>" id="form" method="post" >
<div class="modal fade" id="modalEditarCategoria" tabindex="-1" role="dialog" aria-labelledby="TituloModalCentralizado" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="TituloModalCentralizado">Categoria</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body input-group mb-3">
      	<div class="input-group mb-3">
  			<div>
  			Descrição:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="descricao" name="descricao" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		
      </div>
      <div class="modal-footer">
      	<input type="hidden" name="alterar" id="alterarCategoria" value="0">
      	<input type="hidden" name="salvar" id="salvarCategoria" value="0">
      	<input type="hidden" name="pesquisar" id="pesquisarCategoria" value="0">
      	<input type="hidden" name="categoriaID" id="categoriaID">
      	<input type="submit" name="submit" class="btn btn-primary" value="Ok">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>
</form>
<!--  EDITAR Categoria -->


