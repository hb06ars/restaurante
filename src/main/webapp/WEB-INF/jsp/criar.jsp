<!doctype html>
<html lang="en" class="h-100">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="pages/includes/modais/modalTermos.jsp" />
<jsp:include page="pages/includes/mascaras/mascaras.jsp" />


<script>
function ativarSalvar(){
	var btSalvar = document.getElementById("customSwitch1").checked;
	if(btSalvar){
		document.getElementById("btSalvar").style.display = 'none';
	} else{
		document.getElementById("btSalvar").style.display = 'block';
	}
}

function redirect(link){
	window.location.href = link;
}
</script>


<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="generator" content="">
    <title>Controle</title>

    <!-- manifest meta -->
    <meta name="apple-mobile-web-app-capable" content="yes">

    <!-- Favicons -->
    <link rel="apple-touch-icon" href="/img/logoicon.png" sizes="180x180">
    <link rel="icon" href="/img/logoicon.png" sizes="32x32" type="image/png">
    <link rel="icon" href="/img/logoicon.png" sizes="16x16" type="image/png">

    <!-- Material icons-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">

    <!-- swiper CSS -->
    <link href="vendor/swiper/css/swiper.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/style.css" rel="stylesheet" id="style">
</head>

<body class="body-scroll d-flex flex-column h-100 menu-overlay">
    <!-- screen loader -->
    <div class="container-fluid h-100 loader-display">
        <div class="row h-100">
            <div class="align-self-center col">
                <div class="logo-loading">
                    <div class="icon icon-100 mb-4 rounded-circle">
                        <img src="/img/logoicon.png" alt="" class="w-100">
                    </div>
                   <h4 class="text-default">Controle</h4>
                    <p class="text-secondary">Gerenciador de Serviços</p>
                    <div class="loader-ellipsis">
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                    </div>
                </div>
            </div>
        </div>
    </div>


<form action="/criar" id="criarUsuario" method="post" autocomplete="off">
    <!-- Begin page content -->
    <main class="flex-shrink-0 main has-footer">
        <!-- Fixed navbar -->
        <header class="header">
            <div class="row" onclick="redirect('/index')">
                <div class="col-auto px-0">
                    <button class="btn btn-40 btn-link" type="button">
                        <span class="material-icons">keyboard_arrow_left</span>
                    </button>
                </div>
                <div class="text-left col align-self-center">
                </div>
            </div>
        </header>

        <div class="container h-100 text-white">
            <div class="row h-100">
                <div class="col-12 align-self-center mb-4">
                    <div class="row justify-content-center">
                        <div class="col-11 col-sm-7 col-md-6 col-lg-5 col-xl-4">
                            <h2 class="font-weight-normal mb-5">Criar novo usuário</h2>
                            <div class="form-group float-label active">
                                <input type="text" name="login" class="form-control text-white" value="" autocomplete="nope" required>
                                <label class="form-control-label text-white">Login de Acesso</label>
                            </div>
                            <div class="form-group float-label active">
                                <input type="text" name="nome" class="form-control text-white" value="" autocomplete="nope" required>
                                <label class="form-control-label text-white">Nome</label>
                            </div>
                            <div class="form-group float-label active">
                                <input type="text" name="telefone" id="telefone" class="form-control text-white" onkeypress="mascaraTel(this)" onkeyup="somenteNumeros(this);" placeholder="(00)00000-0000" autocomplete="off" maxlength="14" minlength="14" >
                                <label class="form-control-label text-white">Contato</label>
                            </div>
                            <div class="form-group float-label position-relative">
                                <input type="password" name="senha" class="form-control text-white " required>
                                <label class="form-control-label text-white">Senha</label>
                            </div>
                            <div class="form-group float-label position-relative">
                                <input type="password" name="confirmaSenha" class="form-control text-white " required>
                                <label class="form-control-label text-white">Confirme a Senha</label>
                            </div>
                            <div class="form-group float-label position-relative">
                                <input type="text" name="codigoAcesso" class="form-control text-white " required>
                                <label class="form-control-label text-white">Código de Acesso</label>
                            </div>
                            <c:if test="${erro != null}">
	                            <div class="form-group float-label position-relative">
	                             	<a style="color:red" id="erro">${erro }</a>
	                             </div>
                            </c:if>
                            <c:if test="${msg != null}">
	                            <div class="form-group float-label position-relative">
	                             	<a id="erro" style="color:#58D3F7" >${msg }</a>
	                             </div>
                            </c:if>
                             <div class="form-group float-label position-relative" >
                             	<a style="cursor:pointer" onclick="modalTermos()">Ler os termos e condições</a>
                             </div>
                            <div class="form-group float-label position-relative">
                                <div class="custom-control custom-switch">
                                    <input type="checkbox" class="custom-control-input" id="customSwitch1">
                                    <label class="custom-control-label" for="customSwitch1" onclick="ativarSalvar()" >Aceito os termos e condições</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </main>


    <!-- footer-->
    <div class="footer no-bg-shadow py-3">
    	<div class="row justify-content-center" id="btSalvar" style="display:none">
            <div class="col">
                <input type="submit" onclick="validar()" class="btn btn-default rounded btn-block" value="Salvar" />
            </div>
        </div>
    </div>
    
</form>


    <!-- Required jquery and libraries -->
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- cookie js -->
    <script src="js/jquery.cookie.js"></script>

    <!-- Swiper slider  js-->
    <script src="vendor/swiper/js/swiper.min.js"></script>

    <!-- Customized jquery file  -->
    <script src="js/main.js"></script>
    <script src="js/color-scheme-demo.js"></script>


    <!-- page level custom script -->
    <script src="js/app.js"></script>

</body>

</html>
