<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>





<!--  EDITAR PERFIL -->
<script>
function modalUploadExcel(tabela){
	document.getElementById("tabelaUsada").value = tabela;
	$("#modalUploadExcel").modal().show();
}
</script>


<form action="<c:url value='/upload/excel'/>" id="form" accept=".xlsx" method="post" enctype='multipart/form-data' accept-charset="utf-8" >
<div class="modal fade" id="modalUploadExcel" tabindex="-1" role="dialog" aria-labelledby="TituloModalCentralizado" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="TituloModalCentralizado">Upload Excel</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body input-group mb-3">
      	<div class="input-group mb-3">
  			<div>
  			Arquivo (.xlsx):
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="file" name="file" type="file" required>
			</div>
			<div class="input-group mb-3">
				<a href="/excel/produtos.xlsx">Exemplo da Planilha de Produtos</a> &nbsp-&nbsp
				<a href="/excel/usuarios.xlsx">Exemplo da Planilha de Usu�rios</a>
			<br>
				A aba da planilha deve conter o seguinte nome: Planilha1
			<br>
			</div>
		</div>
      </div>
      <div class="modal-footer">
      	 <input type="hidden" name="tabelaUsada" id="tabelaUsada">
      	 <input type="submit" name="submit" class="btn btn-primary" value="Enviar">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>
</form>
<!--  EDITAR PERFIL -->



