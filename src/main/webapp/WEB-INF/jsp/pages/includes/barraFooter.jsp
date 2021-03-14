<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="footer">
        <div class="row no-gutters justify-content-center">
            <div class="col-auto">
                <a href="/home" <c:if test="${fn:contains(itemMenuSelecionado, 'home')}"> class="active" </c:if>  >
                    <i class="material-icons">deck</i>
                    <p>Mesas</p>
                </a>
            </div>
            <div class="col-auto">
                <a href="/produtos"<c:if test="${fn:contains(itemMenuSelecionado, 'produto')}"> class="active" </c:if>  >
                    <i class="material-icons">fastfood</i>
                    <p>Produtos</p>
                </a>
            </div>
            <div class="col-auto">
                <a href="/pedidos" <c:if test="${fn:contains(itemMenuSelecionado, 'pedido')}"> class="active" </c:if>  >
                    <i class="material-icons">list_alt</i>
                    <p>Pedidos</p>
                </a>
            </div>
        </div>
    </div>