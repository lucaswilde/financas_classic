package servico;

import java.util.ArrayList;

import classes.Usuario;
import controle.UsuarioDAO;

public class UsuarioService {

	private UsuarioDAO usuarioDAO = new UsuarioDAO();
	
	public boolean salvar(Usuario c) {
		return usuarioDAO.salvar(c);
	}

	public boolean excluir(int cod) {
		return usuarioDAO.excluir(cod);
	}

	public Usuario login(Usuario usuario) {
		return usuarioDAO.login(usuario);
	}
	
	public ArrayList<Usuario> pesquisar(String nome) {
		return usuarioDAO.pesquisar(nome);
	}
	
	public ArrayList<Usuario> carregarUsuario(int codUsuario) {
		ArrayList<Usuario> lista = new ArrayList<Usuario>();
		lista.add(usuarioDAO.procurar(codUsuario));
		return lista;
	}
}
