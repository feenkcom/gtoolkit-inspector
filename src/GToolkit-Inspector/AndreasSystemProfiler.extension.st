Extension { #name : #AndreasSystemProfiler }

{ #category : #'*GToolkit-Inspector' }
AndreasSystemProfiler >> gtMessagesTreeIn: aView [
	<gtView>
	^ aView forward
		title: 'Tree';
		object: [ tallyRoot ];
		view: #gtMessagesTreeIn:
]

{ #category : #'*GToolkit-Inspector' }
AndreasSystemProfiler class >> gtSpyFor: seconds [
	"Run the system profiler for the specified number of seconds"

	^self gtSpyOn:  [ (Delay forSeconds: seconds) wait ].
]

{ #category : #'*GToolkit-Inspector' }
AndreasSystemProfiler class >> gtSpyOn: aBlock [
	"The main method for profiling and showing the report "

	| profiler |
	profiler := self new.
	^ profiler spyOn: aBlock 
]

{ #category : #'*GToolkit-Inspector' }
AndreasSystemProfiler >> gtTextReportFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Text report';
		aptitude: BrGlamorousCodeEditorAptitude;
		priority: 60;
		text: [ String streamContents: [:s | self report: s ] ]
]
