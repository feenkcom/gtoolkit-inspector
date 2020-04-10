Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtBasicSourceFor: aView [
	^ aView explicit
		title: 'Source';
		priority: 0;
		actionButtonIcon: BrGlamorousVectorIcons browse 
			action: [ :aButton | self browse ];
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			action: [ :aButton | 
				aButton phlow spawnObject: 
					(GtClassCoder forClass: self methodClass) ];
		stencil: [ 
			 ((GtMethodCoder forMethod: self) 
				expanded: true; 
				subscribeToSystem;
				asElement) ].
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtImplementorsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Implementors';
		priority: 11;
		stencil: [ 
			| list |
			list := BrColumnedList new display: self compiledMethod implementors.
			list addEventHandler: GtInspectorListToSelectHandler new.
			list column
				title: 'Index';
				stencil: [ :aClass :anIndex |
					BlTextElement new
						width: 30;
						margin: (BlInsets all: 3);
						text: (anIndex asString asRopedText foreground: Color gray) ].
			list column
				title: 'Method';
				stencil: [ :each :index | BrColumnCellLabelStencil new text: each gtDisplayString ].
			list ]
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtSendersFor: aView [
	<gtView>
	^ aView explicit
		title: 'Senders';
		priority: 10;
		stencil: [ 
			| list |
			list := BrColumnedList new display: self compiledMethod senders.
			list addEventHandler: GtInspectorListToSelectHandler new.
			list column
				title: 'Index';
				stencil: [ :aClass :anIndex |
					BlTextElement new
						width: 30;
						margin: (BlInsets all: 3);
						text: (anIndex asString asRopedText foreground: Color gray) ].
			list column
				title: 'Method';
				stencil: [ :each :index | BrColumnCellLabelStencil new text: each gtDisplayString ].
			list ]
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtSourceFor: aView [
	<gtView>
	^ aView forward
		title: 'Source';
		priority: 0;
		object: [ self ];
		view: #gtBasicSourceFor:;
		transformed: #asScrollableElement
]
