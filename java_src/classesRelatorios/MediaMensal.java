package classesRelatorios;

import java.util.ArrayList;

import classes.Lancamento;

public class MediaMensal implements Cloneable{

    private String mes;

    private String ano;

    private ArrayList<Lancamento> listaLancamentos = new ArrayList<Lancamento>();
    
    private Double valorTotalMes = 0.0;
    
    private Double valorEntrada = 0.0;
    
    private Double valorSaida = 0.0;
    
    private Double valorSaldo = 0.0;
    
    private String teste;

    public MediaMensal(){
    	
    }

    public Object clone() throws CloneNotSupportedException {
        return super.clone();
    }

    public String getMes() {
        return mes;
    }

    public void setMes(String mes) {
        this.mes = mes;
    }

    public String getAno() {
        return ano;
    }

    public void setAno(String ano) {
        this.ano = ano;
    }

    public ArrayList<Lancamento> getListaLancamentos() {
        return listaLancamentos;
    }

    public void setListaLancamentos(ArrayList<Lancamento> listaLancamentos) {
        this.listaLancamentos = listaLancamentos;
    }

    public void setValorTotalMes(Double valorTotalMes) {
        this.valorTotalMes = valorTotalMes;
    }

    public Double getValorTotalMes() {
        return valorTotalMes;
    }

	public Double getValorEntrada() {
		return valorEntrada;
	}

	public void setValorEntrada(Double valorEntrada) {
		this.valorEntrada = valorEntrada;
	}

	public Double getValorSaida() {
		return valorSaida;
	}

	public void setValorSaida(Double valorSaida) {
		this.valorSaida = valorSaida;
	}

	public void setValorSaldo(Double valorSaldo) {
		this.valorSaldo = valorSaldo;
	}
	
	/**
	 * Calcula o saldo, ou seja, diferença entre Entrada e Saida
	 * @return
	 */
	public Double getValorSaldo() {
		this.valorSaldo = getValorEntrada() - getValorSaida();
		return valorSaldo;
	}

	public void setTeste(String teste)
	{
		this.teste = teste;
	}

	public String getTeste()
	{
		return "teste get";
	}
    
}
