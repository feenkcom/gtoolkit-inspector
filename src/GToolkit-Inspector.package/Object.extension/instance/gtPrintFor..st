*GToolkit-Inspector
gtPrintFor: aView
	<gtView: 100>
	^ aView explicit
		title: 'Print';
		stencil: [ BlTextElement new text: self printString asRopedText ]