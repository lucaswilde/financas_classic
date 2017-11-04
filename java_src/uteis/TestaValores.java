/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package uteis;

import java.text.NumberFormat;
import java.util.Locale;

/**
 * Classe responsável por testar a transformação de Strings para tipos específicos
 * @author pavan
 */
public class TestaValores {
    /**
     * Função responsável por testar se o conteúdo de uma String é Inteiro.
     * Ex.: if(intValido("10")) {...}
     * @param vlr String com o valor a ser testado.
     * @return boolean - true: int válido; false: não inteiro;
     */
    public static boolean intValido(String vlr) {
        try {
            Integer.parseInt(vlr);
            return true;
        } catch(Exception e) {
            return false;
        }
    }
    public static boolean doubleValido(String vlr) {
        NumberFormat nf = NumberFormat.getInstance();
        return doubleValido(vlr,nf);
    }
    public static boolean doubleValido(String vlr, Locale local) {
        NumberFormat nf = NumberFormat.getInstance(local);
        return doubleValido(vlr,nf);
    }
    private static boolean doubleValido(String vlr, NumberFormat nf) {
        try {
            nf.parse(vlr).doubleValue();
            return true;
        } catch(Exception e) {
            return false;
        }
    }
    public static boolean floatValido(String vlr) {
        NumberFormat nf = NumberFormat.getInstance();
        return floatValido(vlr,nf);
    }
    public static boolean floatValido(String vlr, Locale local) {
        NumberFormat nf = NumberFormat.getInstance(local);
        return floatValido(vlr,nf);
    }
    private static boolean floatValido(String vlr, NumberFormat nf) {
        try {
            nf.parse(vlr).floatValue();
            return true;
        } catch(Exception e) {
            return false;
        }
    }
}





