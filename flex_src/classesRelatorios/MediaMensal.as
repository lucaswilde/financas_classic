package classesRelatorios
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias="classesRelatorios.MediaMensal")]
	public class MediaMensal
	{
		public var mes:String;
		
		public var ano:String;
		
		public var listaLancamentos:ArrayCollection;
		
		public var valorTotalMes:Number;
		
		public var valorEntrada:Number;
		
		public var valorSaida:Number;
		
		public var valorSaldo:Number;
		
	}
}