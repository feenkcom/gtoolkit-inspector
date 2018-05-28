*GToolkit-Inspector
gtPrintFor: aModel
	<gtView: 100>
	^ aModel 
		title: 'Print';
		stencil: [ BlTextElement new text: self printString asRopedText ]