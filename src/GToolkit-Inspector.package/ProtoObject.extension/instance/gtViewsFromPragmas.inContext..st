*GToolkit-Inspector
gtViewsFromPragmas: aCollection inContext: aContext
	^ aCollection
		collect: [ :eachPragma | 
			| view |
			view := GtPhlowView new.
			eachPragma methodSelector numArgs = 1
				ifTrue: [ 
					view := thisContext
						object: self
						perform: eachPragma methodSelector
						withArguments: {view}
						inClass: self class ].
			eachPragma methodSelector numArgs = 2
				ifTrue: [ 
					view := thisContext
						object: self
						perform: eachPragma methodSelector
						withArguments:
							{view.
							aContext}
						inClass: self class ].
			view ]