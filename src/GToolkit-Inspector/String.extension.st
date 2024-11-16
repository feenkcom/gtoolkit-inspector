Extension { #name : #String }

{ #category : #'*GToolkit-Inspector' }
String >> gtCreateViewSourceFor: aGtViewCreator [
	<gtViewCreator>
	aGtViewCreator empty
]

{ #category : #'*GToolkit-Inspector' }
String >> gtDisplayOn: aStream [
	aStream nextPutAll: self
]

{ #category : #'*GToolkit-Inspector' }
String >> gtStringFor: aView [
	<gtView>
	^ aView textEditor
		title: 'String';
		priority: 9;
		text: [ self ]
]
