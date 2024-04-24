Extension { #name : #BlMatrix }

{ #category : #'*GToolkit-Inspector' }
BlMatrix >> gtMatrixFor: aView [
	<gtView>
	<gtContextView>
	
	^ aView explicit
		title: 'Matrix' translated;
		priority: 5;
		stencil: [ GLMBlocMatrixElement new matrix: self asMatrixCollection ]
]
