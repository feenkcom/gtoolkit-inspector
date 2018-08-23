*GToolkit-Inspector
gtMeasurementChainFor: aView
	<gtView>
	| withAllParents |
	withAllParents := Array streamContents: [ :aStream |
		| currentElement |
		currentElement := self.
		aStream nextPut: currentElement.
		[ currentElement hasParent ] whileTrue: [ 
			currentElement := currentElement parent.
			aStream nextPut: currentElement ] ].
	
	^ aView explicit 
		title: 'Measurement' translated;
		priority: 15;
		stencil: [
			| list |
			list := BrColumnedList new display: [ withAllParents reversed withIndexCollect: [ :anElement :anIndex |
				{
					#index -> anIndex .
					#spec -> anElement layout previousMeasurementSpec.
					#element -> anElement.
					#layout -> anElement layout
				} asDictionary ]  ].
			list column 
				title: 'Index';
				stencil: [ :each | 
					| element |
					element := (BrListLabelStencil fitContent: (each at: #index) gtDisplayString) asElement.
					element constraintsDo: [ :c | c horizontal exact: 50 ]. 
					].
			list column 
				title: 'Width spec';
				stencil: [ :each | 
					| element |
					element := (BrListLabelStencil fitContent: ((each at: #spec) ifNotNil: #widthSpec) gtDisplayString ) asElement.
					element constraintsDo: [ :c | c horizontal exact: 100 ]. 
					].
			list column 
				title: 'Height spec';
				stencil: [ :each | 
					| element |
					element := (BrListLabelStencil fitContent: ((each at: #spec) ifNotNil: #heightSpec) gtDisplayString ) asElement.
					element constraintsDo: [ :c | c horizontal exact: 100 ]. 
					].
			list column 
				title: 'Layout';
				stencil: [ :each | 
					| element |
					element := (BrListLabelStencil fitContent: (each at: #layout) gtDisplayString ) asElement.
					element constraintsDo: [ :c | c horizontal exact: 100 ]. 
					].
			list column 
				title: 'Element';
				stencil: [ :each | BrListLabelStencil matchParent: (each at: #element) gtDisplayString ].		
			list
			].