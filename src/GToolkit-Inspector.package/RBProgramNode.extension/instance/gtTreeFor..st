*GToolkit-Inspector
gtTreeFor: aView
	<gtView: 30> 
	| visitor |
	^ aView title: 'Grad Tree';
	 		stencil: [
						visitor := GtGradASTView new.
						visitor visitNode: self withParentElement: nil.
						visitor buildTreeLayout]
	
	"^ aView mondrian
		title: 'Tree';
		painting: [ :view | 
			view nodes shape: [ :each |
				| textElement text |
				text := BlRopedText string: ((each printString) truncateTo:50).
				textElement := BlTextElement new.
				textElement text: text.
				textElement 
				];	
			with: (self withDeepCollect: #children).
			view edges shape: [ :each | 
					BlLineElement new
						border: (BlBorder paint: (Color gray alpha: 0.4) width: 3);
						toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder paint: (Color gray alpha: 0.4); width: 3; build))]; 
					connectToAll: #children.
			view layout tree ]."
		
		