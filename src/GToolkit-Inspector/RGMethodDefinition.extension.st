Extension { #name : 'RGMethodDefinition' }

{ #category : '*GToolkit-Inspector' }
RGMethodDefinition >> gtBasicSourceFor: aView [
	^ aView explicit
		title: 'Source';
		priority: 0;
		actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: 
				(GtMethodCoderTool compiledMethod: self compiledMethod) ];
		stencil: [ 
			 ((((GtPharoMethodCoder forMethod: self) 
				subscribeToSystem) asCoderUIModel expanded: true)
				asElement) ].
]

{ #category : '*GToolkit-Inspector' }
RGMethodDefinition >> gtImplementorsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Implementors';
		priority: 11;
		items: [ self compiledMethod implementors ];
		column: 'Index' 
			item: [ :aMethod :anIndex | anIndex ]
			text: [ :anIndex | 
				anIndex asString asRopedText 
					foreground: Color gray ]
			width: 50;
		column: 'Method' text: #gtDisplayString.
]

{ #category : '*GToolkit-Inspector' }
RGMethodDefinition >> gtSendersFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Senders';
		priority: 10;
		items: [ self compiledMethod senders ];
		column: 'Index' 
			item: [ :aMethod :anIndex | anIndex ]
			text: [ :anIndex | 
				anIndex asString asRopedText 
					foreground: Color gray ]
			width: 50;
		column: 'Method' text: #gtDisplayString.
]

{ #category : '*GToolkit-Inspector' }
RGMethodDefinition >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 0;
		actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: 
				(GtMethodCoderTool compiledMethod: self compiledMethod) ];
		stencil: [ 
			 ((GtPharoMethodCoder forMethod: self) 
				subscribeToSystem;
				asExpandedOnlyElement) vFitContentLimited ].
]
