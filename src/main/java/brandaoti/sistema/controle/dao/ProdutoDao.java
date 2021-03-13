package brandaoti.sistema.controle.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import brandaoti.sistema.controle.model.Produto;

public interface ProdutoDao extends JpaRepository<Produto, Integer> {
	
	@Query(" select v from Produto v where v.ativo = 1 order by v.descricao asc ")
	List<Produto> buscarProdutos();
	
	@Query(" select v from Produto v where v.ativo = 1 and upper( v.codigo ) like upper( :codigo ) order by v.descricao asc ")
	Produto porCodigo(@Param("codigo") String codigo);
}
