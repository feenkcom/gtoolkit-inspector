Extension { #name : #DebugSession }

{ #category : #'*GToolkit-Inspector' }
DebugSession >> gtViewInterruptedContextFor: aView [
	<gtView>
	(self interruptedProcess isNil
		or: [ self interruptedProcess isSuspended not
				or: [ self interruptedContext isNil ] ])
		ifTrue: [ ^ aView ].
	^ aView explicit
		title: 'Interrupted context';
		priority: 105;
		stencil: [ | methodCoder pcRange |
			methodCoder := GtMethodCoder
				forMethod: self interruptedContext method.
			pcRange := self pcRangeForContext: self interruptedContext.
			(methodCoder sourceText from: pcRange first to: pcRange last)
				attributes:
					{(BlTextUnderlineAttribute new
						color: BrGlamorousColors errorBackgroundColor;
						beNotOverwritableByStyler)}.
			(methodCoder asCoderUIModel expanded: true) asElement ]
]

{ #category : #'*GToolkit-Inspector' }
DebugSession >> gtViewInterruptedStackFor: aView [
	<gtView>
	(self interruptedProcess isNil
		or: [ self interruptedProcess isSuspended not
				or: [ self interruptedContext isNil ] ])
		ifTrue: [ ^ aView ].
	^ aView explicit
		title: 'Interrupted stack' translated;
		priority: 108;
		stencil: [ | stack methodsCoder |
			self
				flag: 'Replace me with an implementation for a group of contexts!'.
			stack := self interruptedContext stack.
			methodsCoder := GtMethodsCoder
				forItems: (stack collect: #method).
			methodsCoder coders
				withIndexDo: [ :methodCoder :index | 
					| pcRange |
					pcRange := self pcRangeForContext: (stack at: index).
					(methodCoder sourceText from: pcRange first to: pcRange last)
						attributes:
							{(BlTextUnderlineAttribute new
								color: BrGlamorousColors errorBackgroundColor;
								beNotOverwritableByStyler)} ].
			methodsCoder asCoderUIModel 
				expandCoder: methodsCoder coders first ]
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
	(self interruptedProcess isNil
		or: [ self interruptedProcess isSuspended not ])
		ifTrue: [ ^ aView ].
	^ aView explicit
		title: 'Suspended stack' translated;
		priority: 108;
		stencil: [ | stack methodsCoder |
			self
				flag: 'Replace me with an implementation for a group of contexts!'.
			stack := self interruptedProcess suspendedContext stack.
			methodsCoder := GtMethodsCoder
				forItems: (stack collect: #method).
			methodsCoder coders
				withIndexDo: [ :methodCoder :index | 
					| pcRange |
					pcRange := self pcRangeForContext: (stack at: index).
					(methodCoder sourceText from: pcRange first to: pcRange last)
						attributes:
							{(BlTextUnderlineAttribute new
								color: BrGlamorousColors errorBackgroundColor;
								beNotOverwritableByStyler)} ].
			methodsCoder asCoderUIModel 
				expandCoder: methodsCoder coders first ]
]
