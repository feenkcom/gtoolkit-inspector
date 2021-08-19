Extension { #name : 'BrTextStylerDeferringTask' }

{ #category : '*GToolkit-Inspector' }
BrTextStylerDeferringTask >> gtInfoDictionary [
	^ {
		#stylerStrategy -> self stylerAsyncStrategy.
		#stylerStrategyHash -> self stylerAsyncStrategy identityHash.
		#styler -> self stylerAsyncStrategy styler.
		#stylerHash -> self stylerAsyncStrategy styler identityHash.
		#afterBlock -> self afterBlock
	 }
]

{ #category : '*GToolkit-Inspector' }
BrTextStylerDeferringTask >> gtInfoFor: aView [
	<gtView>

	^ (self gtInfoDictionary asOrderedDictionary gtItemsFor: aView)
			title: 'Info';
			priority: 2;
				actionButtonIcon: BrGlamorousVectorIcons clipboard
				tooltip: 'Copy info'
				action: [
					Clipboard clipboardText:  (String streamContents: [ :aStream |
						self gtInfoDictionary
							do: [ :each | aStream
								nextPutAll: each key;
								nextPutAll: ' -> ';
								nextPutAll: each value printString ]
							separatedBy: [ aStream cr ] ]) ]
]
