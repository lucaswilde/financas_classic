//Classe utilizada para definir o endpoint dos RemoteObject

package uteis
{

	public class ConexaoRemota{
		
		//endereço do servidor
		[Bindable]
//		public static var ENDERECO_SERVER :String = "http://localhost:8080/financas/messagebroker/amf";
		
//		public static var ENDERECO_SERVER :String = "http://mosaico.upf.br:8080/CadernoJava/messagebroker/amf";

		public static var ENDERECO_SERVER :String = Util.getURL()+"messagebroker/amf";
			
		public function ConexaoRemota(){
		}
		
				
	}
}