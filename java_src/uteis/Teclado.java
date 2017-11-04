/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package uteis;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author pavan
 */
public class Teclado {

    public static void main(String args[]) {
        System.out.print("Informe uma String:");
        String valor = lerString();
        System.out.println("String informada:" + valor);
        System.out.print("Informe um inteiro:");
        int i = lerInt();
        System.out.println("Inteiro informada:" + i);
    }

    public static String lerString() {
        try {
            InputStreamReader isr = new InputStreamReader(System.in);
            BufferedReader br = new BufferedReader(isr);
            return br.readLine();
        } catch (IOException ex) {
            return "";
        }
    }

    public static int lerInt() {
        String s;
        while (true) {
            s = lerString();
            if (TestaValores.intValido(s)) {
                return Integer.parseInt(s);
            } else {
                System.out.print("Isso não é um inteiro. Digite novamente:");
            }
        }
    }
    public static double lerDouble() {
        String s;
        while (true) {
            s = lerString();
            if (TestaValores.doubleValido(s)) {
                return Double.parseDouble(s);
            } else {
                System.out.print("Isso não é um double. Digite novamente:");
            }
        }
    }
}









