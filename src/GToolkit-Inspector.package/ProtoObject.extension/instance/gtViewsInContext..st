*GToolkit-Inspector
gtViewsInContext: aContext
	"This is a utility method that collects all presentations for the current object.
	By default, it simply looks for the #gtView: pragma.
	The inspector can decice whether or not a presentation should be displayed.
	Subclasses might want to override it for more special behavior."
	| pragmas |
	pragmas := Pragma
		allNamed: #gtView:
		from: self class
		to: ProtoObject
		sortedUsing: [ :x :y | (x argumentAt: 1) < (y argumentAt: 1) ].
	"pragmas select: [ :aPragma | aGTInspector shouldDisplayPresentationCreatedBy: aPragma method ]"
	^ self gtViewsFromPragmas: pragmas inContext: aContext