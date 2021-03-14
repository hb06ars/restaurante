package brandaoti.sistema.controle.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import brandaoti.sistema.controle.model.Usuario;

public interface UsuarioDao extends JpaRepository<Usuario, Integer> {
	@Query(" select u from Usuario u where upper( u.login ) like upper( :login ) and upper( u.senha ) like upper( :senha ) ")
	Usuario fazerLogin(@Param("login") String login, @Param("senha") String senha);
	
	@Query(" select u from Usuario u where u.perfil.funcionario = 1 and u.ativo = 1")
	List<Usuario> funcionario();
	
	@Query(" select u from Usuario u where u.ativo = 1")
	List<Usuario> usuarios();
	
	@Query(" select u from Usuario u where upper( u.login ) like upper( :login ) ")
	List<Usuario> buscaLogin(@Param("login") String login);
	
	@Query("select u from Usuario u where upper( u.acesso ) like upper( :acesso ) and u.ativo = false and u.acesso <> '' ")
	Usuario buscaAcesso(@Param("acesso") String acesso);
	
	@Query("select u from Usuario u where u.ativo = false and u.acesso <> '' ")
	List<Usuario> buscaTokens();

}
