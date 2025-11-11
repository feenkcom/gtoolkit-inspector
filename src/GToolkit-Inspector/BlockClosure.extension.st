Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-Inspector' }
BlockClosure >> gtSourceCodeFor: aView [
	<gtView>
	self sourceNode ifNil: [ ^ aView empty ].
	self sourceNode methodNode ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Source code';
		priority: 1;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect Block'
			action: [ :aButton | aButton phlow spawnObject: self ];
		actionButtonIcon: BrGlamorousVectorIcons browse
			tooltip: 'Browse method'
			action: [ :aButton | self sourceNode methodNode compiledMethod gtBrowseFrom: aButton ];
		stencil: [ ((self sourceNode methodNode compilationContext
				ifNil: [ (GtPharoMethodCoder forNewMethod: Object)
						sourceCode: (GtCoderExplicitTextSource new text: self sourceNode methodNode formattedCode) ]
				ifNotNil: [ (GtPharoMethodCoder
						forMethod: self sourceNode methodNode compiledMethod) asCoderViewModel
						selfObject: self receiver ])
				highlighter: (GtRBPatternHighlighter new ast: self sourceNode);
				asExpandedOnlyElement) vFitContentLimited ]
]

{ #category : #'*GToolkit-Inspector' }
BlockClosure >> gtVariablesFor: aView [
	<gtView>
	self outerContext ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Variables';
		priority: 2;
		object: [ self outerContext ];
		view: #gtVariablesFor:
]
