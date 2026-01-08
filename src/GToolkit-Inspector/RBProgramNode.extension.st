Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-Inspector' }
RBProgramNode >> gtPropertiesFor: aView [
	<gtView>
	properties ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Properties';
		priority: 15;
		items: [ properties 
			ifNil: #() 
			ifNotNil: [ :aDictionary |
				aDictionary associations ] ];
		column: 'Key' text: #key;
		column: 'Value' text: #value weight: 3;
		column: 'Type' text: [ :anAssoc | anAssoc value class ] weight: 2;
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
RBProgramNode >> gtSourceCodeFor: aView [
	<gtView>
	self methodNode ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Source code';
		priority: 10;
		actionButtonIcon: BrGlamorousVectorIcons browse
			tooltip: 'Browse'
			action: [ :aButton | self methodNode compiledMethod gtBrowseFrom: aButton ];
		stencil: [ (((self methodNode compilationContext
				ifNotNil: [ self methodNode compiledMethod ])
				ifNil: [ (GtPharoMethodCoder forNewMethod: Object)
						sourceCode: (GtCoderExplicitTextSource new text: self methodNode formattedCode) ]
				ifNotNil: [ GtPharoMethodCoder forMethod: self methodNode compiledMethod ])
				highlighter: (GtRBPatternHighlighter new ast: self);
				asExpandedOnlyElement) vFitContentLimited ]
]

{ #category : #'*GToolkit-Inspector' }
RBProgramNode >> gtTreeFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Tree';
		priority: 60;
		items: [ {self} ];
		children: #children;
		expandAll;
		column: 'Node'
			text: [ :each | 
				| text |
				text := each class name asRopedText.
				(each class name beginsWith: 'RB')
					ifTrue: [ (text from: 1 to: 2) foreground: Color lightGray ].
				(each class name endsWith: 'Node')
					ifTrue: [ (text from: each class name size - 3 to: each class name size) foreground: Color veryLightGray ].
				text ];
		column: 'Interval'
			text: [ :each | each sourceInterval first asString , '-' , each sourceInterval stop asString ]
			width: 100;
		column: 'Source'
			text: [ :each | each formattedCode asRopedText glamorousCodeFontAndSmallSize ]
			width: 400
]

{ #category : #'*GToolkit-Inspector' }
RBProgramNode >> gtWithAllChildren [
	| children |
	children := OrderedCollection with: self.
	self nodesDo: [ :each | children addLast: each ].
	^ children
]
