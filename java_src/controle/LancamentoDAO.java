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

import uteis.Utilidades;
import classes.Lancamento;
import classesRelatorios.MediaMensal;
import classesRelatorios.MesAno;

/**
 * 
 * @author Nelson Wilde
 * 
 *         Lancamento
 */
public class LancamentoDAO
{

	private Logger logger = LogManager.getLogger(LancamentoDAO.class);

	GenericDao<Lancamento> dao = new GenericDao<Lancamento>(Lancamento.class);

	public boolean salvar(Lancamento c)
	{
		if (c.getCodLancamento() == 0)
		{
			c.setCodLancamento(null);
			return dao.inserir(c);
		} else
		{
			return dao.atualizar(c);
		}
	}

	public boolean excluir(int cod)
	{
		return dao.excluir(dao.getObjeto(cod));
	}

	/**
	 * Carrega todas as lancamentos de um mes/ano
	 * 
	 * @param mes
	 * @param ano
	 * @param agrupar
	 * @return
	 */
	public MediaMensal listar(Integer mes, Integer ano, String tipo,
			String obs, Integer codCategoria)
	{
		MediaMensal mediaMensal = new MediaMensal();
		StringBuffer hql = new StringBuffer();
		Query qry;
		try
		{
			hql.append("from Lancamento ");
			hql.append(" where tipo = '" + tipo + "'");
			if (ano != null && ano != 0)
			{
				hql.append(" and extract(year from data) = " + ano);
			}
			if (mes != null && mes != 0)
			{
				hql.append(" and extract(month from data) = " + mes);
			}
			if (obs != null && obs != "")
			{
				hql.append(" and obs like '%" + obs + "%' ");
			}
			if (codCategoria != null && codCategoria != 0)
			{
				hql.append(" and categoria.codCategoria = " + codCategoria);
			}
			hql.append(" order by data desc ");

			qry = dao.getEm().createQuery(hql.toString());

			mediaMensal.setListaLancamentos((ArrayList<Lancamento>) qry
					.getResultList());
		} catch (Exception e)
		{
			logger.error("", e);
		}
		return mediaMensal;
	}

	public ArrayList<Object> listarValorPorCategoria(Integer mes, Integer ano,
			String tipo)
	{
		StringBuffer hql = new StringBuffer();
		Query qry;
		ArrayList<Object> listaConsulta = new ArrayList<Object>();
		try
		{
			hql.append(" select l.categoria.descricao ");
			hql.append("          , sum(l.valor) as valor ");
			hql.append(" from Lancamento l ");
			hql.append(" where tipo = :tipo ");
			if (ano != null && ano != 0)
			{
				hql.append(" and extract(year from l.data) = " + ano);
			}
			if (mes != null && mes != 0)
			{
				hql.append(" and extract(month from l.data) = " + mes);
			}
			hql.append(" group by l.categoria.descricao ");
			hql.append(" order by l.categoria.descricao ");

			qry = dao.getEm().createQuery(hql.toString());
			qry.setParameter("tipo", tipo);

			listaConsulta = (ArrayList<Object>) qry.getResultList();
		} catch (Exception e)
		{
			logger.error("", e);
		}
		return listaConsulta;
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
	public ArrayList<MesAno> getMesesAnos(Date dataInicio, Date dataFim,
			String tipo, ArrayList<Integer> listaCategorias)
	{
		ArrayList<MesAno> retorno = new ArrayList<MesAno>();
		try
		{
			StringBuffer sql = new StringBuffer();

			sql.append(" select distinct extract (month from data) as mes ");
			sql.append("        , extract (year from data) as ano ");
			sql.append(" from lancamento ");
			sql.append(" where data between '" + dataInicio + "' and '"
					+ dataFim + "' ");

			if (tipo != null)
			{
				sql.append("    and tipo = '" + tipo + "' ");
			}

			String cod = Utilidades.concatCodigoToSql(listaCategorias);
			if (!cod.equals(""))
			{
				sql.append("	and cod_categoria in (" + cod + ")");
			}

			sql.append(" order by ano, mes ");

			Query qry = dao.getEm().createNativeQuery(sql.toString());
			ArrayList<Object> lista = (ArrayList<Object>) qry.getResultList();

			for (Object obj : lista)
			{
				Object[] registro = (Object[]) obj;
				MesAno mesAno = new MesAno();

				Double tempMes = (Double) registro[0];
				mesAno.setMes(tempMes.intValue());

				Double tempAno = (Double) registro[1];
				mesAno.setAno(tempAno.intValue());

				retorno.add(mesAno);
			}
		} catch (Exception e)
		{
			logger.error("", e);
		}
		return retorno;
	}

}
