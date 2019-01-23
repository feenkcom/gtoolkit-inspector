Extension { #name : #DebugSession }

{ #category : #'*GToolkit-Inspector' }
DebugSession >> gtViewInterruptedContextFor: aView [
	<gtView>
	(self interruptedProcess isNil or: [ 
		self interruptedProcess isSuspended not or: [ 
			self interruptedContext isNil ] ]) ifTrue: [ ^ aView ].
	^ aView explicit
		title: 'Interrupted context';
		priority: 105;
		stencil: [ | methodCoder pcRange |
			methodCoder := (GtMethodCoder forMethod: self interruptedContext method) 
				expanded: true;
				ensureBuilt.
			pcRange := self pcRangeForContext: self interruptedContext.
			(methodCoder sourceEditor text from: pcRange first to: pcRange last) attributes: {
				BlTextUnderlineAttribute new
					paint: BrGlamorousColors errorBackgroundColor;
					beNotOverwritableByStyler }.
			methodCoder asElement  ]
]

{ #category : #'*GToolkit-Inspector' }
DebugSession >> gtViewSuspendedContextFor: aView [
	<gtView>
	(self interruptedProcess isNil or: [ 
		self interruptedProcess isSuspended not ]) ifTrue: [ ^ aView ].
	^ aView explicit
		title: 'Suspended context';
		priority: 106;
		stencil: [ 
			| methodCoder pcRange |
			methodCoder := (GtMethodCoder forMethod: self interruptedProcess suspendedContext method) 
				expanded: true;
				ensureBuilt.
			pcRange := self pcRangeForContext: self interruptedProcess suspendedContext.
			(methodCoder sourceEditor text from: pcRange first to: pcRange last) attributes: {
				BlTextUnderlineAttribute new
					paint: BrGlamorousColors errorBackgroundColor;
					beNotOverwritableByStyler }.
			methodCoder asElement ]
]
