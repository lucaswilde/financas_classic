package uteis.componentes {
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.controls.TextInput;
	import mx.formatters.CurrencyFormatter;

	
	[Event(name="valueChange", type="flash.events.Event")] 
	[Event(name="propertiesNumberFormatChange", type="flash.events.Event")] 
	 
	public class NumericInput extends TextInput { 

	
		[Bindable(event="propertiesNumberFormatChange")]
		//public var nf:NumberFormatter;
		public var nf:CurrencyFormatter;
		public var nf_us:CurrencyFormatter;
		private var _precision:uint = 2;
		private var _useNegativeSign:Boolean;
		private var _useThousandsSeparator:Boolean = true;
		private var _value:Object;
		
		private var precisionChanged:Boolean;
		private var onlyDigits:RegExp = new RegExp("[^\\d]", "g");
		private var useNegativeSignChanged:Boolean;
		private var useThousandsSeparatorChanged:Boolean;
		
		public static const PROPERTIES_NUMBER_FORMAT_CHANGE:String = "propertiesNumberFormatChange";
		public static const VALUE_CHANGE:String = "valueChange";

		public function NumericInput() {
			super();
			//Alert.show("NumericInput");
	        this.nf = new CurrencyFormatter();
	        this.nf.precision = this._precision;
	        this.nf.useNegativeSign = this._useNegativeSign;
	        this.nf.useThousandsSeparator = this._useThousandsSeparator;
	        //this.nf.rounding = "nome";
	        this.nf.decimalSeparatorTo = ",";
	        if (this.useThousandsSeparator)
	           this.nf.thousandsSeparatorTo = ".";
	        this.nf.currencySymbol = "";
	        this.nf.alignSymbol = "left";
	        
			//this.addEventListener(Event.CHANGE, this.formatHandler, false, 0, true);
			this.addEventListener(FocusEvent.FOCUS_OUT, this.formatHandler, false, 0, true);
			this.addEventListener(FocusEvent.FOCUS_IN, this.setCursor, false, 0, true);
			this.resourceManager.addEventListener(Event.CHANGE, this.formatHandler, false, 0, true);				
            this.addEventListener(KeyboardEvent.KEY_DOWN,interceptKey,true);

	        this.maxChars = 20;
	        this.restrict = "0-9\\,"; 
	        this.setStyle("textAlign", "right");
	        this.value = 0;
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var formatChange:Boolean = (this.precisionChanged || this.useNegativeSignChanged || this.useThousandsSeparatorChanged); 
			
			if (this.precisionChanged) {
				this.precisionChanged = false;
				this.nf.precision = this.precision;
			}
			
			if (this.useNegativeSignChanged) {
				this.useNegativeSignChanged = false;
				this.nf.useNegativeSign = this.useNegativeSign;
				this.restrict = (this.useNegativeSign) ? "0-9\\-\\," : "0-9\\,";
			}
			
			if (this.useThousandsSeparatorChanged) {
				this.useThousandsSeparatorChanged = false;
				this.nf.useThousandsSeparator = this.useThousandsSeparator 
			}
			//Alert.show("this.text: "+this.text);
			//Alert.show("this.value: "+this.value);
			if (formatChange) {
				this.value = this.text;
				//this.value = this.nf.format(this.text);
				this.dispatchEvent(new Event(NumericInput.PROPERTIES_NUMBER_FORMAT_CHANGE));
			}
			formatHandler(null);
		}
		
///////////////////////////////////////////////// Propriedades ////////////////////////////////////////////////		
		
		public function get precision():uint {
			return this._precision;
		}
		
		/** Seta o número de casas decimais. Default = 2 */
		[Inspectable(defaultValue=2)]
		public function set precision(value:uint):void {
			if (this.precision != value) {
				this._precision = value;
				this.precisionChanged = true;
				this.invalidateDisplayList();
			}
		}

		public function get useNegativeSign():Boolean {
			return this._useNegativeSign;
		}
		
		/** Se permite o uso de sinal negativo. Default = false */
		[Inspectable(defaultValue=false)]
		public function set useNegativeSign(value:Boolean):void {
			if (this.useNegativeSign != value) {
				this._useNegativeSign = value;
				this.useNegativeSignChanged = true;
				this.invalidateDisplayList();
			}
		}
		
		public function get useThousandsSeparator():Boolean {
			return this._useThousandsSeparator;
		}
		
		/** Se deve usar separador de milhar. Default = true. */
		[Inspectable(defaultValue=true)]
		public function set useThousandsSeparator(value:Boolean):void {
			if (this.useThousandsSeparator != value) {
				this._useThousandsSeparator = value;
				this.useThousandsSeparatorChanged = true;
				this.invalidateDisplayList();
			}
		} 

		public function get value():Object {
			//Alert.show("get value");
			return this._value;
		}		
		
		[Bindable(event="valueChange")]
		public function set value(value:Object):void {
			//Alert.show("set value");
			this._value = this.toNumber(value);
			this.text = this.nf.format(this._value);   
			this.dispatchEvent(new Event(NumericInput.VALUE_CHANGE));
			
		}
		
/////////////////////////////////////////////////// Métodos ///////////////////////////////////////////////////		
		
		private function formatHandler(event:Event):void {
			//Alert.show("formatHandler");
			
            this.nf_us = new CurrencyFormatter();
	        this.nf_us.precision = this._precision;
	        this.nf_us.useNegativeSign = this._useNegativeSign;
	        this.nf_us.useThousandsSeparator = this._useThousandsSeparator;
	        //this.nf.rounding = "nome";
	        this.nf_us.decimalSeparatorTo = ",";
	        if (this.useThousandsSeparator)
	           this.nf_us.thousandsSeparatorTo = ".";
	        this.nf_us.currencySymbol = "";
	        this.nf_us.alignSymbol = "left";			
			
			//Alert.show("ant this.text: "+this.text);
			//Alert.show("ant this.value: "+this.value);	
					
			this.value = this.nf_us.format( this.toNumber( ajustaFormato(this.text) ) ); 
			
			//Alert.show("this.text: "+this.text);
			//Alert.show("this.value: "+this.value);				
			
			//this.value = this.text;

			this.setCursor(null);
		}
		
	    private function ajustaFormato(str:String):String {
	    	var strRetorno:String = "";
	    	var strDecimais:String = "";
	    	var results:Array;
	    	if ((str.indexOf(",") < 0) && (str.indexOf(".") < 0)){
               strDecimais = casasDecimais("", this.precision); 
               strRetorno = str+","+strDecimais; 
            } else if ((str.indexOf(",") < 0) && (str.indexOf(".") > 0)){
               results = str.split("."); 
               strDecimais = casasDecimais(results[1], this.precision); 
               strRetorno = results[0]+","+strDecimais; 
            } else if ((str.indexOf(",") > 0) ){
               results = str.split(","); 
               strDecimais = casasDecimais(results[1], this.precision); 
               strRetorno = results[0]+","+strDecimais; 
            }    
            
            return strRetorno;
	    }
	    
	    private function casasDecimais(str:String, qtd:int):String {
	    	if (str == null)
	    		str = "";
	        while (str.length < qtd) {
	             str+="0";
	        } 
	        if (str.length > qtd){
	          	str = str.substr(0, this.precision);
	        }     
            return str;
	    }	    
	    		
		
	    private function setCursor(event:FocusEvent):void {
//	        this.setSelection(this.length, this.length);
	    }
	    
	    /** 
	    * Converte value.toString() para Number, se value não for Number, desconsiderando 
	    * os caracteres q não são dígitos e respeitando as configurações.
	    * Se value == null então retorna 0. 
	    */
	    public function toNumber(value:Object):Number {
	    	if (value is Number) return new Number(value);

	    	var retorno:Number = 0;
	    	
			if (value != null) {
		        retorno = Number(value.toString().replace(this.onlyDigits, ""));

				// Se estiver marcado q pode ser usado sinal negativo e se encontrá-lo, então multiplica por -1
				if (this.useNegativeSign && value.toString().indexOf("-") > -1) retorno *= -1; 
			}

			return (retorno / Math.pow(10, this._precision));
	    }
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
      private function interceptKey( event:flash.events.KeyboardEvent ) : void
      {
      	 //Alert.show("Tecla: "+event.keyCode+" Letra: "+event.charCode); 
      	 //if (event.keyCode == 188){
      	 //   this.text += "00"; 
      	 //   formatHandler(null);
      	 //}
      	 
         if( event.keyCode == Keyboard.BACKSPACE ) {

         }
         else if( event.keyCode == Keyboard.SPACE ) {
 
         }
         else if( event.keyCode == Keyboard.DELETE ) {

         }
         else if( event.keyCode == Keyboard.LEFT ) {

         }
         else if( event.keyCode == Keyboard.RIGHT ) {

         }
         else if( event.keyCode == Keyboard.END ) {

         }
         else if( event.keyCode == Keyboard.HOME ) {

         }


      }
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	}
}