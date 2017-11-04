package controleRelatorios;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import uteis.Constantes;

public class ReportFilter extends HttpServlet {

	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException,
    		IOException {
		try {
            String acao = request.getParameter("acao");

            if(acao.equals(Constantes.RELATORIO_MEDIA_MENSAL) 
            		|| acao.equals(Constantes.RELATORIO_ENTRADA_SAIDA))
            {
            	RequestDispatcher dispatcher = request.getRequestDispatcher("LancamentoRelatorio");
            	dispatcher.forward( request, response );
            }
            
            if(acao.equals(Constantes.RELATORIO_VALOR_POR_CATEGORIA_POR_DATA)
            		|| acao.equals(Constantes.RELATORIO_MEDIA_POR_CATEGORIA))
            {
            	RequestDispatcher dispatcher = request.getRequestDispatcher("CategoriaRelatorio");
            	dispatcher.forward( request, response );
            }
            
        } catch (Exception e) {
            throw new ServletException(e);
        }

	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse response) throws IOException, ServletException {
        processRequest(req, response);
    }
	
}
