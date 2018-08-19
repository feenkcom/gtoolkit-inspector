*GToolkit-Inspector
gtTreeFor: aView
	<gtView>
	^ aView explicit
		title: 'Tree';
		stencil: [ 
			| mondrian |
			mondrian := GtMondrian new.
			self paintTreeWith: mondrian.
			mondrian asPannableElement ]