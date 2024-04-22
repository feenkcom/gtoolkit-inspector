Extension { #name : #FileSystemError }

{ #category : #'*GToolkit-Inspector' }
FileSystemError >> gtContexViewFileReferencePathFor: aView inContext: aContext [
	<gtContextView>
	
	(aContext hasReceiverOfType: AbstractFileReference) ifFalse: [ ^ aView empty ].
	
	^ aView forward
		title: 'Path';
		object: [ self reference ];
		view: #gtFileReferencePathFor:
]

{ #category : #'*GToolkit-Inspector' }
FileSystemError >> gtFileReferencePathFor: aView [
	<gtView>
	<gtExceptionView>
	
	^ aView forward
		title: 'Path';
		object: [ self reference ];
		view: #gtFileReferencePathFor:
]
