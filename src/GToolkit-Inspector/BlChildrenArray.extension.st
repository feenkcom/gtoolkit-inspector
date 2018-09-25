Extension { #name : #BlChildrenArray }

{ #category : #'*GToolkit-Inspector' }
BlChildrenArray >> gtChildrenFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Children';
		stencil: [ 
			| list |
			list := BrColumnedList new display: array.
			list addEventHandler: GtInspectorListToSelectHandler new.
			list constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			list column
				title: 'Child';
				stencil: [ :aChild :index | 
					| text textElement |
					text := [ aChild gtDisplayString asRopedText ] 
						on: Error 
						do: [ :e | e messageText asRopedText foreground: Color red ].
					textElement :=  (BrListLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ]. ].
			list ]
]
