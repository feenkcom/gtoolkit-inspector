ui
gtViewRemovedInSubclassFor: aView
	<gtView: 0>
	^ aView explicit
		title: 'ViewRemovedInSubclass';
		stencil: [ BlElement new size: 50@50; background: Color red ]