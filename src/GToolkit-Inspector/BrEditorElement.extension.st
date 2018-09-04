Extension { #name : #BrEditorElement }

{ #category : #'*GToolkit-Inspector' }
BrEditorElement >> gtEditorElementsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Elements';
		priority: 1;
		stencil: [ 
			| container block |
			container := BlElement new.
			container constraintsDo: [ :c | c vertical matchParent. c horizontal matchParent ].
			block := [ 
				| mondrian |
				mondrian := GtMondrian new.
				self paintEditorElementsWith: mondrian.
				container removeChildren.
				container addChild: mondrian asPannableElement ].
			self editor when: BrTextEditorInsertedEvent do: block.
			self editor when: BrTextEditorDeletedEvent do: block.
			self editor when: BrTextEditorCursorMovedEvent do: block.
			self editor when: BrTextEditorCursorAddedEvent do: block.
			self editor when: BrTextEditorCursorRemovedEvent do: block.
			container
			]
]

{ #category : #'*GToolkit-Inspector' }
BrEditorElement >> paintEditorElementsWith: mondrian [
	self forceLayout.
	mondrian nodes
		shape: [ :each | 
			| form content container label labelText |
			container := BlElement new 
				constraintsDo: [:c | 
					c vertical fitContent. 
					c horizontal fitContent.
					c padding: (BlInsets top: 5 bottom: 5)];
				layout: (BlGridLayout vertical cellSpacing: 1).
			container when: BlClickEvent do: [ :event | container fireEvent: (GtPhlowObjectToSelect new object: container; sourceElement: container) ].
			labelText := (((each class name withoutPrefix: 'Br') withoutPrefix: 'Bl') withoutSuffix: 'Element').
			labelText ifEmpty: [ labelText := 'Element' ].
			labelText := labelText asRopedText.
			labelText fontSize: 9.
			labelText foreground: Color lightGray.
			label := BlTextElement new text: labelText. 
			label constraintsDo: [ :c | c grid horizontal alignCenter ].
			container addChild: label.
			form := each asSpartaForm.
			content := BlElement new
				size: form extent;
				background: (BlBackground image: form);
				constraintsDo: [ :c | c grid horizontal alignCenter ].
			container addChild: content.
			container ];
		with: self withAllChildrenBreadthFirst.
	mondrian edges 
		fromCenterBottom;
		toCenterTop;
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.3) width: 2) ];
		connectFrom: #parent.
	mondrian layout tree nodeDistance: 10; levelDistance: 40.
]
