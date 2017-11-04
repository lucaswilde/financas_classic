package classes
{
	[RemoteClass(alias="classes.Usuario")]
	public class Usuario
	{
		public var codUsuario:int;
		public var login:String;
		public var senha:String;
		public var nome:String = "";
		public var administrador:Boolean;
		
		public function Usuario(){
			
		}
	}
}