Extension { #name : #Form }

{ #category : #'*GToolkit-Inspector' }
Form >> gtFormFor: aView [
	<gtView>  
	^ aView explicit
		title: 'Form';
		stencil: [ (BlFormElement fromForm: self) asScrollableElement ]
]
