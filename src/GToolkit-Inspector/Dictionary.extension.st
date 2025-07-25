Extension { #name : #Dictionary }

{ #category : #'*GToolkit-Inspector' }
Dictionary >> gtCreateViewGroupingFor: aGtViewCreator [
	<gtViewCreator>
	| template bindings |
	
	(self notEmpty and: [ (self associations takeFirst: 10)
			allSatisfy: [ :assoc | assoc value isCollection ] ])
		ifFalse: [ ^ aGtViewCreator empty ].
		
	aGtViewCreator
		title: 'Grouping'.
		
	template := '{viewSelector} aView
	<gtView>
	{optionalNilCheck}
	^ aView columnedList 
		title: ''{viewTitle}'';
		items: [ 
			{objectComputation} associations
				sorted: [ :anAssoc :annotherAssoc | 
					anAssoc value size < annotherAssoc value size ] ];
		column: ''Name'' text: [ :assoc | assoc key ];
		column: ''Count'' text: [ :assoc | assoc value size ];
		send: [ :assoc | assoc value ]'.
		
	bindings := {
		'viewSelector' -> aGtViewCreator newSelector.
		'viewTitle' -> aGtViewCreator title.
		'optionalNilCheck' -> (aGtViewCreator variable
				ifNil: [ '' ]
				ifNotNil: [ :aVariable | aVariable, ' ifNil: [ ^aView empty ].'] ).
		'objectComputation' -> (aGtViewCreator variable 
				ifNil: [ '[ ', aGtViewCreator objectSource, ' ] value' ]
				ifNotNil: [ aGtViewCreator objectSource ])
	} asDictionary.
	 
	aGtViewCreator
		source: (template format: bindings)
]

{ #category : #'*GToolkit-Inspector' }
Dictionary >> gtCreateViewGroupingHorizontalBarChartFor: aGtViewCreator [
	<gtViewCreator>
	| template bindings |
	
	(self notEmpty and: [ (self associations takeFirst: 10)
			allSatisfy: [ :assoc | assoc value isCollection ] ])
		ifFalse: [ ^ aGtViewCreator empty ].
		
	aGtViewCreator
		title: 'Grouping (bar chart)'.
		
	template := '{viewSelector} aView
	<gtView>
	{optionalNilCheck}
	^ aView explicit 
		title: ''{viewTitle}'';
		stencil: [ 
			| groupedData theData maxLines aBarWidthScale barChart |
			
			groupedData := {objectComputation} associations.
			theData := GtPlotterDataGroup new values: groupedData.
			theData := theData sorted: [ :a :b | a value size > b value size ].
			theData := theData
				labelled: [ :each | 
					each key gtDisplayString  ].
			theData := theData background: [ :each | Color blue alpha: 0.5 ].

			maxLines := theData
				inject: 0
				intoValues: [ :anAmount :eachValue | 
					anAmount max: eachValue value size ].
			aBarWidthScale := GtPlotterLinearScale new 
				domainFrom: 0 to: maxLines.

			barChart := GtPlotterHorizontalBarChart new.
			barChart
				barElement: [ :aGtPlotterContext | 
					BlElement new
						aptitude: ((BrGlamorousWithExplicitTooltipAptitude
								text: aGtPlotterContext originalValue value size)
								hideDelay: 0;
								showDelay: 0) ].
			barChart barLabelSpacing: 160.
			barChart barWidthScale: aBarWidthScale.
			barChart barWidthData: [ :eachValue | eachValue value size ].
			barChart amountOfTicks: 4.
			barChart with: theData.

			barChart ]'.
		
	bindings := {
		'viewSelector' -> aGtViewCreator newSelector.
		'viewTitle' -> aGtViewCreator title.
		'optionalNilCheck' -> (aGtViewCreator variable
				ifNil: [ '' ]
				ifNotNil: [ :aVariable | aVariable, ' ifNil: [ ^aView empty ].'] ).
		'objectComputation' -> (aGtViewCreator variable 
				ifNil: [ '[ ', aGtViewCreator objectSource, ' ] value' ]
				ifNotNil: [ aGtViewCreator objectSource ])
	} asDictionary.
	 
	aGtViewCreator
		source: (template format: bindings)
]

{ #category : #'*GToolkit-Inspector' }
Dictionary >> gtCreateViewSourceFor: aGtViewCreator [
	<gtViewCreator>
	| template bindings |
			
	template := '{viewSelector} aView
	<gtView>
	{optionalNilCheck}
	^ aView columnedList 
		title: ''{viewTitle}'';
		items: [ 
			{objectComputation} associations ];
		column: ''Key'' text: [ :each | each key gtDisplayString ];
		column: ''Value'' text: [:each | each value gtDisplayString ];
		send: [ :each | each value ]'.
		
	bindings := {
		'viewSelector' -> aGtViewCreator newSelector.
		'viewTitle' -> aGtViewCreator title.
		'optionalNilCheck' -> (aGtViewCreator variable
				ifNil: [ '' ]
				ifNotNil: [ :aVariable | aVariable, ' ifNil: [ ^aView empty ].'] ).
		'objectComputation' -> (aGtViewCreator variable 
				ifNil: [ '[ ', aGtViewCreator objectSource, ' ] value' ]
				ifNotNil: [ aGtViewCreator objectSource ])
	} asDictionary.
	 
	aGtViewCreator
		source: (template format: bindings)
]

{ #category : #'*GToolkit-Inspector' }
Dictionary >> gtItemsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Items';
		priority: 1;
		items: [ self associations sort: (#key collatedBy: #asString) ];
		children: [ :each | 
			each value isDictionary
				ifTrue: [ each value associations sort: (#key collatedBy: #asString) ]
				ifFalse: [ 
					(each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [ :x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ] weight: 3;
		contextItemLabel: 'Inspect key' action: [ :anElement :aTreeNode | 
			anElement phlow spawnObject: aTreeNode value key ];
		contextItemLabel: 'Inspect value' action: [ :anElement :aTreeNode | 
			anElement phlow spawnObject: aTreeNode value value ];
		contextItemLabel: 'Inspect association' action: [ :anElement :aTreeNode | 
			anElement phlow spawnObject: aTreeNode value ];
		contextItemLabel: 'Remove key and value' action: [ :anElement :aTreeNode | 
			self removeKey: aTreeNode value key ifAbsent: [ "ignore" ].
			anElement phlow contextMenuUpdateViewContent ];
		send: [ :assoc | assoc value  ].
		
	"Implementation note: association sorting uses #collatedBy: to avoid a 'Symbol DNU value: value: error'"
]

{ #category : #'*GToolkit-Inspector' }
Dictionary >> gtKeysFor: aView [
	<gtView>
	^ aView list
		title: 'Keys';
		priority: 5;
		items: [ self keys ]
]

{ #category : #'*GToolkit-Inspector' }
Dictionary >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory 
		+ (self associations sumNumbers: [ :assoc | 
			assoc sizeInMemory ])
]
