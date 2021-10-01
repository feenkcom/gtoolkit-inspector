Extension { #name : #BrPager }

{ #category : #'*GToolkit-Inspector' }
BrPager >> gtPagesFor: aView [
	<gtView>
	self viewModel ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Pages';
		priority: 0.5;
		items: [ self pages ]
]
