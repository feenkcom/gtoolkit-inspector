Extension { #name : #GtExampleWithResult }

{ #category : #'*GToolkit-Inspector' }
GtExampleWithResult >> gtSourceFor: aView [
	<gtView>
	self example ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Source';
		priority: 0;
		stencil: [ (GtMethodCoder forExample: self) expanded: true ];
		actionButtonIcon: BrGlamorousIcons browse 
			action: [ self method browse ]
]
