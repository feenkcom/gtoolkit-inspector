Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 10;
		actionStencil: [ 
			BrButton new 
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons browse asElement;
				action: [ self browse ] ];
		stencil: [ (GtMethodCoder forMethod: self) expanded: true; asElement ]
]
