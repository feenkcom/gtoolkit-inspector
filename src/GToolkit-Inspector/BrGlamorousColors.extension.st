Extension { #name : #BrGlamorousColors }

{ #category : #'*GToolkit-Inspector' }
BrGlamorousColors class >> gtClassVariablesFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Class Variables';
		priority: 0.7; 
		display: [ self classVariables ];
		column: 'Icon' do: [ :aColumn | 
			aColumn 
				itemStencil: [ :anAssoc | anAssoc value gtInspectorIcon asElement ];
				width: 16 ];
		column: 'Class Variable' item: [ :anAssoc | anAssoc key asString ];
		send: [ :anAssoc | anAssoc value ]
]

{ #category : #'*GToolkit-Inspector' }
BrGlamorousColors class >> gtColorsFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Colors';
		priority: 0.5; 
		display: [ self class selectors 
			select: [ :each | each numArgs isZero and: [ each endsWith: 'Color' ] ] ];
		column: 'Icon' do: [ :aColumn | 
			aColumn 
				itemStencil: [ :aSymbol | (self perform: aSymbol) gtInspectorIcon asElement ];
				width: 16 ];
		column: 'Selector' item: [ :aSymbol | aSymbol asString ];
		send: [ :aSymbol | (self perform: aSymbol) ]
]
