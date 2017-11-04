package uteis.componentes
{
	import flash.events.Event;
	
	import mx.controls.TextInput;

	public class TextInputPersonalizado extends TextInput
	{
				
		public function TextInputPersonalizado()
		{
			super();
			this.addEventListener(Event.CHANGE, texto);
		}
		
		public function texto(ev:Event):void
		{
			this.text = this.text.toUpperCase(); 
		}
	}
}