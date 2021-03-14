<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>




<!--  EDITAR Usuario -->
<script>
function modalEditarUsuario(usuarioID, login, nome, telefone){
	document.getElementById("form").action = "/atualizarUsuario";
	document.getElementById("login").value = login;
	document.getElementById("login").required = login;
	document.getElementById("nome").value = nome;
	document.getElementById("nome").required = nome;
	document.getElementById("telefone").value = telefone;
	document.getElementById("usuarioID").value = usuarioID;
	document.getElementById("alterar").value = '1';
	document.getElementById("salvar").value = '0';
	document.getElementById("pesquisar").value = '0';
	$("#modalEditarUsuario").modal().show();
}

function modalNovoUsuario(){
	document.getElementById("form").action = "/atualizarUsuario";
	document.getElementById("login").value = '';
	document.getElementById("login").readOnly = false;
	document.getElementById("login").required = true;
	
	document.getElementById("nome").value = '';
	document.getElementById("nome").readOnly = false;
	document.getElementById("nome").required = true;
	
	document.getElementById("telefone").value = '';
	document.getElementById("telefone").readOnly = false;
	document.getElementById("telefone").required = true;
	
	document.getElementById("alterar").value = '0';
	document.getElementById("salvar").value = '1';
	document.getElementById("pesquisar").value = '0';
	$("#modalEditarUsuario").modal().show();
}


function modalPesquisarUsuario(){
	document.getElementById("form").action = "/pesquisarUsuario";
	document.getElementById("login").value = '';
	document.getElementById("login").readOnly = false;
	document.getElementById("login").required = false;
	
	document.getElementById("nome").value = '';
	document.getElementById("nome").readOnly = false;
	document.getElementById("nome").required = false;
	
	document.getElementById("telefone").value = '';
	document.getElementById("telefone").readOnly = false;
	document.getElementById("telefone").required = false;
	
	document.getElementById("alterar").value = '0';
	document.getElementById("salvar").value = '0';
	document.getElementById("pesquisar").value = '1';
	$("#modalEditarUsuario").modal().show();
}
</script>


<form action="<c:url value='/atualizarUsuario'/>" id="form" method="post" >
<div class="modal fade" id="modalEditarUsuario" tabindex="-1" role="dialog" aria-labelledby="TituloModalCentralizado" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="TituloModalCentralizado">Usuário</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body input-group mb-3">
      	<div class="input-group mb-3">
  			<div>
  			Login:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="login" name="login" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
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
  			Telefone:
  			</div>
  			<div class="input-group mb-3">
  				<input type="text" id="telefone" name="telefone" placeholder="Celular" maxlength="14" minlength="14" onkeydown="javascript: fMasc( this, mTel );" class="form-control" >
			</div>
		</div>
		
      </div>
      <div class="modal-footer">
      	<input type="hidden" name="alterar" id="alterar" value="0">
      	<input type="hidden" name="salvar" id="salvar" value="0">
      	<input type="hidden" name="pesquisar" id="pesquisar" value="0">
      	<input type="hidden" name="usuarioID" id="usuarioID">
      	<input type="submit" name="submit" class="btn btn-primary" value="Ok">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>
</form>
<!--  EDITAR Usuario -->


