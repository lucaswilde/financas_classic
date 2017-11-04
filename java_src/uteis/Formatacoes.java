/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package uteis;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

/**
 * Esta classe serve para disponibilizar um conjunto de
 * métodos que podem auxiliar na construção de sistemas
 * 
 * @author Willingthon Pavan
 */
public class Formatacoes {
    public static void main(String args[]) {
        double d = 2000.50;
        System.out.println(formataMoeda(d));
        System.out.println(formataValor("##0.000", d));
        System.out.println(formataValor("US$ ###,##0.0", d, Locale.US));
    }
    /**
     * Função responsável por formatar um valor double no formato
     * moeda.
     * Autor: Willingthon Pavan
     * @param valor - Valor a ser transformado para formato moeda
     * @return String com o valor formatado
     */
    public static String formataMoeda(double valor) {
        DecimalFormat meuFormato = new DecimalFormat("R$ ###,###,##0.00");
        return meuFormato.format(valor);
    }
     /**
     * Função responsável por formatar um valor double para
     * String
     * @param formato Fortamatação utilizada
     * @param valor Valor a ser transformado     *         
     * @return String com o valor formatado
     */
    public static String formataValor(String formato, double valor) {
        DecimalFormat meuFormato = new DecimalFormat(formato);
        return meuFormato.format(valor);
    }
    /**
     * Formata o valor conforme o formato, o valor e o Local
     * @param formato Formato a ser utilizado (Ex.: "R$ ###,##0.00")
     * @param valor Valor a ser formatado
     * @param local Local utilizado para o conjunto de simbolos (Ex. Locale.US)
     * @return String Valor formatado.
     */
    public static String formataValor(String formato,double valor, Locale local) {
        DecimalFormat meuFormato = new DecimalFormat(formato);
        meuFormato.setDecimalFormatSymbols(new DecimalFormatSymbols(local));
        return meuFormato.format(valor);
    }
}



