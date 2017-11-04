package uteis.componentes
{
	import mx.validators.DateValidator;
	
	public class DateValidatorPersonalizado extends DateValidator
	{
		public function DateValidatorPersonalizado()
		{
			this.requiredFieldError = "Preenchimento obrigatório.";
			this.formatError = "O formato da data deve ser Dia/Mês/Ano";
		    this.inputFormat = "DD/MM/YYYY"; 
		    this.invalidCharError = "A data contém caracteres inválidos.";
		    this.wrongDayError = "Digite um dia válido para o mês.";
		    this.wrongMonthError = "Digite um mês entre 1 e 12.";
		    this.wrongYearError = "Digite um ano entre 0 e 9999.";
		    this.wrongLengthError = "O formato da data deve ser";
		}

	}
}