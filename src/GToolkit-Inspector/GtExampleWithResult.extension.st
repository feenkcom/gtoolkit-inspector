Extension { #name : #GtExampleWithResult }

{ #category : #'*GToolkit-Inspector' }
GtExampleWithResult >> gtSourceFor: aView [
	<gtView>
	self example ifNil: [ ^ aView empty ].
	self isMethodDefined ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Source';
		priority: 0;
		stencil: [ (GtPharoMethodCoder forExample: self) asExpandedOnlyElement vFitContentLimited ];
		actionButtonIcon: BrGlamorousVectorIcons browse 
			action: [ self method browse ]
]
