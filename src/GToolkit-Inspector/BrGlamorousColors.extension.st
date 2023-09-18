Extension { #name : #BrGlamorousColors }

{ #category : #'*GToolkit-Inspector' }
BrGlamorousColors class >> gtClassVariablesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Class variables';
		priority: 0.7;
		items: [ self classVariables ];
		column: 'Icon' icon: [ :anAssoc | anAssoc value gtInspectorIcon asElement ];
		column: 'Class Variable' text: #key;
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
BrGlamorousColors class >> gtColorsFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Colors';
		priority: 0.5;
		items: [ self class selectors
				select: [ :each | each numArgs isZero and: [ each endsWith: 'Color' ] ] ];
		column: 'Icon' 
			icon: [ :aSymbol | (self perform: aSymbol) gtInspectorIcon asElement asScalableElement ]
			width: 32;
		column: 'Selector' text: [ :aSymbol | aSymbol asString ];
		send: [ :aSymbol | self perform: aSymbol ]
]
