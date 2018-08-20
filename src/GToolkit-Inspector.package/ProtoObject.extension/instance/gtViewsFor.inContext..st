*GToolkit-Inspector
gtViewsFor: aView inContext: aContext
	| className title displayText resultingView |
	className := self class name.
	displayText := [ (String streamContents: [ :stream | self gtDisplayOn: stream ]) asRopedText ]
			on: Error 
			do: [ :e | 'Error printing' asRopedText foreground: Color red ].
	title := String streamContents: [ :stream |
		stream
			nextPutAll: (className first isVowel ifTrue: ['an '] ifFalse: ['a ']);
			nextPutAll: className;
			nextPutAll: ' (';
			nextPutAll: displayText;
			nextPutAll: ')' ].
	resultingView := ((aView composite
		views: (self gtViewsInContext: aContext))
		labelled: title).
	self gtActions do: [ :action |
		resultingView actionStencil: action ].
	^ resultingView