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
	^ aView text
		title: 'Text';
		text: self;
		priority: 10
]
