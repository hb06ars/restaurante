<!doctype html>
<html lang="en" class="h-100">


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

<body class="body-scroll d-flex flex-column h-100 menu-overlay" >
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


<form action="/home" method="post">
    <!-- Begin page content -->
    <main style="background-position: center;background-repeat: no-repeat; background-color:white; background-image: url('/img/fundo.png');" class="flex-shrink-0 main has-footer">
        <!-- Fixed navbar -->       
        	<div class="container h-100 text-dark">
	            <div class="row h-100">
	                <div class="col-12 align-self-center mb-4">
	                    <div class="row justify-content-center">
	                        <div class="col-11 col-sm-7 col-md-6 col-lg-5 col-xl-4 text-center">
	                            <h2 class="font-weight-normal mb-1">Controle</h2>
	                            <h4 class="font-weight-normal mb-5">Gerenciador de Servi�os</h4>
	                            <div class="form-group float-label">
	                                <input type="text" name="usuarioVal" id="usuarioVal" class="form-control text-dark" required>
	                                <label class="form-control-label text-dark">Nome de usu�rio</label>
	                            </div>
	                            <div class="form-group float-label position-relative">
	                                <input type="password" name="senhaVal" class="form-control text-dark" required>
	                                <label class="form-control-label text-dark">Senha</label>
	                            </div>  
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>

    </main>

    <!-- footer-->
    <div class="footer no-bg-shadow py-3">
        <div class="row justify-content-center">
            <div class="col">
                <input type="submit" class="btn btn-default rounded btn-block" value="Login" />
            </div>
        </div>
        <br>
        <div class="row justify-content-center">
            <div class="col">
                <a type="button" href="/criar" class="btn btn-secondary rounded btn-block">Criar</a>
            </div>
        </div>
    </div>
</form>

    <!-- Required jquery and libraries -->
    <script src="/js/jquery-3.3.1.min.js"></script>
    <script src="/js/popper.min.js"></script>
    <script src="/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- cookie js -->
    <script src="/js/jquery.cookie.js"></script>

    <!-- Swiper slider  js-->
    <script src="/vendor/swiper/js/swiper.min.js"></script>

    <!-- Customized jquery file  -->
    <script src="/js/main.js"></script>
    <script src="/js/color-scheme-demo.js"></script>


    <!-- page level custom script -->
    <script src="/js/app.js"></script>
    
</body>

</html>
