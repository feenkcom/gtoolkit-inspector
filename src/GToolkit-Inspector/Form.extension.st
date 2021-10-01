Extension { #name : #Form }

{ #category : #'*GToolkit-Inspector' }
Form >> gtFormFor: aView [
	<gtView>  
	^ aView explicit
		title: 'Form';
		stencil: [ self asElement asScrollableElement ]
]
