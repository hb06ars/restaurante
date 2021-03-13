<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<!doctype html>
<html lang="en" class="h-100">
<!--  ATUALIZAR P�GINA  -->
<c:if test="${atualizarPagina != null }">
	<script>window.location.href='${atualizarPagina}';</script>
</c:if>

<script>
function expandir(campo, quantidade){
	var ativado = document.getElementsByClassName(campo)[0].style.display;
	if( ativado == 'none' ){
		document.getElementById("pastaFechada").style.display="none";
		document.getElementById("pastaAberta").style.display="block";
		var i = 0;
		var x = document.getElementsByClassName(campo);
		for(i; i < quantidade; i++){
			x[i].style.display = "block";
		}
	} else{
		document.getElementById("pastaFechada").style.display="block";
		document.getElementById("pastaAberta").style.display="none";
		var i = 0;
		var x = document.getElementsByClassName(campo);
		for(i; i < quantidade; i++){
			x[i].style.display = "none";
		}
	}
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
    <link rel="manifest" href="/manifest.json" />

    <!-- Favicons -->
    <link rel="apple-touch-icon" href="/img/logoicon.png" sizes="180x180">
    <link rel="icon" href="/img/logoicon.png" sizes="32x32" type="image/png">
    <link rel="icon" href="/img/logoicon.png" sizes="16x16" type="image/png">
    <link rel="shortcut icon" href="/img/logoicon.png" type="image/ico">
    

    <!-- Material icons-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">

    <!-- swiper CSS -->
    <link href="/vendor/swiper/css/swiper.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/css/style.css" rel="stylesheet" id="style">
</head>
<!-- SCRIPTS -->
<jsp:include page="javaScript.jsp" />
<!-- SCRIPTS -->


<script>
function redirecionar(site){
	window.location.href=site;
}

function expandir(campo, quantidade, pasta){
	var pastaAberta = pasta + 'Aberta';
	var pastaFechada = pasta + 'Fechada';
	var ativado = document.getElementsByClassName(campo)[0].style.display;
	if( ativado == 'none' ){
		document.getElementById(pastaFechada).style.display="none";
		document.getElementById(pastaAberta).style.display="block";
		var i = 0;
		var x = document.getElementsByClassName(campo);
		for(i; i < quantidade; i++){
			x[i].style.display = "block";
		}
	} else{
		document.getElementById(pastaFechada).style.display="block";
		document.getElementById(pastaAberta).style.display="none";
		var i = 0;
		var x = document.getElementsByClassName(campo);
		for(i; i < quantidade; i++){
			x[i].style.display = "none";
		}
	}
}

</script>


<body onload="iniciando()" class="body-scroll d-flex flex-column h-100 menu-overlay" data-page="homepage">
    <!-- screen loader -->
    <div class="container-fluid h-100 loader-display">
        <div class="row h-100">
            <div class="align-self-center col">
                <div class="logo-loading">
                    <div class="icon icon-100 mb-4 rounded-circle">
                        <img src="/img/logoicon.png" alt="" class="w-100">
                    </div>
                    <h4 class="text-default">Controle</h4>
                    <p class="text-secondary">Gerenciador de Servi�os</p>
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



    <!-- menu main -->
    <div class="main-menu">
        <div class="row mb-4 no-gutters">
            <div class="col-auto"><button class="btn btn-link btn-40 btn-close text-white"><span class="material-icons">chevron_left</span></button></div>
            <div class="col-auto">
                <div class="avatar avatar-40 rounded-circle position-relative">
                    <figure class="background">
                        <img src="/img/logoicon.png" alt="">
                    </figure>
                </div>
            </div>
            <div class="col pl-3 text-left align-self-center">
                <h6 class="mb-1">Controle</h6>
                <p class="small">Gerenciador de Servi�os</p>
            </div>
        </div>
        
        <div class="menu-container">
            
            <ul class="nav nav-pills flex-column ">
                
                <li class="nav-item">
                    <a class="nav-link" href="/home">
                        <div>
                            <span class="material-icons icon">account_balance</span>
                            Home
                        </div>
                    </a>
                </li>
                
                <li class="nav-item">
                    <a href="#menuVendas" data-toggle="collapse" class="nav-link">
						<div>
                            <span class="material-icons icon">deck</span>
                           <i class="fas fa-clipboard"></i>&nbsp Controle
                        </div>
                        <span class="arrow material-icons">chevron_right</span>
					</a>
                    
                    <ul class="collapse" id="menuVendas">
                        <li class="list-unstyled components mb-3" >
                        	<a class="text-default-secondary" style="text-decoration:none;color:inherit;" href="/home"><span class="material-icons icon text-default-secondary">deck</span> Mesas </a>
                        </li>
                        <li class="list-unstyled components mb-3" >
                        	<a class="text-default-secondary" style="text-decoration:none;color:inherit;" href="/produtos"><span class="material-icons icon text-default-secondary">fastfood</span> Produtos </a>
                        </li>
                        <li class="list-unstyled components mb-3" >
                        	<a class="text-default-secondary" style="text-decoration:none;color:inherit;" href="/pedidos"><span class="material-icons icon text-default-secondary">list_alt</span> Pedidos </a>
                        </li>
                    </ul>
                </li>
                
                <c:if test="${usuarioSessao.perfil.admin }">
	                <li class="nav-item">
	                    <a href="#menuCadastro" data-toggle="collapse" class="nav-link">
							<div>
	                            <span class="material-icons icon">add_circle</span>
	                           <i class="fas fa-clipboard"></i>&nbsp Cadastro
	                        </div>
	                        <span class="arrow material-icons">chevron_right</span>
						</a>
	                    
	                    <ul class="collapse" id="menuCadastro">
	                        <li class="list-unstyled components mb-3" >
	                        	<a class="text-default-secondary" style="text-decoration:none;color:inherit;" href="/home"><span class="material-icons icon text-default-secondary">deck</span> Mesas </a>
	                        </li>
	                        <li class="list-unstyled components mb-3" >
	                        	<a class="text-default-secondary" style="text-decoration:none;color:inherit;" href="/produtos"><span class="material-icons icon text-default-secondary">fastfood</span> Produtos </a>
	                        </li>
	                    </ul>
	                </li>
                </c:if>
                 
                
                
                <li class="nav-item">
                    <a class="nav-link" href="https://wa.me/5511989376271">
                        <div>
                            <span class="material-icons icon">person</span>
                            Gerente
                        </div>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="https://wa.me/5511989376271">
                        <div>
                            <span class="material-icons icon">settings</span>
                            Suporte
                        </div>
                    </a>
                </li>
                <c:if test="${usuarioSessao.perfil.admin }">
	                <li class="nav-item">
	                    <a class="nav-link" style="cursor: pointer;" href="/token">
	                        <div>
	                            <span class="material-icons icon">vpn_key</span>
	                            Token
	                        </div>
	                    </a>
	                </li>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link" style="cursor: pointer;" href="/senha">
                        <div>
                            <span class="material-icons icon">password</span>
                            Trocar Senha
                        </div>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" style="cursor: pointer;" onclick="modalContato()">
                        <div>
                            <span class="material-icons icon">build_circle</span>
                            Funcionamento
                        </div>
                    </a>
                </li>
                
               
               
            </ul>
            <div class="text-center">
                <a href="/deslogar" class="btn btn-outline-danger text-white rounded my-3 mx-auto">Deslogar</a>
            </div>
        </div>
    </div>
    <div class="backdrop"></div>
    

    <!-- Begin page content -->
    <main class="flex-shrink-0 main has-footer">
        <!-- Fixed navbar -->
        <header class="header">
            <div class="row">
                <div class="col-auto px-0">
                    <button class="menu-btn btn btn-40 btn-link" type="button">
                        <span class="material-icons">menu</span>
                    </button>
                </div>
                <div class="text-left col align-self-center">
                    <a class="navbar-brand" href="#">
                        <h5 class="mb-0">Controle</h5>
                    </a>
                </div>
                <div class="ml-auto col-auto pl-0">
                    <button type="button" class="btn btn-link btn-40 colorsettings">
                        <span class="material-icons">color_lens</span>
                    </button>
                    <a href="/deslogar" class=" btn btn-40 btn-link" >
                        <span class="material-icons">power_settings_new</span>
                        <span class="counter"></span>
                    </a>
                </div>
            </div>
        </header>
        
<!-- MENSAGENS -->
<jsp:include page="mensagens.jsp" />
<!-- MENSAGENS -->
<!-- MODAIS -->
<jsp:include page="modal.jsp" />
<!-- MODAIS -->
        