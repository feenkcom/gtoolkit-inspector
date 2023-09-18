Extension { #name : #GtVirtualMachineSourceUnit }

{ #category : #'*GToolkit-Inspector' }
GtVirtualMachineSourceUnit >> gtIncludesFor: aView [
	<gtView>
	
	includes ifEmpty: [ ^ aView empty ].
	
	^ aView list
		title: 'Includes';
		priority: 2;
		items: [ includes ]
]

{ #category : #'*GToolkit-Inspector' }
GtVirtualMachineSourceUnit >> gtSourcesFor: aView [
	<gtView>
	
	sources ifEmpty: [ ^ aView empty ].
	
	^ aView list
		title: 'Sources';
		priority: 1;
		items: [ sources ]
]
