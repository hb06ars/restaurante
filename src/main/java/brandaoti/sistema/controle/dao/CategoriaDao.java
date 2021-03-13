package brandaoti.sistema.controle.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import brandaoti.sistema.controle.model.Categoria;
import brandaoti.sistema.controle.model.Perfil;

public interface CategoriaDao extends JpaRepository<Categoria, Integer> {
	
	@Query(" select p from Categoria p where p.ativo = 1 ")
	List<Categoria> buscarCategorias();
	
	@Query(" select p from Categoria p where upper (p.descricao) like upper (:nomeCategoria) and p.ativo = 1 ")
	Categoria buscarDeterminadaCategoria(@Param("nomeCategoria") String acesso);
	
}
