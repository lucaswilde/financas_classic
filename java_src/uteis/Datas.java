/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package uteis;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.joda.time.DateTime;

/**
 *
 * @author pavan
 */
public class Datas {
    public static Calendar getDataAtual() {
        return Calendar.getInstance();
    }
    /**
     * Retorna uma nova data (Calendar) baseado na data passada por parâmetro
     * @param data Uma String no formato dd/mm/aaaa
     * @return Calendar 
     */
    public static Calendar getData(String data) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Calendar c = Calendar.getInstance();
        c.setTime(sdf.parse(data));
        return c;
    }

    public static Date getStringToData(String data) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        return sdf.parse(data);
    }

    public static Calendar getHora(String hora) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        Calendar c = Calendar.getInstance();
        c.setTime(sdf.parse(hora));
        return c;
    }
    
    public static Calendar getDataHora(String dataHora) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Calendar c = Calendar.getInstance();
        c.setTime(sdf.parse(dataHora));
        return c;
    }
    
    public static Calendar getDataHora(String data, String hora)
                                                throws ParseException {
        return getDataHora(data.trim()+" "+hora.trim());
    }
    
    public static String toDiaMesAno(Calendar c) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        return sdf.format(c.getTime());        
    }
    
    public static String toDiaMesAnoBanco(Date c) {
       Calendar cal = Calendar.getInstance();
       cal.setTime(c);
       return toDiaMesAnoBanco(cal);      
    }    
    
    public static String toDiaMesAnoBanco(Calendar c) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
        return sdf.format(c.getTime());        
    }    
    
    public static String toHoraMinutoSegundo(Calendar c) {
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        return sdf.format(c.getTime());        
    }
    
    public static String toDataHora(Calendar c) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        return sdf.format(c.getTime());        
    }
    
    public static void addDias(Calendar c, int dias) {
        c.add(Calendar.DAY_OF_MONTH, dias);
    }
    
    public static void addMes(Calendar c, int mes) {
        c.add(Calendar.MONTH, mes);
    }
    
    public static void addAnos(Calendar c, int anos) {
        c.add(Calendar.YEAR, anos);
    
    }
    
    public static void addHoras(Calendar c, int horas) {
        c.add(Calendar.HOUR_OF_DAY, horas);
    }
    
    public static void addMinutos(Calendar c, int minutos) {
        c.add(Calendar.MINUTE, minutos);
    }
    
    public static void addSegundos(Calendar c, int segundos) {
        c.add(Calendar.SECOND, segundos);
    }
    
    public static int getDiferencaDias(Calendar ini, Calendar fim) {
        long i = ini.getTimeInMillis(); 
        long f = fim.getTimeInMillis();
        return (int) ((f-i)/1000/60/60/24);
    }
    
    /**
     * Mostra a data e o nome do dia da semana.
     */
    public static String getDataComDiaDaSemana(Date data) {
        DateFormat df = new SimpleDateFormat("dd/MM/yyyy EEEEEE");
        return df.format(data);
    }
    
    /**
     * Retorna o nome do mês da data passada por parâmetro 
     */
    public static String getNomeMes(Date data) {
        DateFormat df = new SimpleDateFormat("MMMMM");
        return df.format(data);
    }
    
    /**
     * Retorna o ano da data passada por parâmetro 
     */
    public static String getAno(Date data) {
        DateFormat df = new SimpleDateFormat("yyyy");
        return df.format(data);
    }
    
    /**
     * Retorna o nome do mês conforme seu número. 
     *
     * @param mes
     */
    public static String getNomeMes(Integer mes) {
       if(mes.equals(1)){
           return "Janeiro";
       }
       if(mes.equals(2)){
           return "Fevereiro";
       }
       if(mes.equals(3)){
           return "Março";
       }
       if(mes.equals(4)){
           return "Abril";
       }
       if(mes.equals(5)){
           return "Maio";
       }
       if(mes.equals(6)){
           return "Junho";
       }
       if(mes.equals(7)){
           return "Julho";
       }
       if(mes.equals(8)){
           return "Agosto";
       }
       if(mes.equals(9)){
           return "Setembro";
       }
       if(mes.equals(10)){
           return "Outubro";
       }
       if(mes.equals(11)){
           return "Novembro";
       }
       if(mes.equals(12)){
           return "Dezembro";
       }
       return mes.toString();
    }
    
    /**
     * Cria uma nova data
     * 
     * @param ano
     * @param mes
     * @param dia
     * @param hora
     * @param minuto
     * @param segundo
     * @return
     */
    public static DateTime createDate(int ano, int mes, int dia, int hora, int minuto, int segundo){
    	return new DateTime(ano, mes, dia , hora, minuto, segundo, 0);
    }
    
    /**
     * Cria uma nova data
     * 
     * @param ano
     * @param mes
     * @param dia
     * @param hora
     * @param minuto
     * @param segundo
     * @return caso algum valor seja nulo retorna null
     */
    public static DateTime createDateFromParameters(String ano, String mes, String dia, int hora, int minuto, int segundo){
    	
    	if(ano != null && mes != null && dia != null){
    		return createDate(Integer.parseInt(ano), Integer.parseInt(mes), Integer.parseInt(dia), hora, minuto, segundo);
    	}
		return null;
		
    }
    
    
    
    
    
    
    
    
}
