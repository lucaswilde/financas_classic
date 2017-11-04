/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package controle;

import java.util.ArrayList;
import java.util.Date;

import javax.persistence.Query;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.Hibernate;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;

import uteis.Utilidades;
import classes.Categoria;
import classesRelatorios.MediaPorCategoria;

/**
 *
 * @author Nelson Wilde
 * 
 *  Categoria
 */
public class CategoriaDAO 
{
	private Logger logger = LogManager.getLogger(CategoriaDAO.class);
	
    GenericDao<Categoria> dao = new GenericDao<Categoria>(Categoria.class);
    String hql = "";
    
    public boolean  salvar(Categoria c)
    {
    	if(c.getCodCategoria() == 0)
    	{ 
        	c.setCodCategoria(null);
        	return dao.inserir(c);
    	}
    	else
    	{
    		return dao.atualizar(c);
    	}
    }    

    public boolean excluir(int cod)
    {
		return dao.excluir(dao.getObjeto(cod));
	}
    
    public Categoria procurar(int cod)
    {
		return dao.getObjeto(cod);
	}

	@SuppressWarnings("unchecked")
	public ArrayList<Categoria> listar()
	{
        ArrayList<Categoria> lista = new ArrayList<Categoria>();
        try
        {
        	hql = "from Categoria order by descricao";
        	lista = (ArrayList<Categoria>) dao.getEm().createQuery(hql).getResultList()		;
        }
        catch (Exception e) 
        {
        	logger.error("", e);
		}
        return lista;
    }
	
	@SuppressWarnings("unchecked")
	public ArrayList<Categoria> pesquisar(String palavra)
	{
		ArrayList<Categoria> lista = new ArrayList<Categoria>();
		try
		{
			hql = "from Categoria where descricao like '%"+palavra+"%' order by descricao";

			Query qry = dao.getEm().createQuery(hql);
			
	        lista = (ArrayList<Categoria>)qry.getResultList(); 
        }
		catch (Exception e) 
        {
        	logger.error("", e);
		}
        return lista;
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
		ArrayList<MediaPorCategoria> retorno = new ArrayList<MediaPorCategoria>();
        try
        {
            StringBuffer sql = new StringBuffer();
            
            String cod = Utilidades.concatCodigoToSql(listaCategorias); 
            
            sql.append(" select distinct td.descricao as dsCategoria " );
            sql.append("		, sum(d.valor/( select count(DISTINCT EXTRACT (month from lancamento.data)) ");
            sql.append("							from lancamento ");
            sql.append(" 								where data between '" + dataInicio + "' and '" + dataFim + "' ");
            if (!cod.equals("")) {
            	sql.append("								and cod_categoria in ("+cod+")");
            }
            sql.append("    					)) as valor ");
            sql.append(" from lancamento d ");
            sql.append(" 	,categoria td ");
            sql.append(" where d.cod_categoria = td.cod_categoria ");
    		sql.append("	and d.data between '" + dataInicio + "' and '" + dataFim + "' ");
            sql.append("    and tipo = '" + tipo + "' ");
            if (!cod.equals("")) {
				sql.append("and d.cod_categoria in ("+cod+")");
			}
            sql.append(" group by td.descricao ");
            sql.append(" order by valor desc ");
            

            Session session = (Session) dao.getEm().getDelegate();
            SQLQuery qry = session.createSQLQuery(sql.toString());
            qry.addScalar("dsCategoria", Hibernate.STRING);
            qry.addScalar("valor", Hibernate.DOUBLE);
            
            qry.setResultTransformer(Transformers.aliasToBean(MediaPorCategoria.class));
            retorno = (ArrayList<MediaPorCategoria>) qry.list();
            
        }
        catch (Exception e) 
        {
        	logger.error("", e);
		}
        return retorno;
	}
}
