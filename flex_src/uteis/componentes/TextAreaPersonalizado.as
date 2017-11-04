package uteis.componentes
{
	import flash.events.Event;
	
	import mx.controls.TextArea;

	public class TextAreaPersonalizado extends TextArea
	{
				
		public function TextAreaPersonalizado()
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