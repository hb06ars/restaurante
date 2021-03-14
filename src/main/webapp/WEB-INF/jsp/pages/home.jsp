<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!-- HEADER -->
<!-- MODAL -->
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
<jsp:include page="includes/modais/modalInserirCliente.jsp" />

<style>
.zoom {
  transition: transform .2s;
}
.zoom:hover {
  -ms-transform: scale(1.1); /* IE 9 */
  -webkit-transform: scale(1.1); /* Safari 3-8 */
  transform: scale(1.1); 
}
.nota {
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.6);
  transition: 0.3s;
  border-radius: 10px; /* 5px rounded corners */
}
</style>



<script>

var global_mesa = "";
var global_categoria = "";
var global_produto = "";

var data = new Date(),
dia  = data.getDate().toString(),
diaF = (dia.length == 1) ? '0'+dia : dia,
mes  = (data.getMonth()+1).toString(), //+1 pois no getMonth Janeiro começa com zero.
mesF = (mes.length == 1) ? '0'+mes : mes,
anoF = data.getFullYear(),
valor = diaF+"/"+mesF+"/"+anoF;
var hora = data.getHours() + "h" + data.getMinutes() + "m"+ " - OP: ${usuarioSessao.nome}" ;
var random = Math.floor(Math.random() * 100);
var pedido = anoF+mesF+diaF+data.getHours()+data.getMinutes()+data.getSeconds()+random;



function inicio(){
	window.location.href = "/home";
}


function mesa(mesa){
	global_mesa = mesa;
	document.getElementById("mesa_pedido").innerHTML = global_mesa;
	document.getElementById("lista").style.display = "none";
	document.getElementById("mesa").style.display = "none";
	document.getElementById("produto").style.display = "none";
	document.getElementById("categoria").style.display = "block";
	document.getElementById("txt_mesa").innerHTML = "Mesa "+global_mesa;
	var table = document.getElementById("notaListaProdutos");
	var linhas = parseInt(table.getElementsByTagName('tr').length);
	if(linhas > 4){
		for(var i = 4; i < (linhas - 1); i++){
			table.deleteRow(i);
		}
	}
	
	var cont = 4;
	
	<c:forEach items="${vendas}" var="v" varStatus="loop">
		var index = '${vendas[loop.count].mesa.numeroDaMesa}'
		if(index < 2 || index == '' || index == null){
			index = 1
		}
		
		if('${v.mesa.numeroDaMesa}' == global_mesa){
			var row = table.insertRow(cont);
			var cell0 = row.insertCell(0);
			var cell1 = row.insertCell(1);
			var cell2 = row.insertCell(2);
			var cell3 = row.insertCell(3);
			var cell4 = row.insertCell(4);
			var cell5 = row.insertCell(5);
			
			cell0.innerHTML = ${v.produtos.codigo};
			cell1.innerHTML = '${v.produtos.descricao}';
			cell2.innerHTML = '${v.precoUnit_str}';
			cell3.innerHTML = ${v.quantidade};
			cell4.innerHTML = '${v.subtotal_str}';
			cell5.innerHTML = "<span class='material-icons' style='cursor:pointer' onClick='removerCelula(\"${v.produtos.codigo }\")'>delete_forever</span>";
			cont++;
		}
		
	</c:forEach>
	
	calcularTotal();
	
}

function voltaCategoria(){
	document.getElementById("lista").style.display = "none";
	document.getElementById("categoria").style.display = "block";
	document.getElementById("produto").style.display = "none";
}

function categoria(categoria){
	document.getElementById("lista").style.display = "none";
	global_categoria = categoria;
	document.getElementById("categoria").style.display = "none";
	document.getElementById("produto").style.display = "block";
	document.getElementById("txt_categoria").innerHTML = "Mesa: "+global_mesa+" - Categoria: "+global_categoria;
	document.getElementById('listaProdutos').innerHTML = "";
	var d1 = document.getElementById('listaProdutos');
	
	<c:set var="categ" value=""/>
	<c:forEach items="${categorias}" var="ca" varStatus="loop">
		var index = '${ca.descricao}'
		if(index == global_categoria){
			<c:set var="categ" value="${ca.descricao}"/>
			d1.insertAdjacentHTML('beforeend',
			"<c:forEach items='${produtos }' var='p' varStatus="loopNovo">"
				+ "<c:if test='${fn:toUpperCase(p.categoria.descricao) eq categ }'>"
					+"<div class='col-6 col-md-3' >"
						+"<div onclick='adiciona(${p.id },${p.codigo },${p.valor }, \"${p.descricao }\")' class='card border-0 mb-4'>"
							+"<div class='card-body' >"
								+"<div class='avatar avatar-60 bg-default-light rounded-circle text-default'>"
									+"<i class='material-icons vm md-36 text-template'>fastfood</i>"
								+"</div>"
								+"<p class='mt-3 mb-0 font-weight-normal'><b>${p.descricao } </b></p>"
								+"<p class='text-dark medium'>R$<fmt:formatNumber value='${p.valor }' type='currency' currencySymbol=''/></p>"
							+"</div>"
						+"</div>"
					+"</div>"
				+ "</c:if>"
			+"</c:forEach>"
			);
			
		}
	</c:forEach>
	
	
}


function lista(){

	<c:forEach items="${vendas }" var="v">
		if(${v.mesa.numeroDaMesa} == global_mesa && ${v.mesa.ocupada == true}){
			pedido = ${v.pedido}
		}
	</c:forEach>

	document.getElementById("notaData").innerHTML = valor + " - " + hora;
	document.getElementById("numPedido").innerHTML = pedido;

	document.getElementById("mesa").style.display = "none";
	document.getElementById("categoria").style.display = "none";
	document.getElementById("produto").style.display = "none";
	document.getElementById("lista").style.display = "block";
	
}

function redirecionar(pagina){
	window.location.href = "/"+pagina;
}

function adiciona(id,codigo,valor,descricao){
		var id_Produto = id;
		var nome_Produto = descricao;
		var codigo_Produto = codigo;
		var valor_Produto = valor.toFixed([2]);
		var qtd = 1;
		
		document.getElementById("subTotalSelecionado").value = valor_Produto * qtd;
		var subtotal = document.getElementById("subTotalSelecionado").value;
		
		var codigo = codigo_Produto;
		var table = document.getElementById("notaListaProdutos");
		var linhas = table.getElementsByTagName('tr').length;
		mensagemProduto('Produto', nome_Produto+' ADICIONADA!');	
		
		var repetido = 0;
		for(var i = 0; i < linhas; i++){
			try{
				var str = table.rows[i].cells[0].innerHTML;
				if( str == codigo_Produto ){
					repetido = 1;
					/*Quando o produto for repetido.*/
					var qtdAtual = table.rows[i].cells[3].innerHTML;
					table.rows[i].cells[3].innerHTML = parseInt(qtd) + parseInt(qtdAtual);
					var subTotalAtual = parseFloat(table.rows[i].cells[4].innerHTML).toFixed([2]);
					table.rows[i].cells[4].innerHTML = parseFloat(parseFloat(subtotal) + parseFloat(subTotalAtual)).toFixed([2]);
					total = parseFloat(document.getElementById("totalVenda").innerHTML);
					subtotal = parseFloat(table.rows[i].cells[4].innerHTML);	
					/*Fim quando produto for repetido*/
				}
			}catch(e){}
		}
		if(repetido == 0){
			var row = table.insertRow(linhas-1);
			var cell0 = row.insertCell(0);
			var cell1 = row.insertCell(1);
			var cell2 = row.insertCell(2);
			var cell3 = row.insertCell(3);
			var cell4 = row.insertCell(4);
			var cell5 = row.insertCell(5);
			
			cell0.innerHTML = codigo_Produto;
			cell1.innerHTML = nome_Produto;
			cell2.innerHTML = parseFloat(valor_Produto).toFixed([2]);
			cell3.innerHTML = 1;
			cell4.innerHTML = parseFloat(document.getElementById("subTotalSelecionado").value).toFixed([2]);
			var codigoStr = "\""+codigo_Produto+"\"";
			cell5.innerHTML = "<span class='material-icons' style='cursor:pointer' onClick='removerCelula("+codigoStr+")'>delete_forever</span>";
			var subtotal = parseFloat(document.getElementById("subTotalSelecionado").value).toFixed([2]);
		}
		calcularTotal();
}

function calcularTotal(){
	/*Calculando o TOTAL*/
	var table = document.getElementById("notaListaProdutos");
	linhas = table.getElementsByTagName('tr').length;
	var total = 0;
	for(var i = 0; i < linhas; i++){
		try{
			if(parseFloat(table.rows[i].cells[4].innerHTML) > 0){
				total = parseFloat(parseFloat(total) + parseFloat(table.rows[i].cells[4].innerHTML)).toFixed([2]);	
			}
		}catch(ex){}
	}
	document.getElementById("totalVenda").innerHTML = parseFloat(total).toFixed([2]);
}


function removerCelula(item){
	var table = document.getElementById("notaListaProdutos");
	var linhas = table.getElementsByTagName('tr').length;  
	var rowDel;
	for(var i = 2; i < linhas; i++){
		try{
			var str = table.rows[i].cells[0].innerHTML;
			while( str.substring(0,1) == '0'){
				str = str.substr(1);
			}
			while( item.substring(0,1) == '0'){
				item = item.substr(1);
			}
			if( str == item ){
				rowDel = table.deleteRow(i);
			}
		}catch(e){}
	}
	calcularTotal();
}



function finalizandoVenda(){
	document.getElementById("pedidoVenda").value = document.getElementById("numPedido").innerHTML;
	document.getElementById("notaDataVenda").value = document.getElementById("notaData").innerHTML;
	document.getElementById("valorTotalVenda").value = document.getElementById("totalVenda").innerHTML;
	document.getElementById("numeroMesa").value = document.getElementById("mesa_pedido").innerHTML;
	
	
	var table = document.getElementById("notaListaProdutos");
	var linhas = table.getElementsByTagName('tr').length;
	var codigosVenda = '';
	var quantidadesVenda = '';
	var venda = '{"Produtos":[';
	for(var i = 3; i < (linhas-1); i++){
		venda = venda + "{\"codigo\":\"" + table.rows[i].cells[0].innerHTML + '\",';
		venda = venda + "\"qtd\":\"" + table.rows[i].cells[3].innerHTML + '\"},';
	}
	venda = venda.substring(0,(venda.length - 1));
	venda = venda+']}';
	document.getElementById("vendas").value = venda;
	document.getElementById("formVenda").submit();
}


function imprimirNota(){
	/*IMPRIMINDO*/
	var table = document.getElementById("notaListaProdutos");
	var linhas = parseInt(table.getElementsByTagName('tr').length);
	if(linhas > 4){
		for(var i = 4; i < (linhas - 1); i++){
			table.rows[i].cells[5].innerHTML = "";
		}
	}
	var divToPrint=document.getElementById("geral");
    newWin= window.open("");
    newWin.document.write(divToPrint.outerHTML);
    newWin.print();
    newWin.close();
	document.getElementById("finalizar").value = 1;
	document.getElementById("cancelar").value = 0;
	finalizandoVenda();
}


function cancelarVenda(){
	document.getElementById("finalizar").value = 0;
	document.getElementById("cancelar").value = 1;
	finalizandoVenda();
}




function validarCliente(telCLiente, observ){
	/*INSERINDO CLIENTE*/
	var valor = '<br>';
	valor = valor + 'Cliente: ' + observ + '<br>';
	valor = valor + 'Telefone: ' + telCLiente + '<br>';
	document.getElementById("infoCliente").innerHTML = valor;	
	
}



</script>



<!-- INICIANDO PÁGINA -->
<div class="main-container">

<input type=hidden id="codigoSelecionado" value="" />
<input type=hidden id="valorSelecionado" value="" />
<input type=hidden id="subTotalSelecionado" value="" />


<!-- SELECIONANDO A MESAS --->		   
<div id="mesa" class="container" style="display:block">
    <div class="row">
        <div class="col text-center">
            <h5 class="subtitle">Selecione uma Mesa</h5>
            <p class="text-secondary">Em seguida adicione os produtos.</p>
        </div>
    </div>
    <div class="row text-center mt-3">
    	<c:forEach items="${mesas }" var="m">
	        <div class="col-6 col-md-3" onclick="mesa(${m.numeroDaMesa})" style="cursor:pointer;" >
	            <div class="card border-0 mb-4">
	                <div class="card-body" <c:if test="${m.ocupada == true }" >style="background-color:#F78181"</c:if>  <c:if test="${m.ocupada == false }" >style="background-color:#A9BCF5"</c:if>  >
	                    <div class="avatar avatar-60 bg-default-light rounded-circle text-default">
	                        <img src="/img/mesas.jpg" alt="" class="w-100">
	                    </div>
	                    <p class="mt-3 mb-0 font-weight-normal" ><b>MESA ${m.numeroDaMesa}</b></p>
	                    <c:if test="${m.ocupada == true }">
	                    	<p class="mt-3 mb-0 font-weight-normal" style="color:white">Ocupada</p>
	                    </c:if>
	                    <c:if test="${m.ocupada == false }">
	                    	<p class="mt-3 mb-0 font-weight-normal" >Livre</p>
	                    </c:if>
	                    <p class="text-dark medium">Total: R$<fmt:formatNumber value="${m.total }" type="currency" currencySymbol=""/></p>
	                </div>
	            </div>
	        </div>
        </c:forEach>
    </div>
</div>
<!-- SELECIONANDO A MESAS --->	

		   
<!-- SELECIONANDO O CATEGORIA --->
<div id="categoria" class="container" style="display:none">
    <div class="row">
        <div class="col text-center">
            <h5 class="subtitle">Selecione as Categorias  &nbsp <i style="cursor:pointer" onclick="inicio()" class="material-icons vm md-36 text-template">keyboard_return</i> </h5>
            <p id="txt_mesa" class="text-secondary">MESA ?</p>
        </div>
    </div>
    <div class="row text-center mt-3">
    	<c:forEach items="${categorias }" var="c">
	        <div class="col-6 col-md-3" onclick="categoria('${c.descricao }')" style="cursor:pointer">
	            <div class="card border-0 mb-4">
	                <div class="card-body">
	                    <div class="avatar avatar-100 bg-default-light rounded-circle text-default">
	                        <img src="/img/lanches.jpg" alt="" class="w-100">
	                    </div>
	                    <p class="mt-3 mb-0 font-weight-normal"><b>${c.descricao }</b></p>
	                </div>
	            </div>
	        </div>
        </c:forEach>
        
    </div>
</div>
<!-- SELECIONANDO O CATEGORIA --->





<!-- SELECIONANDO O PRODUTO --->
<div id="produto" class="container" style="display:none">
    <div class="row">
        <div class="col text-center">
            <h5 class="subtitle">Selecione o Produto <i style="cursor:pointer" onclick="voltaCategoria()" class="material-icons vm md-36 text-template">keyboard_return</i> </h5>
             <p id="txt_categoria" class="text-secondary">PRODUTO ?</p>
			<div onclick="lista()" style="cursor:pointer;background-color:#585858; color:white " class="icon icon-50 rounded-circle mb-2"><span class="material-icons">fact_check</span></div>
        </div>
		
    </div>
    <div class="row text-center mt-3" id="listaProdutos" style="cursor:pointer">
    </div>
</div>
<!-- SELECIONANDO O PRODUTO --->





<!-- SELECIONANDO A LISTA --->
<div id="lista" class="container" style="display:none">
    <div class="row">
        <div class="col text-center">
            <h5 class="subtitle">Total da Compra <i style="cursor:pointer" onclick="categoria(global_categoria)" class="material-icons vm md-36 text-template">keyboard_return</i> </h5>
            <div style="cursor:pointer;background-color:red; color:white" onclick="cancelarVenda()" class="icon icon-50 rounded-circle mb-4 "><span class="material-icons">delete_forever</span></div>
			<div style="cursor:pointer;background-color:green; color:white" onclick="finalizandoVenda()" class="icon icon-50 rounded-circle mb-4"><span class="material-icons">check_circle_outline</span></div>
			<div style="cursor:pointer;background-color:#FA8258; color:white" onclick="modalInserirCliente()" class="icon icon-50 rounded-circle mb-4"><span class="material-icons">person</span></div>
			<div style="cursor:pointer;background-color:blue; color:white" onclick="imprimirNota()" class="icon icon-50 rounded-circle mb-4"><span class="material-icons">print</span></div>
        </div>
		
		
		<div class="col-md-12 form-group">
			<div class="nota grid-container" style="background-color:#FFFFFF;">  
				<div id="geral" style="padding:10px;">
			    	<table id="notaListaProdutos" >
				    	<tr><td colspan="5">PEDIDO: <i id="numPedido">-</i> </td></tr>
				    	<tr><td colspan="5">Mesa: <i id="mesa_pedido">-</i> </td></tr>
				    	<tr><td colspan="5" id="notaData"> - </td></tr>
						<tr><td>Cód.</td><td>Descr.</td><td>Valor</td><td>Qtd.</td><td>SubTotal</td></tr>
						
						<tr><td colspan="5"><br><b>TOTAL: R$<i id="totalVenda"> ${totalinicio} </i></b></td></tr>
					</table>
					<table id="dadosCliente" >
						<tr><td colspan="5"><br><b>CLIENTE:</b> <i id="infoCliente"> Nenhum cliente selecionado. </i></b></td></tr>
					</table>
				</div>
			</div>
		</div>
	
	
</div>
<!-- SELECIONANDO A LISTA --->





			
<form action="<c:url value='/finalizarVenda'/>" id="formVenda" method="post" >
	<input type="hidden" id="finalizar" name="finalizar" value="0" />
	<input type="hidden" id="cancelar" name="cancelar" value="0" />
	<input type="hidden" id="numeroMesa" name="numeroMesa" />
	<input type="hidden" id="pedidoVenda" name="pedidoVenda" />
	<input type="hidden" id="notaDataVenda" name="notaDataVenda" />
	<input type="hidden" id="valorTotalVenda" name="valorTotalVenda" />
	<input type="hidden" id="vendas" name="vendas" value=""/>
</form>        
           
</div>
<!-- INICIANDO PÁGINA -->







<!-- FOOTER -->
<jsp:include page="includes/barraFooter.jsp" />
<!-- FOOTER -->

<!-- FOOTER -->
<jsp:include page="includes/footer.jsp" />
<!-- FOOTER -->

