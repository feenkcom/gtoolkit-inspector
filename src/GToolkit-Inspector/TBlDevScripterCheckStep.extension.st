Extension { #name : #TBlDevScripterCheckStep }

{ #category : #'*GToolkit-Inspector' }
TBlDevScripterCheckStep >> gtScripterAssertsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Available asserts';
		priority: 2.1;
		items: [
			((GtPhlowCollector new
				fromObject: self;
				pragmaName: #scripterAssert;
				collectPragmas)
					collect: [ :eachPragma | eachPragma method ])
					copyWithoutDuplicates
					sorted: GtMethodsSortFunction new ];
		column: 'Method' text: [ :eachMethod | eachMethod selector printString asRopedText glamorousCodeFont ];
		column: 'Description' text: [ :eachMethod | eachMethod firstComment ifEmpty: [ '' ] ] weight: 2
]
