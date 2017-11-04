/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import javax.persistence.EntityManager;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import es.claro.persistence.PersistenceManager;


public class GenericDao<T> {

	private Logger logger = LogManager.getLogger(GenericDao.class);
    private Class classeObjeto;

    public GenericDao(Class classeObjeto) {
        this.classeObjeto = classeObjeto;
    }

    //Gerencia o ciclo de vida da EntityManager
    //Biblioteca utilizada ScopedEntityManager-1.0-r5.jar
    private EntityManager em = PersistenceManager.getInstance().getEntityManagerFactory().createEntityManager();

    public boolean inserir(T obj) {
        try {
            getEm().getTransaction().begin();
            getEm().persist(obj);
            getEm().getTransaction().commit();
            return true;
        } catch (Exception e) {
        	logger.error("************** Erro ao inserir objeto. ************** ", e);
            return false;
        }
    }

    public boolean atualizar(T obj) {
        try {
            getEm().getTransaction().begin();
            getEm().merge(obj);
            getEm().getTransaction().commit();
            return true;
        } catch (Exception e) {
        	logger.error("************** Erro ao atualizar objeto. ************** ", e);
        }
        return false;
    }
    
    //Método para excluir um objeto no BD
    public boolean excluir(T obj) {
       try {
            getEm().getTransaction().begin();
            getEm().remove(obj);
            getEm().getTransaction().commit();
            return true;
        } catch (Exception e) {
        	logger.error("************** Erro ao excluir objeto. ************** ", e);
        }
        return false;
    }

    //Método para recuperar um objeto no BD
    public T getObjeto(int id) {
        try {
            getEm().getTransaction().begin();
            T a = (T) getEm().find(getClasseObjeto(),id);
            getEm().getTransaction().commit();
            return a;
        } catch (Exception e) {
        	logger.error("************** Erro ao carregar objeto. ************** ",	e);
        }
        return null;
    }

    
    /**
     * @return the classeObjeto
     */
    public Class getClasseObjeto() {
        return classeObjeto;
    }

    /**
     * @param classeObjeto the classeObjeto to set
     */
    public void setClasseObjeto(Class classeObjeto) {
        this.classeObjeto = classeObjeto;
    }

    /**
     * @return the em
     */
    public EntityManager getEm() {
        return em;
    }

    /**
     * @param em the em to set
     */
    public void setEm(EntityManager em) {
        this.em = em;
    }
    
}
