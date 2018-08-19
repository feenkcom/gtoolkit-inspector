*GToolkit-Inspector
gtViewsFromPragmas: aCollection inContext: aContext
	| views |
	views := aCollection collect: [ :eachPragma | 
		| view |
		view := GtPhlowEmptyView new.
		eachPragma methodSelector numArgs = 1
			ifTrue: [ 
				view := [ thisContext
							object: self
							perform: eachPragma methodSelector
							withArguments: {view}
							inClass: self class]
					on: Error
					do: [ :error |
						error freeze.
						GtPhlowViewWithError new 
							title: 'Error';
							error: error ] ].
		eachPragma methodSelector numArgs = 2
			ifTrue: [ 
				view := thisContext
					object: self
					perform: eachPragma methodSelector
					withArguments:
						{view.
						aContext}
					inClass: self class ].
		view ].
	^ views sorted: [ :a :b | a priority < b priority ]