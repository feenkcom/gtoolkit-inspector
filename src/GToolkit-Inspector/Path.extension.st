Extension { #name : #Path }

{ #category : #'*GToolkit-Inspector' }
Path >> gtFileReferencePathFor: aView [
	<gtView>
	^ aView forward
		title: 'Path';
		priority: 10;
		object: [ self asFileReference ];
		view: #gtPathFor:
]
