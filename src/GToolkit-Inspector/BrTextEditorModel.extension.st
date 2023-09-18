Extension { #name : #BrTextEditorModel }

{ #category : #'*GToolkit-Inspector' }
BrTextEditorModel >> gtTextTreeFor: aView [
	<gtView>
	^ (self text gtTreeFor: aView) 
		title: 'Text tree';
		priority: 4
]
