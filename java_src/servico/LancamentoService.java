package servico;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import uteis.Constantes;
import uteis.Datas;
import classes.Categoria;
import classes.Lancamento;
import classesRelatorios.MediaMensal;
import classesRelatorios.MesAno;
import controle.GenericDao;
import controle.LancamentoDAO;

public class LancamentoService {
	private Logger logger = LogManager.getLogger(LancamentoService.class);
	private LancamentoDAO lancamentoDAO = new LancamentoDAO();
	
	public boolean salvar(Lancamento c)
    {
		if(c.getParcelado())
		{
			boolean salvoSemErro = true;
			Double valorParcela = c.getValor() / c.getQtdParcelas();
			for (int i = 0; i < c.getQtdParcelas(); i++) 
			{
				Lancamento lancamento = null;
				try 
				{
					lancamento = (Lancamento) c.clone();
					
					Calendar data = Calendar.getInstance();
					data.setTime(lancamento.getData());
					lancamento.setValor(valorParcela);
					Datas.addMes(data, i);
					
					lancamento.setData(data.getTime());
					
					if(lancamento.getObs() == null)
					{
						lancamento.setObs("");
					}
					lancamento.setObs(lancamento.getObs() + " - Parcela " + (i + 1) + " de " + lancamento.getQtdParcelas() + ". Valor total " + c.getValor());
				} catch (CloneNotSupportedException e) 
				{
					logger.error("************** Erro ao salvar lancamento parcelado. ************** ", e);
				}
				if(!lancamentoDAO.salvar(lancamento))
				{
					salvoSemErro = false;
				}
			}
			return salvoSemErro;
		}else
		{
			return lancamentoDAO.salvar(c);
		}
    }    

    public boolean excluir(int cod)
    {
		return lancamentoDAO.excluir(cod);
	}

    /**
     * Carrega todas as lancamentos de um mes/ano
     * 
     * @param mes
     * @param ano
     * @param agrupar
     * @return
     */
	public MediaMensal pesquisar(Integer mes, Integer ano, boolean agrupar, String tipo, String obs, Integer codCategoria)
	{
		MediaMensal mediaMensal = new MediaMensal();
    	if(agrupar)
    	{
    		//monta o objeto e adiciona na lista de retorno
    		ArrayList<Object> listaConsulta = lancamentoDAO.listarValorPorCategoria(mes, ano, tipo);
    		populaAgruparLancamentos(mediaMensal.getListaLancamentos(), listaConsulta);
    	}else
    	{
    	    mediaMensal = lancamentoDAO.listar(mes, ano, tipo, obs, codCategoria);
    	}
    	mediaMensal.setValorTotalMes(calcularValorGastoMes(mediaMensal.getListaLancamentos()));
        return mediaMensal;
    }
	
	/**
	 * Popula somenete os campos Tipo da Lancamento e Valor da classe lancamento, pois as lancamentos estão agrupadas 
	 * 
	 * @param listaRetorno
	 * @param listaConsulta
	 */
	public ArrayList<Lancamento> populaAgruparLancamentos(ArrayList<Lancamento> listaRetorno, ArrayList<Object> listaConsulta){
		for(Object obj : listaConsulta)
		{
			Object[] registro = (Object[]) obj;
			Lancamento lancamento = new Lancamento();
			Categoria categoria = new Categoria();
			
			categoria.setDescricao((String)registro[0]);
			lancamento.setCategoria(categoria);
			lancamento.setValor((Double) registro[1]);
			
			listaRetorno.add(lancamento);
		}
		return listaRetorno;
	}
	
	/**
	 * calcula o valor total gasto no mês
	 * 
	 * @return 
	 */
	public Double calcularValorGastoMes(ArrayList<Lancamento> listaLancamentos)
	{
	    Double valorTotalMes = 0.0;
        for(Lancamento lancamento : listaLancamentos)
        {
            valorTotalMes += lancamento.getValor();
        }
        return valorTotalMes;
	}
	
	/**
	 * Retornar os Mês e Ano que possuem lancamentos
	 *  
	 * @param dataInicio
	 * @param dataFim
	 * @param tipo
	 * @param listaCategorias
	 * @return
	 */
	public ArrayList<MesAno> getMesesAnos(Date dataInicio, Date dataFim, String tipo
			, ArrayList<Integer> listaCategorias){

        return lancamentoDAO.getMesesAnos(dataInicio, dataFim, tipo, listaCategorias);
    }
	
	/**
	 * Consulta o valor total de entrada e saida de determinado mes
	 * 
	 * @param mes
	 * @param ano
	 * @return
	 */
	public Object[] listarSaldo(Integer ano)
	{
		Object[] retorno = new Object[2];
		ArrayList<MediaMensal> lista = new ArrayList<MediaMensal>();
		Double saldo = 0.0;
		
		Integer[] meses = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
		for(Integer mes : meses)
		{
			//busca os lancamentos
			MediaMensal mediaMensalEntrada = pesquisar(mes, ano, false, Constantes.ENTRADA, null, null);
			MediaMensal mediaMensalSaida = pesquisar(mes, ano, false, Constantes.SAIDA, null, null);
			
			//monta em so um objeto
			MediaMensal media = new MediaMensal();
			media.setAno(ano.toString());
//        	mediaEntradaSaida.setMes(Datas.getNomeMes(mesAno.getMes()));
			media.setMes(mes.toString());
			//seta o valor total de entrada ENTRADA e SAIDA do mes
			media.setValorEntrada(mediaMensalEntrada.getValorTotalMes());
			media.setValorSaida(mediaMensalSaida.getValorTotalMes());
			
			lista.add(media);
			
			//calcula o saldo final
			saldo += media.getValorSaldo();
		}
        retorno[0] = lista;
        retorno[1] = saldo;
        return retorno;
	}
}
