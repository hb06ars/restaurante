package brandaoti.sistema.controle.model;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Mesa {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id; //Esse número é o ID automático gerado.
	
	@Column
	private Integer numeroDaMesa;
	
	@Column
	private String nota;
	
	@Column
	private Boolean ocupada = false;
	
	@Column
	private String clienteQueReservou;

	@Column
	private Boolean reservada = false;
	
	@Column
	private Boolean ativo = true;
	
	@Column
	private Boolean paga = false;
	
	@Column
	private Double total = 0.0;
	
	@Column
	private LocalDateTime entrada;
	
	@Column
	private LocalDateTime saida;
	
	@OneToMany
	private List<Venda> vendas;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getNumeroDaMesa() {
		return numeroDaMesa;
	}

	public void setNumeroDaMesa(Integer numeroDaMesa) {
		this.numeroDaMesa = numeroDaMesa;
	}

	public Boolean getOcupada() {
		return ocupada;
	}

	public void setOcupada(Boolean ocupada) {
		this.ocupada = ocupada;
	}

	public String getClienteQueReservou() {
		return clienteQueReservou;
	}

	public void setClienteQueReservou(String clienteQueReservou) {
		this.clienteQueReservou = clienteQueReservou;
	}

	public Boolean getReservada() {
		return reservada;
	}

	public void setReservada(Boolean reservada) {
		this.reservada = reservada;
	}

	public Boolean getAtivo() {
		return ativo;
	}

	public void setAtivo(Boolean ativo) {
		this.ativo = ativo;
	}

	public Boolean getPaga() {
		return paga;
	}

	public void setPaga(Boolean paga) {
		this.paga = paga;
	}

	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}

	public LocalDateTime getEntrada() {
		return entrada;
	}

	public void setEntrada(LocalDateTime entrada) {
		this.entrada = entrada;
	}

	public LocalDateTime getSaida() {
		return saida;
	}

	public void setSaida(LocalDateTime saida) {
		this.saida = saida;
	}

	public String getNota() {
		return nota;
	}

	public void setNota(String nota) {
		this.nota = nota;
	}

	public List<Venda> getVendas() {
		return vendas;
	}

	public void setVendas(List<Venda> vendas) {
		this.vendas = vendas;
	}


	
	
}
