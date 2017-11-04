package testes;

import java.util.ArrayList;
import java.util.Calendar;

import uteis.Constantes;

import classes.Categoria;
import classes.Lancamento;

import controle.CategoriaDAO;
import controle.LancamentoDAO;

public class InsereLancamentos {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		CategoriaDAO categoriaDao = new CategoriaDAO();
		LancamentoDAO lancamentoDao = new LancamentoDAO();
		
		Integer[] listaDias = {1,2,3,4,5,6,7,8,9,10,12,13};
		int mes = 3;
		int ano = 2011;
		
		for(int i = 0; i < listaDias.length; i++){
			Calendar c = Calendar.getInstance();
			c.set(ano, mes, listaDias[i]);

			Lancamento l = new Lancamento();
			l.setCodLancamento(0);
			l.setData(c.getTime());
			l.setCategoria(categoriaDao.procurar(2));
			l.setTipo(Constantes.SAIDA);
			l.setValor(50.0);
			
			lancamentoDao.salvar(l);
		}

	}

}
