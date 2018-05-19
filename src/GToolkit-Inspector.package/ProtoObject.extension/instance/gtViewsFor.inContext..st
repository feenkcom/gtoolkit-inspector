*GToolkit-Inspector
gtViewsFor: aView inContext: aContext
	| className title |
	className := self class name.
	title := String streamContents: [ :stream |
		stream
			nextPutAll: (className first isVowel ifTrue: ['an '] ifFalse: ['a ']);
			nextPutAll: className;
			nextPutAll: ' ('.
		self gtDisplayOn: stream.
		stream nextPutAll: ')' ].
	^ aView
		title: title;
		stencil: [ self gtViewsElementInContext: aContext ]