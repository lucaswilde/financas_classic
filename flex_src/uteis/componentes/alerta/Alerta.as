package uteis.componentes.alerta
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.controls.Alert;
	
	public class Alerta extends Alert
	{
		private static var ICON_ERROR:String = "Error";
		private static var ICON_INFO:String = "Info";
		private static var ICON_CONFIRM:String = "Confirm";
		private static var ICON_WARNING:String = "Warning";
		private static var ICON_EXCLUSAO:String = "Exclusao";
		
		[Embed(source="alert/alert_error.gif")]
		private static var iconError:Class;
		
		[Embed(source="alert/alert_info.gif")]
		private static var iconInfo:Class;
		
		[Embed(source="alert/alert_confirm.gif")]
		private static var iconConfirm:Class;
		
		[Embed(source="alert/alert_warning.gif")]
		private static var iconWarning:Class;
		
		[Embed(source="alert/alert_exclusao.gif")]
		private static var iconExclusao:Class;
		
		private static var alert: Alert;

		public static function info(message:String, title:String = "Informação", closeHandler:Function=null):void{
			show(message, title, Alert.OK, null, closeHandler, iconInfo);
		}
		
		public static function error(message:String, title:String = "Erro", closeHandler:Function=null):void{
			show(message, title, Alert.OK, null, closeHandler, iconError);
		}
		
		public static function warning(message:String, title:String = "Atenção", warningHandler:Function=null):void{
			show(message, title, Alert.OK, null, warningHandler, iconWarning);
		}
		
		public static function confirm(message:String, closeHandler:Function, title:String = "Confimação", 
										yesLabel:String = "Sim", naoLabel:String = "Não", constanteIcone:String = null):void{
			
			Alert.yesLabel = yesLabel;
			
			Alert.noLabel = naoLabel;
			
			var tmpIcone:Class = iconExclusao;
			if(constanteIcone == ICON_CONFIRM){
				tmpIcone = iconConfirm;
			}else if(constanteIcone == ICON_ERROR){
				tmpIcone = iconError;
			}else if(constanteIcone == ICON_INFO){
				tmpIcone = iconInfo;
			}else if(constanteIcone == ICON_WARNING){
				tmpIcone = iconWarning;
			}
			
			alert = show(message, title, Alert.YES | Alert.NO, null, closeHandler, tmpIcone);
			alert.addEventListener(KeyboardEvent.KEY_DOWN, keyFocusChangeHandler, false, 0, true);
		}
		
		public static function keyFocusChangeHandler(event:KeyboardEvent):void
	    {
	        if (event.keyCode == Keyboard.RIGHT || event.keyCode == Keyboard.LEFT)
	    	{
	    		alert.focusManager.moveFocus(Alert.noLabel);
	    	}
	    	
	        else if (event.keyCode == 83)
	        {
	        	alert.defaultButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
	        }
	         
	        else if (event.keyCode == 78)
	        { 
	        	if(alert.getFocus() == alert.defaultButton)
	        	{
		        	alert.focusManager.moveFocus(Alert.noLabel);
	        	}
	        	alert.getFocus().dispatchEvent(new MouseEvent(MouseEvent.CLICK));
	        }
    	}
	}
}
