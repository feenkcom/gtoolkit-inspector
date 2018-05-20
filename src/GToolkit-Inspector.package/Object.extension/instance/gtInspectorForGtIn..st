*GToolkit-Inspector
gtInspectorForGtIn: composite
	"this is a bridge solution to embed all views into the existing inspector"
	<gtInspectorPresentationOrder: 10>
	^ composite bloc
		title: '_GT';
		element: [ 
			| view |
			view := GtPhlowExplicitView new.
			self gtViewsFor: view inContext: nil.
			view asElementDo: [ :x | x ] ]