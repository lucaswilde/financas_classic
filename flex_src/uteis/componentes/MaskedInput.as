package uteis.componentes {
   import mx.controls.TextInput;
   import flash.events.TextEvent;
   import flash.events.MouseEvent;
   import flash.events.KeyboardEvent;
   import flash.events.FocusEvent;
   import flash.events.Event;
   import flash.ui.Keyboard;

   [Event(name="inputMaskEnd")]
   
	[Bindable]
   public class MaskedInput extends TextInput
   {
      public function MaskedInput()
      {
         super();
         
         addEventListener(TextEvent.TEXT_INPUT,interceptChar,true,0);
         addEventListener(MouseEvent.CLICK,reposition,true);
         addEventListener(KeyboardEvent.KEY_DOWN,interceptKey,true);
         addEventListener(FocusEvent.FOCUS_IN,interceptFocus,false);
      }
      
      /*
       * private vars
       */
      private var _working:Array = [];
      private var _position:Number = 0;
      private var bWorkingUpdated:Boolean = false;
      private var bMaskUpdated:Boolean = false;
      private var bTextUpdated:Boolean = false;
      
      /**
       * blankChar
       */
      private var _blankChar:String = " ";
      public function get blankChar() : String
      {
         return _blankChar;
      }
      public function set blankChar( s:String ) : void
      {
         if( s.length == 0 ) return;
         _blankChar = s.charAt(0);
         invalidateDisplayList();
      }
      
      /**
       * defaultChar
       */
      private var _defaultChar:String = " ";
      public function set defaultChar( s:String ) : void
      {
         _defaultChar = s;
      }
      public function get defaultChar() : String
      {
         return _defaultChar;
      }
      
      /**
       * inputMask
       */
      private var _inputMask:String;
      public function get inputMask() : String
      {
         return _inputMask;
      }
      public function set inputMask(s:String) : void
      {
         _inputMask = s;
         bMaskUpdated = true;
         invalidateDisplayList();
      }
      
      /**
       * text
       */
      private var _text:String = "";
      override public function get text():String
      {
         var result:String = "";
         for(var i:Number=0; i < _working.length; i++) {
            var c:String = _working[i];
            if( _inputMask.charAt(i) == c ) continue;
            if( c == _blankChar ) c = " ";
            result += c;
         }
         return result;
      }
      
      override public function set text(value:String):void
      {
         _text = value;
         bTextUpdated = true;
         invalidateDisplayList();
      }
      
      /**
       * actualText (read only)
       */
      public function get actualText() : String
      {
         var result:String = "";
         for(var i:Number=0; i < _working.length; i++) {
            var c:String = _working[i];
            if( c == _blankChar ) c = _defaultChar;
            result += c;
         }
         return result;
      }
      
      /*
       * event handlers
       */
      
      /**
       * reposition
       *
       * Handles MOUSE_CLICK event; repositions the insertion point
       */
      private function reposition( event:flash.events.MouseEvent ) : void
      {
         var p:Number = this.selectionBeginIndex;
         _position = p;
      }
      
      /**
       * interceptKey
       *
       * Looks for special keys and modifies the insertion point
       */
      private function interceptKey( event:flash.events.KeyboardEvent ) : void
      {
         if( event.keyCode == Keyboard.BACKSPACE ) {
            _position = selectionBeginIndex;
            retreatPosition();
            allowChar(_blankChar);
         }
         else if( event.keyCode == Keyboard.SPACE ) {
            allowChar(_defaultChar);
            advancePosition();
         }
         else if( event.keyCode == Keyboard.DELETE ) {
            if( _position < _inputMask.length ) {
               allowChar(_blankChar);
               advancePosition(true);
            }
         }
         else if( event.keyCode == Keyboard.LEFT ) {
            _position = this.selectionBeginIndex;
            retreatPosition();
            event.preventDefault();
         }
         else if( event.keyCode == Keyboard.RIGHT ) {
            advancePosition(true);
            event.preventDefault();
         }
         else if( event.keyCode == Keyboard.END ) {
            _position = _working.length;
            event.preventDefault();
         }
         else if( event.keyCode == Keyboard.HOME ) {
            _position = -1;
            advancePosition(true);
         }
         bWorkingUpdated = true;
         invalidateDisplayList();
      }
      
      /**
       * interceptFocus
       *
       * Consumes the FOCUS_IN event and repositions the insertion
       * point.
       */
      private function interceptFocus( event:FocusEvent ) : void
      {
         var start:Number = selectionBeginIndex;
         if( event.relatedObject != null ) start = 0;
         setSelection( start, start );
         _position = start - 1;
         
         // advance the insertion point to the first viable input field.
         advancePosition();
      }
      
      /**
       * interceptChar
       *
       * Handle TEXT_INPUT events by matching the character with
       * the mask and either blocking or allowing the character.
       */
      private function interceptChar( event:TextEvent ) : void
      {
         var input:String = event.text;
         
         if( _inputMask.length <= _position ) {
            event.preventDefault();
            dispatchEvent(new Event("inputMaskEnd"));
            return;
         }
         
         var c:String = input.charAt(0);
         var m:String = _inputMask.charAt(_position);
         var bAdvance:Boolean = true;
         
         switch(m)
         {
            case "#":
               if( isDigit(c) ) {
                  allowChar(c);
               } else {
                  event.preventDefault();
                  bAdvance = false;
               }
               break;
            case "C":
               if( isDigit(c) ) {
                  event.preventDefault();
                  bAdvance = false;
               } else {
                  allowChar(c.toUpperCase());
               }
               break;
            case "c":
               if( isDigit(c) ) {
                  event.preventDefault();
                  bAdvance = false;
               } else {
                  allowChar(c.toLowerCase());
               }
               break;
            case "A","a":
               allowChar( c.toLowerCase() );
               break;
            default:
               break;
         }
         
         if( bAdvance ) {
            advancePosition();
         }
         bWorkingUpdated = true;
         invalidateDisplayList();
      }
      
      /**
       * advancePosition
       *
       * Moves the insertion point forward (if possible) to the next viable
       * input position.
       */
      protected function advancePosition(byArrow:Boolean=false) : void
      {
         var p:Number = _position;
         while( (++p) < _inputMask.length && !isMask(_inputMask.charAt(p)) ) ;
         _position = p;
         if( p >= _inputMask.length && !byArrow ) {
            dispatchEvent(new Event("inputMaskEnd"));
         }
         setSelection(_position,_position);
      }
      
      /**
       * retreatPosition
       *
       * Moves the insertion point backward (if possible) to the previous
       * viable input position.
       */
      protected function retreatPosition() : void
      {
         var p:Number = _position;
         while( (--p) > 0 && !isMask(_inputMask.charAt(p)) ) ;
         _position = p;
         setSelection(_position,_position);
      }
      
      /**
       * isMask
       *
       * Returns true if the given character is a masking character.
       */
      protected function isMask( c:String ) : Boolean
      {
         return c == "#" || c == "A" || c == "C" || c == "c";
      }
      
      /**
       * isDigit
       *
       * Returns true if the given character is a digit.
       */
      protected function isDigit( c:String ) : Boolean
      {
         return c == "0" || c == "1" || c == "2" || c == "3" ||
                c == "4" || c == "5" || c == "6" || c == "7" ||
                c == "8" || c == "9";
      }
      
      /**
       * allowChar
       *
       * Inserts the character into the working array.
       */
      private function allowChar( c:String ) : void
      {
         _working[_position] = c;
      }
      
      /**
       * updateDisplayList
       *
       * Modifies the display according to how flags are set: if
       * text has been updated, fold the text according to the mask. If
       * the mask has been updated, modify the display.
       */
      override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
      {
         if( bMaskUpdated ) {
            bMaskUpdated = false;
            
            _working = [];
            var s:String = _inputMask;
            for(var i:int=0; i < s.length; i++) {
               var c:String = s.charAt(i);
               if( isMask(c) ) {
                  c = _blankChar;
               }
               _working.push(c);
            }
            bWorkingUpdated = true;
         }
         
         if( bTextUpdated ) {
            bTextUpdated = false;
            
            var t:Number = 0;
            var value:String = _text;
            
            for(var j:Number=0; j < _inputMask.length; j++) {
               var m:String = _inputMask.charAt(j);
               if( isMask(m) ) {
                  if(value != null){
	                  if( t >= value.length ) _working[j] = _blankChar;
	                  else _working[j] = value.charAt(t);
	                  t += 1;
                  }
               } else {
                  _working[j] = m;
               }
            }
            bWorkingUpdated = true;
         }
         
         if( bWorkingUpdated ) {
            super.text = _working.join("");
            bWorkingUpdated = false;
         }
         
         super.updateDisplayList( unscaledWidth, unscaledHeight );
      }
      
   }
}
	