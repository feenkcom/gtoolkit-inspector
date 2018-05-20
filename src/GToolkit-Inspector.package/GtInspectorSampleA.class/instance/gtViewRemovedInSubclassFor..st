ui
gtViewRemovedInSubclassFor: aView
	<gtView: 0>
	^ aView 
		title: 'ViewRemovedInSubclass';
		stencil: [ BlElement new size: 50@50; background: Color red ]