Extension { #name : 'BlMatrix' }

{ #category : '*GToolkit-Inspector' }
BlMatrix >> gtMatrixFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Matrix' translated;
		stencil: [ GLMBlocMatrixElement new matrix: self asMatrixCollection ]
]
