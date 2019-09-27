Extension { #name : #BlBaseAnimation }

{ #category : #'*GToolkit-Inspector' }
BlBaseAnimation >> gtPropertiesFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Properties';
		items: [ {
			'Duration' -> self duration humanReadablePrintString.
			'Delay' -> self delay humanReadablePrintString.
			'Loops' -> self loops.
			'Progress' -> self progress.
			'Repeats' -> self repeats.
			'Is started' -> self isStarted.
			'Is running' -> self isRunning.
			'Start time' -> (self isStarted ifTrue: [ self startTime ] ifFalse: [ 'unknown' ]).
			'Elapsed time' -> (self isStarted ifTrue: [ self elapsedTime humanReadablePrintString ] ifFalse: [ 'unknown' ]).
		} ];
		column: 'Property' do: [ :aColumn | aColumn 
				item: #key; 
				matchParent ];
		column: 'Value' do: [ :aColumn | aColumn 
				item: #value; 
				matchParent ];
		send: [ :x | x value ]
]
