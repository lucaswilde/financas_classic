/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package classes;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 *
 * @author Nelson Wilde
 */
@Entity
@Table(name = "USUARIOS")
public class Usuario implements Serializable {
	@Id
	@Basic(optional = false)
    @Column(name = "COD_USUARIO")
	@SequenceGenerator(name="SEQ", sequenceName="SEQ_USUARIO",allocationSize=1)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="SEQ")
    private Integer codUsuario;
    
	@Basic(optional = false)
    @Column(name = "NOME")
    private String nome;
	
    @Basic(optional = false)
    @Column(name = "LOGIN")
    private String login;
    
	@Basic(optional = false)
    @Column(name = "SENHA")
    private String senha;
    
	@Basic(optional = false)
    @Column(name = "administrador")
    private Boolean administrador;
	
    public Usuario() {
    }

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public void setCodUsuario(Integer codUsuario) {
		this.codUsuario = codUsuario;
	}

	public Integer getCodUsuario() {
		return codUsuario;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getNome() {
		return nome;
	}

	public void setAdministrador(Boolean administrador) {
		this.administrador = administrador;
	}

	public Boolean getAdministrador() {
		return administrador;
	}


}
