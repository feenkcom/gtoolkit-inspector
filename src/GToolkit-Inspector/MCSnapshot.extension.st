Extension { #name : #MCSnapshot }

{ #category : #'*GToolkit-Inspector' }
MCSnapshot >> gtDefinitionsTree [
	| packages classes methods |
	packages := self definitions select: #isOrganizationDefinition.
	^ packages
		collect: [ :eachPackage | 
			classes := ((self definitions select: #isClassDefinition)
					select: [ :each | eachPackage categories includes: each category ])
					sort: #className ascending.
			classes := classes
					collect: [ :eachClass | 
						methods := (((self definitions select: #isMethodDefinition)
								select: [ :each | each className = eachClass className and: [ each classIsMeta not ] ])
								sort: #selector ascending)
								, (((self definitions select: #isMethodDefinition)
										select: [ :each | each className = eachClass className and: [ each classIsMeta ] ])
										sort: #selector ascending).
						methods := methods collect: [ :eachMethod | eachMethod -> #() ].
						eachClass -> methods ].
			eachPackage -> classes ]
]

{ #category : #'*GToolkit-Inspector' }
MCSnapshot >> gtViewDefinitionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Definitions';
		priority: 10;
		items: [ self definitions ];
		column: 'Type' text: [ :each | each class name ] weight: 0.5;
		column: 'Summary' text: [ :each | each gtSummary ]
]

{ #category : #'*GToolkit-Inspector' }
MCSnapshot >> gtViewDefinitionsGroupedByTypeFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Definitions by type';
		priority: 20;
		items: [ 
			(self definitions  
				groupedBy: [ :aDefinition |
					aDefinition class ]) associations ];
		column: 'Type' text: [ :assoc | assoc key ];
		column: 'Count' text: [ :assoc | assoc value size ];
		send: [ :assoc | assoc value ] 
]

{ #category : #'*GToolkit-Inspector' }
MCSnapshot >> gtViewDefinitionsTreeFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Tree';
		priority: 15;
		tooltip: 'Definitions grouped by package & class';
		items: [ self gtDefinitionsTree ];
		children: #value;
		column: 'Type' text: [ :each | each key class name ] weight: 0.5;
		column: 'Summary' text: [ :each | each key gtSummary ];
		send: #key;
		expandAll
]
