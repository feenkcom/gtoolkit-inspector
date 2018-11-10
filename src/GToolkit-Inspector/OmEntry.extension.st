Extension { #name : #OmEntry }

{ #category : #'*GToolkit-Inspector' }
OmEntry >> gtDefinitionFor: aView [
	<gtView>
	self content ifNil: [ ^ aView empty ].
	^ self content gtDefinitionFor: aView
]
