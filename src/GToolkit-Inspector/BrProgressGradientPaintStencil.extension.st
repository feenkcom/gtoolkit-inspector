Extension { #name : 'BrProgressGradientPaintStencil' }

{ #category : '*GToolkit-Inspector' }
BrProgressGradientPaintStencil >> gtNextGradientsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Gradients';
		items: [ | aStencil |
			aStencil := self copy.
			200 timesCollect: [ aStencil create ] ];
		column: 'Index' text: [ :aPaint :anIndex | anIndex ] width: 40;
		column: 'Preview' do: [ :aColumn | 
			aColumn 
				stencil: [ :aPaint | 
					BlElement new
						background: aPaint;
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent ] ] ]
]

{ #category : '*GToolkit-Inspector' }
BrProgressGradientPaintStencil >> gtPreviewFor: aView [
	^ (super gtPreviewFor: aView)
		actionButtonIcon: BrGlamorousIcons refresh 
		action: [ :aBrButton :aTab | 
			aTab viewContentElement phlow update ]
]
