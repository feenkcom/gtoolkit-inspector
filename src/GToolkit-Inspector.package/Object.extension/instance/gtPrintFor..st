*GToolkit-Inspector
gtPrintFor: aView
	<gtView: 100>
	^ aView explicit
		title: 'Print';
		priority: 110;
		stencil: [ BlTextElement new text: self printString asRopedText ]