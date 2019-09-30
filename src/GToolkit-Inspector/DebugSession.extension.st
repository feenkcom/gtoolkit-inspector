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
DebugSession >> gtViewInterruptedStackFor: aView [
	<gtView>
	(self interruptedProcess isNil or: [ 
		self interruptedProcess isSuspended not or: [ 
			self interruptedContext isNil ] ]) ifTrue: [ ^ aView ].
	^ aView explicit
		title: 'Interrupted stack' translated;
		priority: 108;
		stencil: [ 
			| stack methodCodersStencil |
			self flag: 'Replace me with an implementation for a group of contexts!'.
			stack := self interruptedContext stack.
			methodCodersStencil := GtMethodsCoder forItems: (stack collect: #method).
			methodCodersStencil coders withIndexDo: [ :methodCoder :index | 
				|  pcRange |
				pcRange := self pcRangeForContext: (stack at: index).
				methodCoder ensureBuilt.
				(methodCoder sourceEditor text from: pcRange first to: pcRange last) attributes: {
					BlTextUnderlineAttribute new
						paint: BrGlamorousColors errorBackgroundColor;
						beNotOverwritableByStyler } ].
			methodCodersStencil coders first expanded: true.
			methodCodersStencil ]
]

{ #category : #'*GToolkit-Inspector' }
DebugSession >> gtViewLiveDebuggerFor: aView [
	<gtView>
	(self interruptedProcess isNil or: [ 
		self interruptedProcess isSuspended not or: [ 
			self interruptedContext isNil ] ]) ifTrue: [ ^ aView ].
	^ aView explicit
		title: 'Live debugger' translated;
		priority: 150;
		stencil: [ 
			| debuggerElement |
			debuggerElement := GtExpandableDebuggerElement on: self.
			debuggerElement constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ].
			debuggerElement ]
]

{ #category : #'*GToolkit-Inspector' }
DebugSession >> gtViewSuspendedStackFor: aView [
	<gtView>
	(self interruptedProcess isNil or: [ 
		self interruptedProcess isSuspended not ]) ifTrue: [ ^ aView ].
	^ aView explicit
		title: 'Suspended stack' translated;
		priority: 108;
		stencil: [ 
			| stack methodCodersStencil |
			self flag: 'Replace me with an implementation for a group of contexts!'.
			stack := self interruptedProcess suspendedContext stack.
			methodCodersStencil := GtMethodsCoder forItems: (stack collect: #method).
			methodCodersStencil coders withIndexDo: [ :methodCoder :index | 
				|  pcRange |
				pcRange := self pcRangeForContext: (stack at: index).
				methodCoder ensureBuilt.
				(methodCoder sourceEditor text from: pcRange first to: pcRange last) attributes: {
					BlTextUnderlineAttribute new
						paint: BrGlamorousColors errorBackgroundColor;
						beNotOverwritableByStyler } ].
			methodCodersStencil coders first expanded: true.
			methodCodersStencil ]
]
