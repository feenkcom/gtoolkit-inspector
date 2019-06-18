Extension { #name : #BlText }

{ #category : #'*GToolkit-Inspector' }
BlText >> gtStringFor: aView [
	<gtView>
	^ self asString 
			ifEmpty: [ aView empty ]
			ifNotEmpty: [ :aString | (aString gtLiveFor: aView) title: 'String' ]
]

{ #category : #'*GToolkit-Inspector' }
BlText >> gtTextFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Text';
		text: self;
		withoutLook
]
