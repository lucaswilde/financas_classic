package classesRelatorios;

import java.util.Calendar;

public class MediaPorCategoria {
	
	private String dsCategoria;
    
    private Double valor = 0.0;
    
    private MesAno mesAno;
    
    private Calendar data;
    
    public MediaPorCategoria(){
    	
    }

	public String getDsCategoria() {
		return dsCategoria;
	}

	public void setDsCategoria(String dsCategoria) {
		this.dsCategoria = dsCategoria;
	}

	public Double getValor() {
		return valor;
	}

	public void setValorTotal(Double valor) {
		this.valor = valor;
	}

	public void setMesAno(MesAno mesAno) {
		this.mesAno = mesAno;
	}

	public MesAno getMesAno() {
		return mesAno;
	}

	public void setData(Calendar data) {
		this.data = data;
	}

	public Calendar getData() {
		return data;
	}
    
    
    
}
