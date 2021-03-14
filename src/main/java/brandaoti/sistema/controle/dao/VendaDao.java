package brandaoti.sistema.controle.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import brandaoti.sistema.controle.model.Perfil;
import brandaoti.sistema.controle.model.Venda;

public interface VendaDao extends JpaRepository<Venda, Integer> {
	
	@Query(" select p from Venda p where p.ativo = 1 ")
	List<Venda> buscarAdm();
	
	@Query(" select p from Venda p where p.ativo = 1 and p.pedido like (:nota) and p.mesa.numeroDaMesa like (:numeroDaMesa)  ")
	List<Venda> vendaPorMesa(@Param("numeroDaMesa") Integer numeroDaMesa, @Param("nota") String nota);
	
	@Query(" select p from Venda p where p.ativo = 1 and p.pedido like (:nota) and p.mesa.ocupada = true and p.mesa.numeroDaMesa like (:numeroDaMesa)  ")
	List<Venda> buscarMesaAberta(@Param("numeroDaMesa") Integer numeroDaMesa, @Param("nota") String nota);
	
	@Query(" select p from Venda p where p.ativo = 1 and p.mesa.ocupada = true order by p.pedido asc")
	List<Venda> mesaAberta();
	
	@Query(" select p from Venda p where p.mesa.numeroDaMesa like (:numeroDaMesa)  ")
	List<Venda> vendaSomenteMesa(@Param("numeroDaMesa") Integer numeroDaMesa);
	
	@Query(" from Venda where ativo = 1 and pedido like (:pedido) order by data desc ")
	List<Venda> porPedido(@Param("pedido") String pedido);
	
	@Query(" from Venda where ativo = 1 and pedido like (:pedido) order by data desc ")
	List<Venda> nota(@Param("pedido") String pedido);
	
	@Query(" from Venda where ativo = 1 and pedido like (:pedido) order by data desc ")
	List<Venda> notaSelecionada(@Param("pedido") String pedido);
	
	@Query(" from Venda where ativo = 1  ")
	List<Venda> filtro(@Param("filtro") String filtro);
	
	@Query(" from Venda where ativo = 1 order by pedido desc ")
	List<Venda> ultimas();
}
