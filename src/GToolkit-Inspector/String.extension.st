Extension { #name : #String }

{ #category : #'*GToolkit-Inspector' }
String >> gtCreateHtmlWebViewViewSourceFor: aGtViewCreator [
	<gtViewCreator>
	| template bindings |
	
	((self beginsWith: 'http://') or: [self beginsWith: 'https://']) ifFalse: [ ^ self ].
	
	template := '{viewSelector} aView
	<gtView>
	{optionalNilCheck}
	^ aView explicit
		title: ''{viewTitle}'';
		stencil: [ 
			GtWebViewElement new 
				url: {objectSource} ]' .
	
	bindings := {
			'viewSelector' -> aGtViewCreator newSelector.
			'optionalNilCheck' -> (aGtViewCreator variable
				ifNil: [ '' ]
				ifNotNil: [ :aVariable | aVariable, ' ifNil: [ ^aView empty ].'] ).
			'viewTitle' -> aGtViewCreator title.
			'objectSource' -> aGtViewCreator objectSource
		} asDictionary.
		
	aGtViewCreator
		source: (template format: bindings)
]

{ #category : #'*GToolkit-Inspector' }
String >> gtCreateViewSourceFor: aGtViewCreator [
	<gtViewCreator>
	| template bindings |
	 
	template := '{viewSelector} aView
	<gtView>
	{optionalNilCheck}
	^ aView textEditor
		title: ''{viewTitle}'';
		text: [ {objectSource} ]' .
	
	bindings := {
			'viewSelector' -> aGtViewCreator newSelector.
			'optionalNilCheck' -> (aGtViewCreator variable
				ifNil: [ '' ]
				ifNotNil: [ :aVariable | aVariable, ' ifNil: [ ^aView empty ].'] ).
			'viewTitle' -> aGtViewCreator title.
			'objectSource' -> aGtViewCreator objectSource
		} asDictionary.
		
	aGtViewCreator
		source: (template format: bindings)
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
