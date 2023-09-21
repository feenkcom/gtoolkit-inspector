Extension { #name : #FileSystemError }

{ #category : #'*GToolkit-Inspector' }
FileSystemError >> gtReferenceFor: aView [
	<gtView>
	<gtExceptionDebuggingView>
	^ aView forward
		title: 'Path';
		object: [ self reference ];
		view: #gtFileReferencePathFor:
]
