Extension { #name : #BlTktDecoratedCommand }

{ #category : #'*GToolkit-Inspector' }
BlTktDecoratedCommand >> gtDecoratedCommands [
	<return: #Array of: #BlTktProtoCommand>
	^ Array streamContents: [ :aStream | 
		self putDecoratedCommandInto: aStream ]
]

{ #category : #'*GToolkit-Inspector' }
BlTktDecoratedCommand >> gtDecoratedCommandsFor: aView [
	<gtView>
	self command ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Commands';
		items: [ self gtDecoratedCommands ]
]

{ #category : #'*GToolkit-Inspector' }
BlTktDecoratedCommand >> putDecoratedCommandInto: aStream [
	self command ifNil: [ ^ self ].
	aStream nextPut: self command.
	self command putDecoratedCommandInto: aStream.
]
