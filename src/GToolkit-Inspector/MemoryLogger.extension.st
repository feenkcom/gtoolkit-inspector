Extension { #name : #MemoryLogger }

{ #category : #'*GToolkit-Inspector' }
MemoryLogger >> gtGroupedFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Grouped';
		items: [ (self recordings reverse groupedBy: [ :each | each class ]) associations ];
		column: 'Class' do: [ :aColumn |
			aColumn
				item: [ :each | each key asString ];
				matchParent ];
		column: 'Instances' do: [ :aColumn |
			aColumn
				item: [ :each | each value size asString  ];
				matchParent ]
]

{ #category : #'*GToolkit-Inspector' }
MemoryLogger >> gtRecordingsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Recordings' translated;
		priority: 50;
		items: [ self recordings reverse ];
		column: 'Timestamp' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each timestamp asString ]; 
				matchParent ];
		column: 'Process' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each processId asString ]; 
				matchParent ];
		column: 'Type' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each name ]; 
				matchParent ];
		column: 'Contents' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | String streamContents: [ :s | each printOneLineContentsOn: s ] ]; 
				matchParent ]
]

{ #category : #'*GToolkit-Inspector' }
MemoryLogger class >> saveBlocGlobalLogger [
	"Collect detailed events for 10 seconds and then save the file"

	| semaphore |

	semaphore := Semaphore new.
	[ BlSpaceRenderSignal dontIgnore.
	BlTaskExecutionSignal clearIgnored.
	10 seconds wait.
	BlSpaceRenderSignal ignore.
	BlTaskExecutionSignal ignoreRepeatedTasks.
	semaphore signal ]
		forkAt: Processor userSchedulingPriority + 5 named: 'Bloc Global Logger'.
	semaphore wait.
	self instance saveStonFile: 'bloclog.stgz' asFileReference
]
