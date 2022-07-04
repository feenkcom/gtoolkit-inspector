Extension { #name : #GtVirtualMachineSourceUnit }

{ #category : #'*GToolkit-Inspector' }
GtVirtualMachineSourceUnit >> gtIncludesFor: aView [
	<gtView>
	
	includes ifEmpty: [ ^ aView empty ].
	
	^ aView list
		title: 'Includes';
		priority: 1;
		items: [ includes ]
]
