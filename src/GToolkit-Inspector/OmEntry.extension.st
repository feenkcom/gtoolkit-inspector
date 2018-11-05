Extension { #name : #OmEntry }

{ #category : #'*GToolkit-Inspector' }
OmEntry >> gtChangesFor: aView [
	<gtView>
	^ aView textEditor 
		title: 'Changes';
		text: [ | aNewString |
			aNewString := self content accept: EpNewStateVisitor new.
			aNewString asRopedText ]
]
