package brandaoti.sistema.controle.model;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;


@Entity
public class Venda {
	
	@Id
	@GeneratedValue
	private Integer vendaID;
	
	@Column
	private Date data = new Date();
	@Column
	private Boolean ativo = true;
	@Column
	private String pedido;
	
	@ManyToOne
	private Mesa mesa;
	
	@ManyToOne
	private Produto produtos;
	@Column
	private Integer quantidade;
	@Column
	private Double precoUnit;
	@Column
	private Double subtotal;
	
	@ManyToOne
	private Usuario funcionario;

	private Boolean promocao;
	
	public Integer getVendaID() {
		return vendaID;
	}

	public void setVendaID(Integer vendaID) {
		this.vendaID = vendaID;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public Boolean getAtivo() {
		return ativo;
	}

	public void setAtivo(Boolean ativo) {
		this.ativo = ativo;
	}

	public String getPedido() {
		return pedido;
	}

	public void setPedido(String pedido) {
		this.pedido = pedido;
	}

	public Produto getProdutos() {
		return produtos;
	}

	public void setProdutos(Produto produtos) {
		this.produtos = produtos;
	}

	public Integer getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(Integer quantidade) {
		this.quantidade = quantidade;
	}

	public Double getSubtotal() {
		return subtotal;
	}
	
	public String getSubtotal_str() {
		double d = subtotal;
        String s = String.format("%.2f", d);
        s = s.replace(",", ".");
		return s;
	}

	public void setSubtotal(Double subtotal) {
		this.subtotal = subtotal;
	}

	public Usuario getFuncionario() {
		return funcionario;
	}

	public void setFuncionario(Usuario funcionario) {
		this.funcionario = funcionario;
	}

	public Double getPrecoUnit() {
		return precoUnit;
	}
	
	public String getPrecoUnit_str() {
		double d = precoUnit;
        String s = String.format("%.2f", d);
        s = s.replace(",", ".");
		return s;
	}

	public void setPrecoUnit(Double precoUnit) {
		this.precoUnit = precoUnit;
	}

	public Boolean getPromocao() {
		return promocao;
	}

	public void setPromocao(Boolean promocao) {
		this.promocao = promocao;
	}

	public Mesa getMesa() {
		return mesa;
	}

	public void setMesa(Mesa mesa) {
		this.mesa = mesa;
	}
	
	
}