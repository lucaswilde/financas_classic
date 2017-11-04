package uteis
{
	public class ImageResource
	{
		
		[Embed(source="imagens/ok.png")]
		[Bindable]
		public var salvar:Class;
		
		[Embed(source="imagens/add.png")]
		[Bindable]
		public var novo:Class;
		
		[Embed(source="imagens/cancel.png")]
		[Bindable]
		public var excluir:Class;
		
		[Embed(source="imagens/alter.png")]
		[Bindable]
		public var alterar:Class;
		
		[Embed(source="imagens/close.png")]
		[Bindable]
		public var fechar:Class;
		
		[Embed(source="imagens/fechar.png")]
		[Bindable]
		public var desligar:Class;
		
		[Embed(source="imagens/Filtrar.png")]
		[Bindable]
		public var pesquisar:Class;
		
		[Embed(source="imagens/find.png")]
		[Bindable]
		public var abrirForm:Class;
		
		[Embed(source="imagens/refresh.gif")]
		[Bindable]
		public var atualizar:Class;
		
		[Embed(source="imagens/usuarios.png")]
		[Bindable]
		public var usuarios:Class;
		
		[Embed(source="imagens/mini_icons/Add_16x16.png")]
		[Bindable]
		public var adicionar:Class;
		
		[Embed(source="imagens/mini_icons/wrench.png")]
		[Bindable]
		public var manutencao:Class;
		
		[Embed(source="imagens/mini_icons/coins_24.png")]
		[Bindable]
		public var moedas:Class;
		
		[Embed(source="imagens/grafico_32x32.png")]
		[Bindable]
		public var grafico_32x32:Class;
		
		[Embed(source="imagens/grafico_128x128.png")]
		[Bindable]
		public var grafico_128x128:Class;
		
		[Embed(source="imagens/mini_icons/coins_add.png")]
		[Bindable]
		public var moedasAdd:Class;
		
		[Embed(source="imagens/mini_icons/coins_delete.png")]
		[Bindable]
		public var moedasRemove:Class;
		
		[Embed(source="imagens/mini_icons/coins _16x16.png")]
		[Bindable]
		public var moedas16x16:Class;
		
		[Embed(source="imagens/cancel_16x16.png")]
		[Bindable]
		public var cancel16x16:Class;
		
		[Embed(source="imagens/cancel_24x24.png")]
		[Bindable]
		public var cancel24x24:Class;
		
		[Embed(source="imagens/cancel_32x32.png")]
		[Bindable]
		public var cancel32x32:Class;
		
		[Embed(source="imagens/Vista_icons_08.png")]
		[Bindable]
		public var login:Class;
		
		[Embed(source="imagens/user_32x32.png")]
		[Bindable]
		public var usuario32x32:Class;
		
		[Embed(source="imagens/categoria_32x32.png")]
		[Bindable]
		public var categoria32x32:Class;
		
		[Embed(source="imagens/sales_report_32.png")]
		[Bindable]
		public var saldo32x32:Class;
		
		[Embed(source="imagens/accept_blue_32.png")]
		[Bindable]
		public var salvarBlue32x32:Class;
		
		private static var imageResource:ImageResource;
 
        public static function getInstancia(): ImageResource 
        {
		    if( imageResource == null ){
		 		imageResource = new ImageResource();
		    }
			return imageResource;
        }		
	}
}