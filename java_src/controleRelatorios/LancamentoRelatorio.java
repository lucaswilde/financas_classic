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
import classesRelatorios.MediaMensal;
import classesRelatorios.MesAno;
import servico.LancamentoService;

public class LancamentoRelatorio extends HttpServlet {

	private Logger logger = LogManager.getLogger(LancamentoRelatorio.class);
	
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        try {

        	String diaInicio = request.getParameter("diaInicio");
            String mesInicio = request.getParameter("mesInicio");
            String anoInicio = request.getParameter("anoInicio");
            
            String diaFim = request.getParameter("diaFim");
            String mesFim = request.getParameter("mesFim");
            String anoFim = request.getParameter("anoFim");
            
            DateTime dataInicio = Datas.createDateFromParameters(anoInicio, mesInicio, diaInicio, 0, 0, 0);
            DateTime dataFim = Datas.createDateFromParameters(anoFim, mesFim, diaFim, 23, 59, 59);
            
            Boolean agrupar = Boolean.parseBoolean(request.getParameter("agrupar"));
            String acao = request.getParameter("acao");
            String tipo = request.getParameter("tipo");

            if(acao.equals(Constantes.RELATORIO_MEDIA_MENSAL))
            {
            	printMediaMensal(response, dataInicio, dataFim, agrupar, tipo);
            }
            
            if(acao.equals(Constantes.RELATORIO_ENTRADA_SAIDA))
            {
            	printRelatorioEntradaSaida(response, dataInicio, dataFim);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    public void doGet(HttpServletRequest req, HttpServletResponse response) throws IOException, ServletException {
        processRequest(req, response);
    }

    public void printMediaMensal(HttpServletResponse response, DateTime dataInicio, DateTime dataFim, Boolean agrupar, String tipo)
    {
    	try {
	    	
    		LancamentoService lancamentoService = new LancamentoService();
    		
	        // lista que será enviada ao relatório
	        ArrayList<MediaMensal> listaRelatorio = new ArrayList<MediaMensal>();
	        
	        // busca os meses/anos para posteriormente buscar as lancamentos de cada Mês
	        ArrayList<MesAno> listaMesAno = lancamentoService.getMesesAnos(dataInicio.toDate(), dataFim.toDate(), tipo, null);
	
	        Double valorTotal = 0.0;
	        Double valorMedio = 0.0;
	        
	        // busca as lancamentos referentes a cada Mês e Ano
	        for(MesAno mesAno : listaMesAno)
	        {
	            MediaMensal mediaMensal = lancamentoService.pesquisar(mesAno.getMes(), mesAno.getAno(), agrupar, tipo, null, null); 
	            mediaMensal.setAno(mesAno.getAno().toString());
	            mediaMensal.setMes(Datas.getNomeMes(mesAno.getMes()));
	            
	            valorTotal += mediaMensal.getValorTotalMes(); 
	            listaRelatorio.add(mediaMensal);
	        }
	
	        // Calcula valor médio gasto por mês
	        Integer qtdMeses = listaRelatorio.size();
	        if(!valorTotal.equals(0.0))
	        {
	             valorMedio = valorTotal / qtdMeses;
	        }
	        
	        /*
	         * -------------------------------------------------------------------------------------------------------------------
	         * Seta as informações e abre o relatório .pdf
	         */
	        JRBeanCollectionDataSource jrBeanCollection = new JRBeanCollectionDataSource(listaRelatorio);
	
	        String caminhoRelatorio = Utilidades.getRealPath(this, Constantes.URL_RELATORIOS) + "/lancamentos/media_mensal.jasper";
	        String caminhoSubLancamentos = Utilidades.getRealPath(this, Constantes.URL_RELATORIOS)
	                + "/lancamentos/sub_lancamento.jasper";
	
	        //String caminhoRelatorio = "C:/sistemas/financas/java_src/relatorios/lancamentos/media_mensal.jasper";
	        //String caminhoSubLancamentos = "C:/sistemas/financas/java_src/relatorios/lancamentos/sub_lancamento.jasper";
	        
	
	        HashMap<String, Object> parametros = new HashMap<String, Object>();
	        parametros.put("sub_lancamentos", caminhoSubLancamentos);
	        parametros.put("dataInicial", dataInicio.toDate());
	        parametros.put("dataFinal", dataFim.toDate());
	        parametros.put("valorTotal", valorTotal);
	        parametros.put("valorMedio", valorMedio);
	
	        Utilidades.gerarRelatorioPDF(caminhoRelatorio, parametros, jrBeanCollection, response);
	        
    	}catch (ServletException e) {
    		logger.error("", e);
		}
    }
    
    public void printRelatorioEntradaSaida(HttpServletResponse response, DateTime dataInicio, DateTime dataFim)
    {
    	try {
	    	LancamentoService lancamentoService = new LancamentoService();
			
	        // lista que será enviada ao relatório
	        ArrayList<MediaMensal> listaRelatorio = new ArrayList<MediaMensal>();
	        
	        // busca os meses/anos para posteriormente buscar as lancamentos de cada Mês
	        ArrayList<MesAno> listaMesAno = lancamentoService.getMesesAnos(dataInicio.toDate(), dataFim.toDate(), null, null);
	
	        Double valorTotalEntrada = 0.0;
	        Double valorTotalSaida = 0.0;
	        Double valorLiquido = 0.0;
	        Double percentualValorSaida = 0.0;
	        Double percentualValorEntrada = 0.0;
	        Double valorTotal = 0.0;
	        
	        
	        // busca os lancamentos referentes a cada Mês e Ano
	        for(MesAno mesAno : listaMesAno)
	        {
	            MediaMensal mediaMensalEntrada = lancamentoService.pesquisar(mesAno.getMes(), mesAno.getAno(), false, Constantes.ENTRADA, null, null);
	            MediaMensal mediaMensalSaida = lancamentoService.pesquisar(mesAno.getMes(), mesAno.getAno(), false, Constantes.SAIDA, null, null);
	            
	            MediaMensal mediaEntradaSaida = new MediaMensal();
	            mediaEntradaSaida.setAno(mesAno.getAno().toString());
	            mediaEntradaSaida.setMes(Datas.getNomeMes(mesAno.getMes()));
	            //seta o valor total de entrada ENTRADA e SAIDA do mes
	            mediaEntradaSaida.setValorEntrada(mediaMensalEntrada.getValorTotalMes());
	            mediaEntradaSaida.setValorSaida(mediaMensalSaida.getValorTotalMes());
	            
	            //incrementa o valor total
	            valorTotalEntrada += mediaMensalEntrada.getValorTotalMes();
	            valorTotalSaida += mediaMensalSaida.getValorTotalMes();
	            
	            listaRelatorio.add(mediaEntradaSaida);
	        }
	
	        // Calcula valor médio gasto por mês
        	valorLiquido = valorTotalEntrada - valorTotalSaida;
        	
        	valorTotal = valorTotalEntrada + valorTotalSaida;
	        
        	percentualValorEntrada = (valorTotalEntrada / valorTotal)*100;
        	
        	percentualValorSaida = (valorTotalSaida / valorTotal)*100;
        
	        /*
	         * -------------------------------------------------------------------------------------------------------------------
	         * Seta as informações e abre o relatório .pdf
	         */
	        JRBeanCollectionDataSource jrBeanCollection = new JRBeanCollectionDataSource(listaRelatorio);
	
	        String caminhoRelatorio = Utilidades.getRealPath(this, Constantes.URL_RELATORIOS) + "/lancamentos/entrada_saida.jasper";
	        //String caminhoRelatorio = "C:/sistemas/financas/java_src/relatorios/lancamentos/entrada_saida.jasper";
	        
	
	        HashMap<String, Object> parametros = new HashMap<String, Object>();
	        parametros.put("dataInicial", dataInicio.toDate());
	        parametros.put("dataFinal", dataFim.toDate());
	        parametros.put("valorTotalEntrada", valorTotalEntrada);
	        parametros.put("valorTotalSaida", valorTotalSaida);
	        parametros.put("valorLiquido", valorLiquido);
	        parametros.put("valorTotal", valorTotal);
	        parametros.put("percentualValorEntrada", percentualValorEntrada);
	        parametros.put("percentualValorSaida", percentualValorSaida);
	
	        
			Utilidades.gerarRelatorioPDF(caminhoRelatorio, parametros, jrBeanCollection, response);
		
    	} catch (ServletException e) {
			logger.error("", e);
		}
        
    }

}
