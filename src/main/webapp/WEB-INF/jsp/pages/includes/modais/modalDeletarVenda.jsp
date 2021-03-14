<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>



<!--  DELETAR PERFIL -->
<script>
function modalDeletarVenda(campo, id){
	document.getElementById("tabelaExclusao").value = campo;
	document.getElementById("idExclusao").value = id;
	$("#modalDeletarVenda").modal().show();
}

function confirmaDeleteVenda(){
	var tabela = document.getElementById("tabelaExclusao").value; 
	var id = document.getElementById("idExclusao").value;
	window.location.href = "deletandoVenda/"+tabela+"/"+id;
}

</script>
<div class="modal fade" id="modalDeletarVenda" tabindex="-1" role="dialog" aria-labelledby="TituloModalCentralizado" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="TituloModalCentralizado">Exclus�o</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	Tem certeza que deseja excluir?
      </div>
      <div class="modal-footer">
      	 <input type="hidden" id="tabelaExclusao">
      	 <input type="hidden" id="idExclusao">
        <button type="button" class="btn btn-danger" id="deletar" onclick="confirmaDeleteVenda()" data-dismiss="modal">Sim</button>
        <button type="button" class="btn btn-primary" id="deletar" data-dismiss="modal">N�o</button>
      </div>
    </div>
  </div>
</div>
<!--  DELETAR PERFIL -->
