/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package uteis;

import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 * Esta classe serve para facilitar a requisição de informações
 * do usuário
 * @author Willingthon Pavan
 * @version 1.0
 */
public class Dialogos {
    /**
     * Método responsável por mostrar uma mensagem ao usuário
     * @param msg A mensagem a ser mostrada
     */
    public static void mensagem(String msg) {
        mensagem(msg, "Mensagem do sistema");
    }
    /**
     * Método responsável por mostrar uma mensagem ao usuário
     * especificando a mensagem e o título
     * @param msg A mensagem a ser mostrada
     * @param titulo O título da janela
     */
    public static void mensagem(String msg, String titulo) {
        JOptionPane.showMessageDialog(null, msg, titulo,
                                    JOptionPane.PLAIN_MESSAGE);
    }
    public static void mensagemInformacao(String msg) {
        mensagemInformacao(msg, "Informação...");
    }
    public static void mensagemInformacao(String msg, String titulo) {
        JOptionPane.showMessageDialog(null, msg, titulo,
                             JOptionPane.INFORMATION_MESSAGE);
    }
    public static void mensagemAtencao(String msg) {
        mensagemAtencao(msg, "Atençao...");
    }
    public static void mensagemAtencao(String msg, String titulo) {
        JOptionPane.showMessageDialog(null, msg, titulo,
                             JOptionPane.WARNING_MESSAGE);
    }
    public static void mensagemErro(String msg) {
        mensagemErro(msg, "Erro...");
    }
    public static void mensagemErro(String msg, String titulo) {
        JOptionPane.showMessageDialog(null, msg, titulo,
                             JOptionPane.ERROR_MESSAGE);
    }
    public static boolean confirmar(String msg) {
        return confirmar(msg,"Confirme...");
    }
    public static boolean confirmar(String msg, String titulo) {
        int escolha = confirmar(msg,titulo,
                        new String[]{"Sim","não"},0);
        return (escolha==0);
    }
    public static int confirmar(String msg, String titulo,
                                String[] opcoes, int selecao) {
        int escolha = JOptionPane.showOptionDialog(null, 
                msg,titulo, JOptionPane.YES_NO_OPTION, 
                JOptionPane.QUESTION_MESSAGE, 
                null, opcoes, opcoes[selecao]);
        return escolha;
    }
    public static int lerInteiro(String msg) {
        return lerInteiro(msg,"Informe...");
    }
    public static int lerInteiro(String msg, String titulo) {
        String s = JOptionPane.showInputDialog(null,msg,titulo,
                                    JOptionPane.PLAIN_MESSAGE);
        if(TestaValores.intValido(s))
            return Conversoes.stringToInt(s);
        else {
            mensagemErro("Não é um inteiro válido!\n" +
                         "Informe novamente...");
            return lerInteiro(msg, titulo);
        }
    }
    public static String lerString(String msg) {
        return lerString(msg,"Informe...");
    }
    public static String lerString(String msg, String titulo) {
        return JOptionPane.showInputDialog(null,msg,titulo,
                                    JOptionPane.PLAIN_MESSAGE);       
    }
    public static float lerFloat(String msg) {
        return lerFloat(msg,"Informe...");
    }
    public static float lerFloat(String msg, String titulo) {
        try {
            String s = JOptionPane.showInputDialog(null, msg, 
                    titulo, JOptionPane.PLAIN_MESSAGE);
            return Conversoes.stringToFloat(s);
        } catch (ParseException ex) {
            mensagemErro("Não é um float válido!\n" +
                         "Informe novamente...");
            return lerFloat(msg, titulo);
        }
    }
}







