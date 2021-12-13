Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*GToolkit-Inspector' }
TBlDevScripterActionStep >> gtScripterActionStepsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Available actions';
		priority: 2.1;
		items: [
			((GtPhlowCollector new
				fromObject: self;
				pragmaName: #scripterActionStep;
				collectPragmas)
					collect: [ :eachPragma | eachPragma method ])
					copyWithoutDuplicates
					sorted: GtMethodsSortFunction new ];
		column: 'Method' text: [ :eachMethod | eachMethod selector printString asRopedText glamorousCodeFont ];
		column: 'Description' text: [ :eachMethod | eachMethod firstComment ifEmpty: [ '' ] ];
		column: 'Add it' stencil: [ :eachMethod |
			BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons play;
				label: 'Add ', eachMethod selector printString;
				beTinySize;
				action: [ :aButton | aButton phlow spawnObject: (self perform: eachMethod selector) referenceNothing ] ]
			width: 50
]
