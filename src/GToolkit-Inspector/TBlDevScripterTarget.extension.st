Extension { #name : #TBlDevScripterTarget }

{ #category : #'*GToolkit-Inspector' }
TBlDevScripterTarget >> gtScripterStepTargetsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Available targets';
		priority: 40;
		items: [
			((GtPhlowCollector new
				fromObject: self;
				pragmaName: #scripterStepTarget;
				collectPragmas)
					collect: [ :eachPragma | eachPragma method ])
					copyWithoutDuplicates
					sorted: GtMethodsSortFunction new ];
		column: 'Method' text: [ :eachMethod | eachMethod selector asRopedText glamorousCodeFont ];
		column: 'Description' text: [ :eachMethod | eachMethod firstComment ifEmpty: [ '' ] ]
]
