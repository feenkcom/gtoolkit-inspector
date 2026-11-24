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
CompiledCode class >> gtIsOwnedBitsLiteral: aLiteral [
	"Strings, byte arrays, large integers and boxed floats belong to the compiled code that has them as literal.
	Symbols are counted separately and embedded blocks are counted by the method."

	^ aLiteral class isBits
		and: [ aLiteral isSymbol not and: [ aLiteral isEmbeddedBlock not ] ]

]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtItemsFor: aView [
	^ aView empty 
]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtLiteralsSizeInMemory [
	| literalsSize |
	literalsSize := 0.
	self
		literalsDo: [ :aLiteral | literalsSize := literalsSize + (CompiledCode gtSizeInMemoryOfLiteral: aLiteral) ].
	^ literalsSize
]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtSizeInMemoryCountingLiteralsOnceIn: aSetOfLiterals [
	"Like #gtSpecificSizeInMemory, but literals already in aSetOfLiterals are not counted again"

	| computedSize |
	computedSize := self sizeInMemory.
	self innerCompiledBlocksDo: [ :anEmbeddedBlock |
		computedSize := computedSize + (anEmbeddedBlock gtSizeInMemoryCountingLiteralsOnceIn: aSetOfLiterals) ].
	self literalsDo: [ :aLiteral |
		computedSize := computedSize + (CompiledCode gtSizeInMemoryOfLiteral: aLiteral countingOnceIn: aSetOfLiterals) ].
	^ computedSize

]

{ #category : #'*GToolkit-Inspector' }
CompiledCode class >> gtSizeInMemoryOfLiteral: aLiteral [
	"Answer the size of a literal that is owned by the compiled code.
	We count literal arrays and objects without pointers (strings, byte arrays, large integers, boxed floats).
	Symbols are counted separately, variable bindings are shared and embedded blocks are counted by the method."

	aLiteral class == Array ifTrue: [ ^ aLiteral gtLiteralArraySizeInMemory ].
	(self gtIsOwnedBitsLiteral: aLiteral) ifTrue: [ ^ aLiteral sizeInMemory ].
	^ 0

]

{ #category : #'*GToolkit-Inspector' }
CompiledCode class >> gtSizeInMemoryOfLiteral: aLiteral countingOnceIn: aSetOfLiterals [
	"Like #gtSizeInMemoryOfLiteral:, but a literal already in aSetOfLiterals is not counted again.
	Methods can share literals, for example after ImageCleaner class>>#shareLiterals."

	(aLiteral class == Array or: [ self gtIsOwnedBitsLiteral: aLiteral ]) ifFalse: [ ^ 0 ].
	(aSetOfLiterals includes: aLiteral) ifTrue: [ ^ 0 ].
	aSetOfLiterals add: aLiteral.
	^ aLiteral class == Array
		ifTrue: [ aLiteral gtLiteralArraySizeInMemoryCountingOnceIn: aSetOfLiterals ]
		ifFalse: [ aLiteral sizeInMemory ]

]

{ #category : #'*GToolkit-Inspector' }
CompiledCode class >> gtSizeInMemoryOfStringLiteral: aLiteral countingOnceIn: aSetOfLiterals [
	"The size of aLiteral if it is a string, or of the strings it contains if it is a literal array.
	A literal already in aSetOfLiterals is not counted again."

	(aLiteral class == Array or: [ aLiteral class == ByteString or: [ aLiteral class == WideString ] ])
		ifFalse: [ ^ 0 ].
	(aSetOfLiterals includes: aLiteral) ifTrue: [ ^ 0 ].
	aSetOfLiterals add: aLiteral.
	^ aLiteral class == Array
		ifTrue: [ aLiteral sumNumbers: [ :anObject | self gtSizeInMemoryOfStringLiteral: anObject countingOnceIn: aSetOfLiterals ] ]
		ifFalse: [ aLiteral sizeInMemory ]

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
CompiledCode >> gtSpecificSizeInMemoryStringLiteralsOnly [
	| computedSize |
	
	computedSize := 0.
	self innerCompiledBlocksDo: [ :aCompiledBlock | 
		computedSize := computedSize 
			+ aCompiledBlock gtSpecificSizeInMemoryStringLiteralsOnly ].
		
	^ computedSize + self gtStringLiteralsOnlySizeInMemory.
]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtStringLiteralsOnlySizeInMemory [
	| literalsSize |
	
	literalsSize := 0.
	self literalsDo: [ :aLiteral |
		aLiteral class = Array ifTrue: [
			literalsSize := literalsSize + aLiteral gtStringLiteralsOnlySizeInMemory ].
		
		(aLiteral class = ByteString or: [
			aLiteral class = WideString ]) 
				ifTrue: [
					literalsSize := literalsSize + aLiteral sizeInMemory ] ].
	^ literalsSize
]

{ #category : #'*GToolkit-Inspector' }
CompiledCode >> gtStringLiteralsSizeInMemoryCountingOnceIn: aSetOfLiterals [
	"Like #gtSpecificSizeInMemoryStringLiteralsOnly, but strings already in aSetOfLiterals are not counted again"

	| computedSize |
	computedSize := 0.
	self innerCompiledBlocksDo: [ :anEmbeddedBlock |
		computedSize := computedSize + (anEmbeddedBlock gtStringLiteralsSizeInMemoryCountingOnceIn: aSetOfLiterals) ].
	self literalsDo: [ :aLiteral |
		computedSize := computedSize + (CompiledCode gtSizeInMemoryOfStringLiteral: aLiteral countingOnceIn: aSetOfLiterals) ].
	^ computedSize

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
