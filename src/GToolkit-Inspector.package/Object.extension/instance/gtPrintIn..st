*GToolkit-Inspector
gtPrintIn: aModel
	<gtView: 10>
	^ aModel 
		title: 'Print';
		stencil: [ BlTextElement new text: self printString asRopedText ]