package brandaoti.sistema.controle.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import brandaoti.sistema.controle.model.Perfil;

public interface PerfilDao extends JpaRepository<Perfil, Integer> {
	
	@Query(" select p from Perfil p where p.admin = 1 ")
	List<Perfil> buscarAdm();
	
	@Query(value=" select p from Perfil p where p.funcionario = 1 and p.admin = 0")
	List<Perfil> buscarFuncionario();
	
	@Query(" select p from Perfil p")
	List<Perfil> buscarPerfis();
	
	@Query(" select p from Perfil p where upper( p.codigo ) like upper( :codigo ) and p.ativo = 1 ")
	Perfil buscarCodigo(@Param("codigo") String codigo);
	
	@Query(" select p from Perfil p where upper( p.nome ) like upper( :nome ) and p.ativo = 1 ")
	List<Perfil> buscarNome(@Param("nome") String nome);
}
