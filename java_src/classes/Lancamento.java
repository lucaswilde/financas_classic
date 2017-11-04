package classes;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
@Table(name = "lancamento")
public class Lancamento implements Cloneable{
	
	@Id
	@Column(name = "cod_lancamento", nullable = false)
	@SequenceGenerator(name = "seq", sequenceName = "seq_lancamento", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq")
	private Integer codLancamento;
	
	@Column(name = "valor", nullable = false)
	private Double valor;
	
	@Column(name = "data", nullable = false)
	@Temporal(TemporalType.DATE)
	private Date data;
	
	@Column(name = "observacao", nullable = true)
	private String obs;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "cod_categoria", referencedColumnName = "cod_categoria")
	private Categoria categoria;

	@Column(name = "tipo", nullable = true)
	private String tipo;
	
	@Transient
	private Boolean parcelado;
	
	@Transient
	private Integer qtdParcelas;
	
	@Override
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}

	/**
	 * @return the codLancamento
	 */
	public Integer getCodLancamento() {
		return codLancamento;
	}

	/**
	 * @param codLancamento the codLancamento to set
	 */
	public void setCodLancamento(Integer codLancamento) {
		this.codLancamento = codLancamento;
	}

	/**
	 * @return the valor
	 */
	public Double getValor() {
		return valor;
	}

	/**
	 * @param valor the valor to set
	 */
	public void setValor(Double valor) {
		this.valor = valor;
	}

	/**
	 * @return the data
	 */
	public Date getData() {
		return data;
	}

	/**
	 * @param data the data to set
	 */
	public void setData(Date data) {
		this.data = data;
	}

	/**
	 * @return the obs
	 */
	public String getObs() {
		return obs;
	}

	/**
	 * @param obs the obs to set
	 */
	public void setObs(String obs) {
		this.obs = obs;
	}

	/**
	 * @return the categoria
	 */
	public Categoria getCategoria() {
		return categoria;
	}

	/**
	 * @param categoria the categoria to set
	 */
	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((categoria == null) ? 0 : categoria.hashCode());
		result = prime * result
				+ ((codLancamento == null) ? 0 : codLancamento.hashCode());
		result = prime * result + ((data == null) ? 0 : data.hashCode());
		result = prime * result + ((obs == null) ? 0 : obs.hashCode());
		result = prime * result
				+ ((parcelado == null) ? 0 : parcelado.hashCode());
		result = prime * result
				+ ((qtdParcelas == null) ? 0 : qtdParcelas.hashCode());
		result = prime * result + ((tipo == null) ? 0 : tipo.hashCode());
		result = prime * result + ((valor == null) ? 0 : valor.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Lancamento other = (Lancamento) obj;
		if (categoria == null) {
			if (other.categoria != null)
				return false;
		} else if (!categoria.equals(other.categoria))
			return false;
		if (codLancamento == null) {
			if (other.codLancamento != null)
				return false;
		} else if (!codLancamento.equals(other.codLancamento))
			return false;
		if (data == null) {
			if (other.data != null)
				return false;
		} else if (!data.equals(other.data))
			return false;
		if (obs == null) {
			if (other.obs != null)
				return false;
		} else if (!obs.equals(other.obs))
			return false;
		if (parcelado == null) {
			if (other.parcelado != null)
				return false;
		} else if (!parcelado.equals(other.parcelado))
			return false;
		if (qtdParcelas == null) {
			if (other.qtdParcelas != null)
				return false;
		} else if (!qtdParcelas.equals(other.qtdParcelas))
			return false;
		if (tipo == null) {
			if (other.tipo != null)
				return false;
		} else if (!tipo.equals(other.tipo))
			return false;
		if (valor == null) {
			if (other.valor != null)
				return false;
		} else if (!valor.equals(other.valor))
			return false;
		return true;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getTipo() {
		return tipo;
	}

	public Boolean getParcelado() {
		return parcelado;
	}

	public void setParcelado(Boolean parcelado) {
		this.parcelado = parcelado;
	}

	public Integer getQtdParcelas() {
		return qtdParcelas;
	}

	public void setQtdParcelas(Integer qtdParcelas) {
		this.qtdParcelas = qtdParcelas;
	}
	
	
	
}
