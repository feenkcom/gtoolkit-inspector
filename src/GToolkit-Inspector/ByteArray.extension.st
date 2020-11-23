Extension { #name : #ByteArray }

{ #category : #'*GToolkit-Inspector' }
ByteArray >> gtBytesFor: aView [
	<gtView>
	^ aView list
		title: 'Bytes';
		send: [ :anAssoc | anAssoc value ];
		items: [ 
			| aDisplayedBytes |
			aDisplayedBytes := self size <= 2048 
				ifTrue: [ self ]
				ifFalse: [ self copyFrom: 1 to: 2048 ].
			{
				'hex string' -> (String streamContents: [ :out | 
					aDisplayedBytes do: [ :each | 
						each printOn: out base: 16 nDigits: 2 ] ]).
				'hex lines' -> (String streamContents: [ :out |
					aDisplayedBytes withIndexDo: [ :each :index |
						index = 1 ifFalse: [ 
							index - 1 \\ 8 = 0 ifTrue: [ out cr ] ifFalse: [ out space ] ].
								each printOn: out base: 16 nDigits: 2 ] ]).
					'latin1' -> ([ ZnCharacterEncoder latin1 decodeBytes: aDisplayedBytes ]
											on: ZnCharacterEncodingError do: [ :exception | exception ]).
					'utf8' -> ([ ZnUTF8Encoder new decodeBytes: aDisplayedBytes ] 
											on: ZnCharacterEncodingError do: [ :exception | exception ]).
					'integer' -> aDisplayedBytes asInteger.
					'integer reversed' -> aDisplayedBytes reversed asInteger } ]
]

{ #category : #'*GToolkit-Inspector' }
ByteArray >> gtHexDumpFor: aView [
	<gtView>
	 self isCompiledMethod ifTrue: [ ^ aView empty ].
	^ aView textEditor
			title: 'Hex Dump';
			text: [ 
				| aMaxBytes aDisplayStream aDisplayRopeText |
				aMaxBytes := 10000.
				aDisplayStream := (String new: aMaxBytes * 5) writeStream.
				self hexDumpOn: aDisplayStream max: aMaxBytes.
				aDisplayRopeText := aDisplayStream contents asString asRopedText  .
				aDisplayRopeText ];
			glamorousMonospace
]
