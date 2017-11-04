package servico;

import java.util.ArrayList;
import java.util.Date;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.joda.time.DateTime;

import uteis.Datas;
import classes.Categoria;
import classesRelatorios.MediaPorCategoria;
import classesRelatorios.MesAno;
import controle.CategoriaDAO;
import controle.LancamentoDAO;

public class CategoriaService {

	private Logger logger = LogManager.getLogger(CategoriaDAO.class);
	private CategoriaDAO categoriaDAO = new CategoriaDAO();
    
    public boolean  salvar(Categoria c)
    {
    	return categoriaDAO.salvar(c);
    }    

    public boolean excluir(int cod)
    {
    	return categoriaDAO.excluir(cod);
	}
    
    public Categoria procurar(int cod)
    {
    	return categoriaDAO.procurar(cod);
	}

	public ArrayList<Categoria> listar()
	{
        return categoriaDAO.listar();
    }
	
	public ArrayList<Categoria> pesquisar(String palavra)
	{
        return categoriaDAO.pesquisar(palavra);
    }

	public ArrayList<MediaPorCategoria> gastoMensalPorCategoria(Date dataInicio, Date dataFim, String tipo
			, ArrayList<Integer> listaCategorias)
	{
		ArrayList<MediaPorCategoria> listaRetorno = new ArrayList<MediaPorCategoria>();
		try
		{
			//carrega todos os messes que possuem registros
			LancamentoDAO lancamentoDao = new LancamentoDAO();
			ArrayList<MesAno> listaMesAno = lancamentoDao.getMesesAnos(dataInicio, dataFim, tipo, listaCategorias);
			
			//busca para cada mes/ano os registros correspondentes
			for(MesAno data : listaMesAno)
			{
				DateTime dtInicio = Datas.createDate(data.getAno(), data.getMes(), 1 , 0, 0, 0);
				int lastDay = dtInicio.dayOfMonth().getMaximumValue();
				DateTime dtFim = Datas.createDate(data.getAno(), data.getMes(), lastDay , 23, 59, 59);

				ArrayList<MediaPorCategoria> listaMediaCategoiras = pesquisarMediaPorCategoria(dtInicio.toDate(), dtFim.toDate()
						, tipo, listaCategorias);
				
				//popula a lista de retorno
				for(MediaPorCategoria media : listaMediaCategoiras)
				{
					DateTime dt = Datas.createDate(data.getAno(), data.getMes(), 1, 0, 0, 0);
					
					media.setMesAno(data);
					media.setData(dt.toCalendar(null));
					listaRetorno.add(media);
				}
			}
		}
		catch (Exception e) 
		{
        	logger.error("", e);
		}
		
		return listaRetorno;
	}
	
	/**
	 *  Carrega uma lista informando os lancamentos e o valor médio gasto
	 *  
	 * @param dataInicio
	 * @param dataFim
	 * @param tipo
	 * @param listaCategorias
	 * @return
	 */
	public ArrayList<MediaPorCategoria> pesquisarMediaPorCategoria(Date dataInicio, Date dataFim, String tipo, ArrayList<Integer> listaCategorias)
	{
        return categoriaDAO.pesquisarMediaPorCategoria(dataInicio, dataFim, tipo, listaCategorias);
	}
}
