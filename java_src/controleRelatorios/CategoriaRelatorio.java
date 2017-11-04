package controleRelatorios;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.joda.time.DateTime;

import controle.CategoriaDAO;

import uteis.Constantes;
import uteis.Datas;
import uteis.Utilidades;
import classesRelatorios.MediaPorCategoria;
import servico.CategoriaService;

public class CategoriaRelatorio extends HttpServlet {

	private Logger logger = LogManager.getLogger(CategoriaRelatorio.class);
	
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        try {
        	
        	String diaInicio = request.getParameter("diaInicio");
            String mesInicio = request.getParameter("mesInicio");
            String anoInicio = request.getParameter("anoInicio");
            
            String diaFim = request.getParameter("diaFim");
            String mesFim = request.getParameter("mesFim");
            String anoFim = request.getParameter("anoFim");
            
            DateTime dataInicial = Datas.createDateFromParameters(anoInicio, mesInicio, diaInicio, 0, 0, 0);
            DateTime dataFinal = Datas.createDateFromParameters(anoFim, mesFim, diaFim, 23, 59, 59);
            
            String acao = request.getParameter("acao");
            String tipo = request.getParameter("tipo");
			String codCategorias = request.getParameter("codCategorias");

			ArrayList<Integer> categorias = new ArrayList<Integer>();
			//pega os codigos das categorias selecionadas
            if(codCategorias != null && !codCategorias.equals(""))
            {
				String[] val = codCategorias.split(",");
				for(String e: val)
				{
					categorias.add(Integer.parseInt(e));
				}
            }
			
            if(acao.equals(Constantes.RELATORIO_VALOR_POR_CATEGORIA_POR_DATA))
            {
            	printValorPorCategoriaPorData(response, dataInicial, dataFinal, tipo, categorias);
            }
            
            if(acao.equals(Constantes.RELATORIO_MEDIA_POR_CATEGORIA))
            {
            	printMediaPorCategoria(response, dataInicial, dataFinal, tipo, categorias);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    public void doGet(HttpServletRequest req, HttpServletResponse response) throws IOException, ServletException {
        processRequest(req, response);
    }

    public void printValorPorCategoriaPorData(HttpServletResponse response, DateTime dataInicio, DateTime dataFim, 
    		String tipo, ArrayList<Integer> listaCategorias)
    {
    	try {
	    	
    		CategoriaService categoriaServico = new CategoriaService();
    		ArrayList<MediaPorCategoria> listaRelatorio = 
    				categoriaServico.gastoMensalPorCategoria(dataInicio.toDate(), dataFim.toDate(), tipo, listaCategorias);
	        /*
	         * -------------------------------------------------------------------------------------------------------------------
	         * Seta as informações e abre o relatório .pdf
	         */
	        JRBeanCollectionDataSource jrBeanCollection = new JRBeanCollectionDataSource(listaRelatorio);
	
//	        String caminhoRelatorio = Utilidades.getRealPath(this, Constantes.URL_RELATORIOS) + "/categoria/gasto_mensal_por_categoria.jasper";
	        String caminhoRelatorio = "C:/sistemas/financas/java_src/relatorios/categoria/gasto_mensal_por_categoria.jasper";
	        
	        HashMap<String, Object> parametros = new HashMap<String, Object>();
	        parametros.put("dataInicial", dataInicio.toDate());
	        parametros.put("dataFinal", dataFim.toDate());
	        
	        Utilidades.gerarRelatorioPDF(caminhoRelatorio, parametros, jrBeanCollection, response);
	        
    	}catch (ServletException e) {
    		logger.error("", e);
		}
    }
    
    public void printMediaPorCategoria(HttpServletResponse response, DateTime dataInicio, DateTime dataFim
    		, String tipo, ArrayList<Integer> categorias)
    {
    	try {
    		CategoriaService categoriaServico = new CategoriaService();
	
	        // lista que será enviada ao relatório
	        ArrayList<MediaPorCategoria> listaRelatorio = categoriaServico.pesquisarMediaPorCategoria(dataInicio.toDate(), dataFim.toDate()
	        		, tipo, categorias);
	        
	        /*
	         * -------------------------------------------------------------------------------------------------------------------
	         * Seta as informações e abre o relatório .pdf
	         */
	        JRBeanCollectionDataSource jrBeanCollection = new JRBeanCollectionDataSource(listaRelatorio);
	
	        String caminhoRelatorio = Utilidades.getRealPath(this, Constantes.URL_RELATORIOS) + "/categoria/media_por_categoria.jasper";
	        //String caminhoRelatorio = "C:/sistemas/financas/java_src/relatorios/categoria/media_por_categoria.jasper";
	        
	
	        HashMap<String, Object> parametros = new HashMap<String, Object>();
	        parametros.put("dataInicial", dataInicio.toDate());
	        parametros.put("dataFinal", dataFim.toDate());

	
	        Utilidades.gerarRelatorioPDF(caminhoRelatorio, parametros, jrBeanCollection, response);
	        
    	}catch (ServletException e) {
    		logger.error("", e);
		}
    }

}
