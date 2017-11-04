package uteis.componentes {
	
import mx.controls.RadioButton;
import mx.controls.RadioButtonGroup;
import mx.validators.StringValidator;

/**
 * StringValidator.
 * 
 * @author Andreas Straub
 * @version 1.0
 */
public class RadioButtonGroupValidator extends StringValidator {
	
	/**
	 * Gibt an ob die RadioButtonGroup-Komponente initialisiert wurde
	 */
	private var _radioButtonGroupInitialized:Boolean = false;
	
	/**
	 * Konstruktor
	 */
	public function RadioButtonGroupValidator() {
		super();
	}
	
	/**
	 *  Override of the base class <code>doValidation()</code> method
	 *  to validate a String.
	 *
	 *  <p>You do not call this method directly;
	 *  Flex calls it as part of performing a validation.
	 *  If you create a custom Validator class, you must implement this method.</p>
	 *
	 *  @param value Object to validate.
	 *
	 *  @return An Array of ValidationResult objects, with one ValidationResult 
	 *  object for each field examined by the validator. 
	 */
	override protected function doValidation(value:Object):Array {
		
		/*
		 * Dadurch, dass die RadioButtonGroup-Komponente nicht richtig mit 
		 * RadioButtons initialisiert wird (bzw. nicht zu der richtigen Zeit),
		 * muss man disen Aufruf hier noch ein mal starten.
		 * addListenerHandler() bewirkt, dass "actualListeners"-Eigenschaft
		 * angefragt wird und die RadioButtons der RadioButtonGroup-Komponente 
		 * in die Liste der "Listener" des Validators eingefügt werden.
		 */
		if (!_radioButtonGroupInitialized && (source is RadioButtonGroup || listener is RadioButtonGroup)) {
        	removeListenerHandler();
			addListenerHandler();
		}
		
		return super.doValidation(value);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  actualListeners
	//----------------------------------
	
	/** 
	 *  @private
	 *  Returns either the listener or the source
	 *  for the day, month and year subfields.
	 */
	override protected function get actualListeners():Array {
		var results:Array = super.actualListeners;
		
		if (results == null || results.length < 1) {
			return results;
		}
		
		var sourceElem:Object = results[0];
		if (sourceElem && sourceElem is RadioButtonGroup) {
			var numRadioButtons:int = RadioButtonGroup(sourceElem).numRadioButtons;
			
			for (var i:int = 0; i < numRadioButtons; i++) {
				var rb:RadioButton = RadioButtonGroup(sourceElem).getRadioButtonAt(i);
				results.push(rb);
				rb.validationSubField = null;
			}
			
			if (numRadioButtons > 0) {
				// Wenn die RadioButtonGroup-Komponente RadioButtons enthält
				// dann ist sie initialisiert.
				_radioButtonGroupInitialized = true;
			}
		}
		
		return results;
	}
	
	
}

} // end package