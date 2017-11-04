package classes
{
	[Bindable]
	[RemoteClass(alias="classes.Lancamento")]
	public class Lancamento
	{
		public var codLancamento:int;
		
		public var valor:Number;
		
		public var data:Date;
		
		public var obs:String;
		
		public var categoria:Categoria = new Categoria();
		
		public var tipo:String;
		
		public var parcelado:Boolean;
		
		public var qtdParcelas:Number;
		 
	}
}