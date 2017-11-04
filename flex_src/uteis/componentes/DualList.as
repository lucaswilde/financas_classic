package uteis.componentes
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Box;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Label;
	import mx.controls.LinkButton;
	import mx.controls.List;
	import mx.controls.TextInput;
	import mx.core.IFactory;
	import mx.events.DragEvent;
	import mx.events.ValidationResultEvent;
	import mx.validators.NumberValidator;

	[Event(name="sourceFilterChange", type="flash.events.Event")]
	[Event(name="targetFilterChange", type="flash.events.Event")]
//	public class MVDualList extends HBox implements IMVConfigurableStateComponent
	public class DualList extends HBox
	{
		// Botões de controle
		[Bindable]
        [Embed( source="../imagens/adicionar_item_conf.png")]
		private var iconeAdicionarItem:Class;	

		[Bindable]
        [Embed( source="../imagens/remover_item_conf.png")]
		private var iconeRemoverItem:Class;	

		[Bindable]
        [Embed( source="../imagens/adicionar_todos_conf.png")]
		private var iconeAdicionarTodos:Class;	

		[Bindable]
        [Embed( source="../imagens/remover_todos_conf.png")]
		private var iconeRemoverTodos:Class;	
		
		// Listas 
		[Bindable]
		private var sourceList:List = new List();
		[Bindable]
		private var targetList:List = new List();
		
		// Container para os filtros
		private var sourceFilterBox:HBox;
		private var targetFilterBox:HBox;
		
		// Containers para os Lists
		private var sourceListBox:VBox;
		private var targetListBox:VBox;
		
		// Estado do componente
		private var _state:String;
        private var _forceState:Boolean = false;

		// Container para os botões de comando
		private var controlsBox:VBox;
		
		// Inputs para filtrar o conteúdo das listas
		private var sourceInputFilter:TextInput;
		private var targetInputFilter:TextInput;
		
		// Labels dos inputs de filtro
		private var _sourceFilterLabel:Label;
		private var _targetFilterLabel:Label;

		// Variáveis auxiliares para o validator.		
		private var targetValidator:NumberValidator;
		private var stringTargetErrorValidator:String;
		private var targetValidatorRequired:Boolean = true; // default true. Variável de auxílio para momentos do código onde não se 
		// deseja validação, setar validatorTargetAdd como 'false' fora da declaração do dualList pode acarretar em erros. 
		
//		private var messageResource:MVMessageResource = MVMessageResource.getInstancia();
		
		// função que recebe o item adicionado a lista source.
		private var _dropSourceItemFunction:Function;
		// função que recebe o item adicionado a lista target
		private var _dropTargetItemFunction:Function;
		
		/* Ao se acionar o valdator por 'validatorTargetAdd="true"' tem que ser especificado também a mensagem que deve ser apresentada,
		pelo método 'set requiredTargetFieldError' a validação é chamada pelo método abaixo 'validateTarget()' que retorna um 
		ValidationResultEvent para se caso queira ser testado o resultado da validação pela aplicação. Foi implementada validação apenas em
		targetList(Lista da direita). Arthur Rocha (MV - PF) 03/06/09 */
		/** Validators, verifica se o dataProvider de targetList é maior que 0 **/
		public function validateTarget():ValidationResultEvent
		{
			if(targetValidator != null && targetList.dataProvider != null){
				if(targetValidatorRequired){
					targetValidator.required = true;
					targetList.id = (targetList.dataProvider.length).toString();
					var vResult:ValidationResultEvent;
					targetValidator.lowerThanMinError = stringTargetErrorValidator;
					vResult = targetValidator.validate();
					targetValidator.lowerThanMinError = (vResult.type == ValidationResultEvent.INVALID)?stringTargetErrorValidator:"";
					return vResult; 
				}else{
					targetValidator.required = false;
					targetValidator.lowerThanMinError = "";
					targetValidator.source.errorString = "";
					targetValidator.validate();
				}
			}
			return null;
		}
		
		private function validateTargetListener(event:Event):void
		{
			if(targetList.dataProvider != null)
				if(targetList.dataProvider.length > 0)
					validateTarget();
		}
		
		/** Getters e Setters do componente **/
		
		public function set validatorTargetAdd(value:Boolean):void
		{
			if(value){
				try{
					if(targetList.dataProvider != null)
						targetList.id = (targetList.dataProvider.lenght).toString();
				}catch(e:Error){
					targetList.id = "0";
				}
				targetValidator = new NumberValidator();
				targetValidator.source = targetList;
				targetValidator.property = "id";
				targetValidator.minValue = 1;
				targetValidator.invalidFormatCharsError = "";
				targetValidator.requiredFieldError = "";
				targetValidator.lowerThanMinError = "";// mensagem atribuída pelo set
				// Listener para o validator de targetList
				sourceList.addEventListener(DragEvent.DRAG_COMPLETE, validateTargetListener, false, 0, true);
			}
		}
		
		public function set targetValidatorIsRequired(value:Boolean):void
		{
			targetValidatorRequired = value;
			if(!value){
				validateTarget();
			}
		}
		
		public function set requiredTargetFieldError(value:String):void
		{
			stringTargetErrorValidator = value;
		}
		
		public function set maxCharsSourceFilter(value:String):void
		{
			sourceInputFilter.maxChars = parseInt(value); 
		}
		
		public function set maxCharsTargetFilter(value:String):void
		{
			targetInputFilter.maxChars = parseInt(value);
		}
		
		public function get sourceFilterLabel():String
		{
			return this._sourceFilterLabel.text;
		} 
		
		public function set sourceFilterLabel(value:String):void
		{
			this._sourceFilterLabel.text = value;
		} 
		
		public function get targetFilterLabel():String
		{
			return this._targetFilterLabel.text;
		} 
		
		public function set targetFilterLabel(value:String):void
		{
			this._targetFilterLabel.text = value;
		} 

		public function get sourceDataProvider():Object
		{
			return this.sourceList.dataProvider;
		}
		
		public function set sourceDataProvider(value:Object):void
		{
			this.sourceList.dataProvider = value;
		}

		public function get targetDataProvider():Object
		{
			return this.targetList.dataProvider;
		}
		
		public function set targetDataProvider(value:Object):void
		{
			this.targetList.dataProvider = value;
		}

		public function get sourceLabelField():String
		{
			return this.sourceList.labelField;
		}
		
		public function set sourceLabelField(value:String):void
		{
			this.sourceList.labelField = value;
		}

		public function get targetLabelField():String
		{
			return this.targetList.labelField;
		}
		
		public function set targetLabelField(value:String):void
		{
			this.targetList.labelField = value;
		}

		public function get sourceLabelFunction():Function
		{
			return this.sourceList.labelFunction;
		}

		public function set sourceLabelFunction(value:Function):void
		{
			this.sourceList.labelFunction = value;
		}

		public function get targetLabelFunction():Function
		{
			return this.targetList.labelFunction;
		}

		public function set targetLabelFunction(value:Function):void
		{
			this.targetList.labelFunction = value;
		}
		
		public function get sourceItemRenderer():IFactory
		{
			return this.sourceList.itemRenderer;
		}

		public function get sourceFilterText():String
		{
			return sourceInputFilter.text;
		}
		
		public function set sourceFilterText(value:String):void
		{
			sourceInputFilter.text = value;
		}

		public function get targetFilterText():String
		{
			return targetInputFilter.text;
		}
		
		public function set targetFilterText(value:String):void
		{
			targetInputFilter.text = value;
		}
		
		[Bindable]
		[Inspectable(type="IFactory")]
		public function set sourceItemRenderer(value:IFactory):void
		{
			this.sourceList.itemRenderer = value;
		}

		public function get targetItemRenderer():IFactory
		{
			return this.targetList.itemRenderer;
		}

		[Bindable]
		[Inspectable(type="IFactory")]
		public function set targetItemRenderer(value:IFactory):void
		{
			this.targetList.itemRenderer = value;
		}
		
		[Inspectable(type="Boolean", defaultValue="false", enumeration="true,false")]
		public function set truncateToFit(value:Boolean):void
		{
			if(value){
				targetItemRenderer = new LabelTruncateRenderer().newInstance();
				sourceItemRenderer = new LabelTruncateRenderer().newInstance();
			}
		}
		
		public function set dropSourceItemFunction(value:Function):void
		{
			_dropSourceItemFunction = value;
		}
		
		public function get dropSourceItemFunction():Function
		{
			return _dropSourceItemFunction;
		}
		
		public function set dropTargetItemFunction(value:Function):void
        {
            _dropTargetItemFunction = value;
        }
        
        public function get dropTargetItemFunction():Function
        {
            return _dropTargetItemFunction;
        }

		/** Funções auxiliares (privadas) **/
		
		private function addItem(event:Event):void
		{
			moveItem(sourceList, targetList, true);
			if(targetValidator != null)
				validateTarget();
		}

		private function addAllItems(event:Event):void
		{
			moveAllItems(sourceList, targetList, true);
			if(targetValidator != null)
				validateTarget();
		}

		private function removeItem(event:Event):void
		{
			moveItem(targetList, sourceList);
		}

		private function removeAllItems(event:Event):void
		{
			moveAllItems(targetList, sourceList);
		}
		
		// Move o(s) item(s) selecionado(s) de uma lista à outra
		private function moveItem(sourceList:List, targetList:List, addTarget:Boolean = false):void
		{
			var selectedItens:ArrayCollection = new ArrayCollection(sourceList.selectedItems);
			for each(var item:Object in selectedItens)
			{
				var indiceToRemove:int = ArrayCollection(sourceList.dataProvider).getItemIndex(item);
					
				ArrayCollection(targetList.dataProvider).addItem(item);
				ArrayCollection(sourceList.dataProvider).removeItemAt(indiceToRemove);
				if(_dropTargetItemFunction && addTarget) {
					_dropTargetItemFunction.call(null, item);
				}else if(_dropSourceItemFunction && !addTarget) {
					_dropSourceItemFunction.call(null, item);
				}
			}
			
			ArrayCollection(sourceList.dataProvider).refresh();
			ArrayCollection(targetList.dataProvider).refresh();
		}
		
		// Move todos os itens de uma lista à outra
		private function moveAllItems(sourceList:List, targetList:List, addTarget:Boolean = false):void
		{			
			for each(var item:Object in ArrayCollection(sourceList.dataProvider))
			{
				ArrayCollection(targetList.dataProvider).addItem(item);
				if(_dropTargetItemFunction && addTarget) {
                    _dropTargetItemFunction.call(null, item);
                }else if(_dropSourceItemFunction && !addTarget) {
                    _dropSourceItemFunction.call(null, item);
                }
			}
			
			ArrayCollection(sourceList.dataProvider).removeAll();
			
			ArrayCollection(sourceList.dataProvider).refresh();
			ArrayCollection(targetList.dataProvider).refresh();
		}
		
		private function dispatchSourceFilterChange(event:Event):void
		{
			sourceInputFilter.text = sourceInputFilter.text.toUpperCase();
			dispatchEvent(new Event("sourceFilterChange"));
		}
		
		private function dispatchTargetFilterChange(event:Event):void
		{
			targetInputFilter.text = targetInputFilter.text.toUpperCase();
			dispatchEvent(new Event("targetFilterChange"));
		}
		
		//Artifício para desabilitar a cópia de itens nas listas, através da tecla CTRL.
		public function set cancelCtrlKeyCopy(value:Boolean):void
		{
			if(value)
			{
				sourceList.addEventListener(KeyboardEvent.KEY_DOWN, keyDownDgHandler,false, 10);
				sourceList.addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler,false, 10);
				sourceList.addEventListener(DragEvent.DRAG_OVER, dragOverHandler, false,10);
			
				targetList.addEventListener(KeyboardEvent.KEY_DOWN, keyDownDgHandler,false, 10);
				targetList.addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler,false, 10);
				targetList.addEventListener(DragEvent.DRAG_OVER, dragOverHandler, false,10);
			}
			
			else
			{
				sourceList.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownDgHandler);
				sourceList.removeEventListener(DragEvent.DRAG_ENTER, dragEnterHandler);
				sourceList.removeEventListener(DragEvent.DRAG_OVER, dragOverHandler);
			
				targetList.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownDgHandler);
				targetList.removeEventListener(DragEvent.DRAG_ENTER, dragEnterHandler);
				targetList.removeEventListener(DragEvent.DRAG_OVER, dragOverHandler);
			}
		}
		private function keyDownDgHandler(event:KeyboardEvent):void
		{
	        cancelCtrlKey(event);
		}
		private function dragOverHandler(event:DragEvent):void
		{
	        cancelCtrlKey(event);
		}
		private function dragEnterHandler(event:DragEvent):void
		{
	        cancelCtrlKey(event);
		}
		private function cancelCtrlKey(event:Object):void
		{
	        event.ctrlKey = false;
		} 
		
		/* Correção: Comentado Spacer e adicionado box para o Label. Com a implementação anterior caso o usuário inserir-se um conteúdo 
		no textInput maior que seu width, este redimensionava-se para adaptar-se ao tamanho do texto. Arthur Rocha (MV - PF) 03/06/09*/
		// Inputs para filtrar o conteúdo das listas
		private function initializeFilters():void
		{
			sourceFilterBox = new HBox()
			sourceFilterBox.percentWidth = 100;
			
			_sourceFilterLabel = new Label();
			
			var boxSourceLabel:Box = new Box();
			boxSourceLabel.percentWidth = 50;
			boxSourceLabel.addChild(_sourceFilterLabel);
			/*  var sourceSpacer:Spacer = new Spacer();
			sourceSpacer.percentWidth = 100;  */
			
			sourceInputFilter = new TextInput();
			sourceInputFilter.addEventListener(Event.CHANGE, dispatchSourceFilterChange, false, 0, true);
			sourceInputFilter.percentWidth = 50;
			
			sourceFilterBox.addChild(boxSourceLabel);
			/* sourceFilterBox.addChild(sourceSpacer); */
			sourceFilterBox.addChild(sourceInputFilter);
			
			targetFilterBox = new HBox()
			targetFilterBox.percentWidth = 100;
			
			_targetFilterLabel = new Label();
			
			var boxTargetLabel:Box = new Box();
			boxTargetLabel.percentWidth = 50;
			boxTargetLabel.addChild(_targetFilterLabel);
			/* var targetSpacer:Spacer = new Spacer();
			targetSpacer.percentWidth = 100; */
			
			targetInputFilter = new TextInput();
			targetInputFilter.addEventListener(Event.CHANGE, dispatchTargetFilterChange, false, 0, true);
			targetInputFilter.percentWidth = 50;
			
			targetFilterBox.addChild(boxTargetLabel);
			/* targetFilterBox.addChild(targetSpacer); */
			targetFilterBox.addChild(targetInputFilter);
		}
			
		// A lista da esquerda
		private function initializeSourceList():void
		{
			sourceListBox = new VBox();
			sourceListBox.percentWidth = 50;
			sourceListBox.percentHeight = 100;
			
			sourceList = new List();
			sourceList.percentWidth = 100
			sourceList.percentHeight = 100;
			sourceList.allowMultipleSelection=true;
			sourceList.dragEnabled=false;
			sourceList.dropEnabled=false;
			sourceList.dragMoveEnabled=false;

			sourceListBox.addChild(sourceFilterBox);
			sourceListBox.addChild(sourceList);
		}

		// A lista da direita
		private function initializeTargetList():void
		{
			targetListBox = new VBox();
			targetListBox.percentWidth = 50;
			targetListBox.percentHeight = 100;
			
			targetList = new List();
			targetList.percentWidth = 100
			targetList.percentHeight = 100;
			targetList.allowMultipleSelection=true;
			targetList.dragEnabled=false;
			targetList.dropEnabled=false;
			targetList.dragMoveEnabled=false;	
			
			targetListBox.addChild(targetFilterBox);
			targetListBox.addChild(targetList);
		}

		// Botões de comando
		private function initializeControls():void
		{
			controlsBox = new VBox;

			var addItemImage:LinkButton = new LinkButton();
			addItemImage.setStyle("icon", iconeAdicionarItem);
			addItemImage.width = 20;
			addItemImage.height = 20;
			addItemImage.setStyle("cornerRadius", 10);
			addItemImage.buttonMode = true;
//			addItemImage.toolTip = messageResource.getTexto('tela.cadastro.itens.afericao.adicionar');
			addItemImage.addEventListener(MouseEvent.CLICK, addItem, false, 0, true);			
//			addItemImage.toolTip = messageResource.getTexto('tela.cadastro.itens.afericao.adicionar');
			
			var addAllItemsImage:LinkButton = new LinkButton();
			addAllItemsImage.setStyle("icon", iconeAdicionarTodos);
			addAllItemsImage.width = 20;
			addAllItemsImage.height = 20;
			addAllItemsImage.setStyle("cornerRadius", 10);
			addAllItemsImage.buttonMode = true; 	
//			addAllItemsImage.toolTip = messageResource.getTexto('tela.cadastro.itens.afericao.adicionar.todos');
			addAllItemsImage.addEventListener(MouseEvent.CLICK, addAllItems, false, 0, true);
//			addAllItemsImage.toolTip = messageResource.getTexto('tela.cadastro.itens.afericao.adicionar.todos');			

			var removeItemImage:LinkButton = new LinkButton();
			removeItemImage.setStyle("icon", iconeRemoverItem);
			removeItemImage.width = 20;
			removeItemImage.height = 20;
			removeItemImage.setStyle("cornerRadius", 10);
			removeItemImage.buttonMode = true; 		
//			removeItemImage.toolTip = messageResource.getTexto('tela.cadastro.itens.afericao.remover');	
			removeItemImage.addEventListener(MouseEvent.CLICK, removeItem, false, 0, true);
//			removeItemImage.toolTip = messageResource.getTexto('tela.cadastro.itens.afericao.remover');

			var removeAllItemsImage:LinkButton = new LinkButton();
			removeAllItemsImage.setStyle("icon", iconeRemoverTodos);
			removeAllItemsImage.width = 20;
			removeAllItemsImage.height = 20;
			removeAllItemsImage.setStyle("cornerRadius", 10);
			removeAllItemsImage.buttonMode = true;
//			removeAllItemsImage.toolTip = messageResource.getTexto('tela.cadastro.itens.afericao.remover.todos');
			removeAllItemsImage.addEventListener(MouseEvent.CLICK, removeAllItems, false, 0, true);
//			removeAllItemsImage.toolTip = messageResource.getTexto('tela.cadastro.itens.afericao.remover.todos');			
			
			controlsBox.addChild(addItemImage);
			controlsBox.addChild(addAllItemsImage);
			controlsBox.addChild(removeItemImage);
			controlsBox.addChild(removeAllItemsImage); 			
			
		}

		public function DualList()
		{
			super();
			
			
			/** Filtros **/
			initializeFilters();

			/**Source List**/
			initializeSourceList();
			
			
			/**Botões de comando**/
			initializeControls()


			/**Target List**/
			initializeTargetList();
			
			/** Montando o layout **/
			this.addChild(sourceListBox);
			this.addChild(controlsBox);		
			this.addChild(targetListBox);
			
			/** Cancela evento Ctrl de cópia de itens na lista **/
			cancelCtrlKeyCopy = true; 
		}
		
		public function set state(value:String):void
		{
			_state = value;
			this._forceState = true;
			configureState(_state);
		}

		public function get state():String
		{
			return _state;
		}
		
		/**
		 * This method configure the component state according with ancestor container.
		 * 
		 * @author: Arthemas Nobrega, Walberg Caribe.
		 * 
		 * @creation_date: 14/01/2009
		 */
		public function configureState(state:String):void
		{
			this._state = state;
			
			if(state == StateConstants.EDIT || state == StateConstants.FILTER) {			    
//				this.enabled = true;
				sourceListBox.enabled = true;
				controlsBox.enabled = true;
			} else if (state == StateConstants.READ_ONLY || state == StateConstants.DELETE) {
//				this.enabled = false;
                sourceListBox.enabled = false;
				controlsBox.enabled = false;
			}
		}
		
		/**
		 * This method verify if the component has a configured state.
		 * 
		 * @author: Arthemas Nobrega, Walberg Caribe.
		 * 
		 * @creation_date: 14/01/2009
		 */
		public function hasForceState():Boolean
		{
			return _forceState;
		}
	}
}

