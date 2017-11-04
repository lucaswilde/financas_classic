/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package uteis;

import java.text.NumberFormat;
import java.text.ParseException;
import java.util.Locale;

/**
 *
 * @author pavan
 */
public class Conversoes {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
    }
    public static int stringToInt(String s) {
        return Integer.parseInt(s);
    }
    public static double stringToDouble(String s) throws ParseException {
        try {
            NumberFormat nf = NumberFormat.getInstance();
            return nf.parse(s).doubleValue();            
        } catch (ParseException ex) {
            throw ex;
        }
    }
    public static float stringToFloat(String s) throws ParseException {
        try {
            NumberFormat nf = NumberFormat.getInstance();
            return nf.parse(s).floatValue();            
        } catch (ParseException ex) {
            throw ex;
        }
    }
    public static double stringToDouble(String s, Locale local) throws ParseException {
        try {
            NumberFormat nf = NumberFormat.getInstance(local);
            return nf.parse(s).doubleValue();            
        } catch (ParseException ex) {
            throw ex;
        }
    }
    public static String intToString(int vlr) {
        return String.valueOf(vlr);
    }
    public static String doubleToString(double vlr) {
        return String.valueOf(vlr);
    }
    public static String floatToString(float vlr) {
        return String.valueOf(vlr);
    }
}
