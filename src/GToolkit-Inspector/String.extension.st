Extension { #name : #String }

{ #category : #'*GToolkit-Inspector' }
String >> gtStringFor: aView [
	<gtView>
	^ aView textEditor
		title: 'String';
		priority: 9;
		text: [ 
			self asRopedText 
				weight: 400;
				fontName: 'Source Sans Pro';
				fontSize: 14 ]
]
