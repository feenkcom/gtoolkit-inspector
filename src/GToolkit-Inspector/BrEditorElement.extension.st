Extension { #name : #BrEditorElement }

{ #category : #'*GToolkit-Inspector' }
BrEditorElement >> gtEditorElementsFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Elements';
		priority: 1;
		painting: [ :mondrian | self paintEditorElementsWith: mondrian ]
]

{ #category : #'*GToolkit-Inspector' }
BrEditorElement >> gtTextTreeFor: aView [
	<gtView>
	^ (self editor gtTextTreeFor: aView) priority: 3 
]

{ #category : #'*GToolkit-Inspector' }
BrEditorElement >> paintEditorElementsWith: mondrian [
	self forceLayout.
	mondrian nodes
		shape: [ :each | 
			| form content container label labelText |
			container := BlElement new 
				look: BrShadowLook new;
				background: Color white;
				constraintsDo: [:c | 
					c vertical fitContent. 
					c horizontal fitContent.
					c padding: (BlInsets top: 5 bottom: 5)];
				layout: (BlGridLayout vertical cellSpacing: 10).
			container when: BlClickEvent do: [ :event | container fireEvent: (GtPhlowObjectToSelect new object: container; sourceElement: container) ].
			labelText := (((each class name withoutPrefix: 'Br') withoutPrefix: 'Bl') withoutSuffix: 'Element').
			labelText ifEmpty: [ labelText := 'Element' ].
			labelText := labelText asRopedText.
			labelText fontSize: 9.
			labelText foreground: Color lightGray.
			label := BlTextElement new text: labelText. 
			label 
				constraintsDo: [ :c | c grid horizontal alignCenter ].
			container addChild: label.
			form := each asSpartaForm.
			content := BlElement new
				size: form extent;
				background: form;
				constraintsDo: [ :c | c grid horizontal alignCenter ].
			container addChild: content.
			container ];
		with: self withAllChildrenBreadthFirst.
	mondrian edges 
		fromCenterBottom;
		toCenterTop;
		shape: [ :each | BlLineElement new zIndex: -1; border: (BlBorder paint: (Color gray alpha: 0.3) width: 5) ];
		connectFrom: #parent.
	mondrian layout tree nodeDistance: 10; levelDistance: 40.
]
