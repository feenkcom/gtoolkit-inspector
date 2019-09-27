Extension { #name : #BrTextEditor }

{ #category : #'*GToolkit-Inspector' }
BrTextEditor >> gtTextTreeFor: aView [
	<gtView>
	^ (self text gtTreeFor: aView) 
			title: 'Text tree';
			priority: 3 
]
