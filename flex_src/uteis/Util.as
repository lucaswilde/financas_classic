package uteis
{
	import flash.display.DisplayObject;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.events.CloseEvent;
	import mx.formatters.DateFormatter;
	import mx.formatters.NumberFormatter;
	import mx.formatters.PhoneFormatter;
	import mx.managers.PopUpManager;
	
	import uteis.componentes.BarraProgresso;
	
	public class Util
	{
		
		public function Util()
		{
		}

		//armazena a quantidade de barras de progressos mostradas na tela
		private static var qtdBarras:int = 0;
		
		//armazena a quantidade de requisições para mostrar barras de progressos na tela 
		private static var qtdRequisicoesBarras:int = 0;
		
		private static var barra:BarraProgresso;
		
		/**
		 * Adiciona um PopUp na tela
		 **/
		public static function showPopUp(pai:DisplayObject, tela:IFlexDisplayObject, onFechar:Function = null,modal:Boolean = true):void
		{
			PopUpManager.addPopUp(tela, pai, modal);
			PopUpManager.centerPopUp(tela);
			
			if(onFechar != null)
			{
				tela.addEventListener(CloseEvent.CLOSE, onFechar);
			}
		}
		
		/**
		 * Remove o PopUp da tela
		 **/
		public static function removePopUp(tela:IFlexDisplayObject):void
		{
			PopUpManager.removePopUp(tela);
		}

		public static function getMeses():ArrayCollection
		{
			return new ArrayCollection([{data:"01",label:"Janeiro"},
										{data:"02",label:"Fevereiro"},
										{data:"03",label:"Março"},
										{data:"04",label:"Abril"},
										{data:"05",label:"Maio"},
										{data:"06",label:"Junho"},
										{data:"07",label:"Julho"},
										{data:"08",label:"Agosto"},
										{data:"09",label:"Setembro"},
										{data:"10",label:"Outubro"},
										{data:"11",label:"Novembro"},
										{data:"12",label:"Dezembro"}]);			
		}
		
		/**
		 * Retorna ano de uma data
		 **/
		public static function extrairAno(data:Date):String
		{
			var df:DateFormatter = new DateFormatter();
			df.formatString = "YYYY";
			
			return df.format(data);
		}
		
		/**
		 * Retorna ano de uma data
		 **/
		public static function extrairMes(data:Date):String
		{
			var df:DateFormatter = new DateFormatter();
			df.formatString = "MM";
			
			return df.format(data);
		}
		
		/**
		 * Retorna o um numero formatado em R$
		 **/
		public static function formatarDinheiro(valor:Number):String
		{
			var nf:NumberFormatter = new NumberFormatter();
			nf.decimalSeparatorFrom = ".";
			nf.decimalSeparatorTo = ",";
			nf.thousandsSeparatorFrom = ",";
			nf.thousandsSeparatorTo = ".";
			nf.precision = 2;
			
			return nf.format(valor);
		}
		
		/**
		 * Retorna a data formatada no formato dd/mm/yyyy
		 **/
		public static function formatarData(data:Date):String
		{
			var df:DateFormatter = new DateFormatter();
			df.formatString = "DD/MM/YYYY";			
			
			return df.format(data);
		}
		
		/**
		 * Mostra barra de progresso
		 **/
		public static function showProgressBar(tela:DisplayObject):void
		{
			qtdRequisicoesBarras++;
			
			//faz o controle para mostrar apenas uma barra de progresso na tela
			if(qtdBarras == 0)
			{
				barra = new BarraProgresso()
				showPopUp(tela, barra);
				
				qtdBarras++;
			}
		}
		
		/**
		 * Mostra barra de progresso
		 **/
		public static function removeProgressBar():void
		{
			//se existir apenas uma barra de progresso na tela remove
			if(qtdRequisicoesBarras == 1)
			{
				removePopUp(barra);
				qtdBarras--;
			}
			qtdRequisicoesBarras--;
		}
		
		/**
		 * Formata um número de telefone
		 **/
		public static function formatarTelefone(fone:String):String
		{
			var foneFormata:PhoneFormatter = new PhoneFormatter();
			foneFormata.formatString = "(##)####-####";
			return foneFormata.format(fone);			
		}
		
		/**
		 * Retorna a url do sistema
		 */
		public static function getURL():String
		{
			var url:String = Application.application.url;
			var indice:int = url.lastIndexOf("/");
			url = url.substr(0, indice + 1);
			return url;
		}
		
		
		/**
         *
         * Funcao q retorna o valor de um atributo com notacao de ponto
         * Ex.: itColetaSinalVital.sinalVital.dsSinalVital
         *
         **/
        public static function getAttributeValue(item:Object, attributeFullName:String):Object
        {
            var attributeValue:Object = null;

            var attributeNameIndex:int = attributeFullName.indexOf(".");

            if (attributeNameIndex > 0)
            {
                var attributeName:String = attributeFullName.substr(0, attributeNameIndex);
                var nextAttributeName:String = attributeFullName.substr(attributeNameIndex + 1);

                if (item.hasOwnProperty(attributeName))
                    attributeValue = getAttributeValue(item[attributeName], nextAttributeName);
            }
            else
            {
                if (item != null && item.hasOwnProperty(attributeFullName))
                    attributeValue = (item ? item[attributeFullName] : "");
            }

            return attributeValue;
        }
	}
}