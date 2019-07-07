Extension { #name : #ProcessBrowser }

{ #category : #'*GToolkit-Inspector' }
ProcessBrowser >> gtProcesses [
	<return: #OrderedCollection of: #Process>
	"since processList is a WeakArray, we have to strengthen the result"
	^ processList asOrderedCollection copyWithout: nil
]

{ #category : #'*GToolkit-Inspector' }
ProcessBrowser >> gtProcessesFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Processes';
		items: [ self gtProcesses ];
		column: 'Priority' 
			item: [ :aProcess | aProcess priority asString, (
				aProcess isSuspended
					ifTrue: [ ' susp.' ]
					ifFalse: [ '' ]) ]
			width: 50;
		column: 'Id' 
			item: [ :aProcess | aProcess gtId ]
			width: 70;
		column: 'Name' item: [ :aProcess | aProcess gtName ]
]
