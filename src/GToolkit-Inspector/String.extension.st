Extension { #name : #String }

{ #category : #'*GToolkit-Inspector' }
String >> gtCreateViewSourceFor: aGtViewCreator [
	<gtViewCreator>
	aGtViewCreator
		source: (String
				streamContents: [ :stream | 
					stream << aGtViewCreator newSelector << ' aView' << String lf << '	<gtView>'
						<< String lf.
					aGtViewCreator variable
						ifNotNil: [ :v | stream << '	' << v << ' ifNil: [ ^aView empty ].' << String lf ].
					stream
						<< '	^ aView textEditor
		title: ''' << aGtViewCreator title
						<< ''';
		text: [' << aGtViewCreator objectSource << ']' ])
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
