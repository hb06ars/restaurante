package brandaoti.sistema.controle.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import brandaoti.sistema.controle.model.Mesa;
import brandaoti.sistema.controle.model.Perfil;

public interface MesaDao extends JpaRepository<Mesa, Integer> {
	
	@Query(" select v from Mesa v where v.ativo = 1 order by v.numeroDaMesa asc ")
	List<Mesa> buscarMesas();
	
	@Query(" select v from Mesa v where v.ativo = 1 and v.numeroDaMesa like ( :numeroDaMesa ) order by v.numeroDaMesa asc ")
	Mesa buscarCodigo(@Param("numeroDaMesa") Integer numeroDaMesa);
}
