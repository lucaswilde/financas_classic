/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package controle;

import java.util.ArrayList;

import javax.persistence.Query;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import classes.Usuario;

/**
 * 
 * @author Nelson Wilde
 * 
 *         Usuario do Veiculo
 */
public class UsuarioDAO {
	
	private Logger logger = LogManager.getLogger(UsuarioDAO.class);
	
	GenericDao<Usuario> dao = new GenericDao<Usuario>(Usuario.class);

	public boolean salvar(Usuario c) {
		if (c.getCodUsuario() == 0) {
			c.setCodUsuario(null);
			return dao.inserir(c);
		} else {
			return dao.atualizar(c);
		}
	}

	public boolean excluir(int cod) {
		return dao.excluir(dao.getObjeto(cod));
	}

	public Usuario login(Usuario usuario) {
		try {
			String hql = "";
			hql = "from Usuario u " + " where u.login = '" + usuario.getLogin()
					+ "' " + " and u.senha = '" + usuario.getSenha() + "'";
			Query qry = dao.getEm().createQuery(hql);
			ArrayList<Usuario> lista = (ArrayList<Usuario>) qry.getResultList();
			if (lista.size() > 0) {
				return lista.get(0);
			} else {
				return null;
			}
		} catch (Exception e) {
			logger.error("", e);
			return null;
		}
	}
	
	public ArrayList<Usuario> pesquisar(String nome) {
		ArrayList<Usuario> lista = new ArrayList<Usuario>();
		try {
			String hql = "";
			hql = "from Usuario u where u.nome like '%"+nome+"%'";
			Query qry = dao.getEm().createQuery(hql);
			lista = (ArrayList<Usuario>) qry.getResultList();

		} catch (Exception e) {
			logger.error("", e);
		}
		return lista;
	}

	public Usuario procurar(int codUsuario){
		return dao.getObjeto(codUsuario);
	}
}
