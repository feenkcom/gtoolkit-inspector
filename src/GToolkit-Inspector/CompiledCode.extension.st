Extension { #name : #CompiledCode }

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtBytecodeFor: aView [
	<gtView>
	^ aView list
		title: 'Bytecode' translated;
		priority: 25;
		items: [ self symbolicBytecodes ];
		itemText: [ :each | each printString ]
]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtBytesFor: aView [
	^ aView empty
]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtHeaderFor: aView [
	<gtView> 
	^ aView textEditor
		title: 'Header';
		priority: 26;
		text: [ self headerDescription ]
]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtHexDumpFor: aView [
	 ^ aView empty
]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtInspectorVariableNodesIn: aCollection [
	aCollection add: (GtInspectorDynamicNode 
		hostObject: self 
		label: 'literal0'
		value: self header).
				
	aCollection addAll: (self allLiterals collectWithIndex: [ :aLiteral :anIndex | 
		GtInspectorDynamicNode hostObject: self label: ('literal', anIndex asString) value: aLiteral ]).
	self initialPC to: self size do: [ :index |
		aCollection add: (GtInspectorDynamicNode 
			hostObject: self 
			label: ('bc ', index asString) 
			value: (self at: index)) ] 

]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtItemsFor: aView [
	^ aView empty 
]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtLiteralsSizeInMemory [
	| literalsSize |
	
	literalsSize := 0.
	self literalsDo: [ :aLiteral |
		aLiteral class = Array ifTrue: [
			literalsSize := literalsSize + aLiteral gtLiteralArraySizeInMemory ].
		
		(aLiteral class = ByteString or: [
			aLiteral class = WideString ]) 
				ifTrue: [
					literalsSize := literalsSize + aLiteral sizeInMemory ] ].
	^ literalsSize
]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtSpecificSizeInMemory [
	| computedSize |
	
	computedSize := self sizeInMemory.
	self innerCompiledBlocksDo: [ :aCompiledBlock | 
		computedSize := computedSize + aCompiledBlock gtSpecificSizeInMemory ].
		
	^ computedSize + self gtLiteralsSizeInMemory.
]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtTreeFor: aView context: aContext [
	^ aView empty
]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtViewCompiledBlocksDo: aView [
	<gtView>
	
	^ aView tree 
		title: 'Compiled blocks';
		priority: 28;
		items: [ {self} ];
		expandAll;
		children: [ :aCompiledCode |
			| all |
			all := OrderedCollection new.
			aCompiledCode innerCompiledBlocksDo: [ :each | all add: each ].
			all ]
]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtViewIntermediareRepresentationFor: aView [
	<gtView> 
	^ aView text 
		title: 'Ir';
		priority: 27;
		text: [ 
			| string |
			string := self ast ir  longPrintString.
			string copyFrom: 2 to: string size ]
]
