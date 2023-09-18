Class {
	#name : #GtTraceStylerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #accessing }
GtTraceStylerExamples >> newStyler [
	<gtExample>
	^ GtTraceStyler new
]

{ #category : #accessing }
GtTraceStylerExamples >> styledTrace [
	<gtExample>
	| styler |
	styler := self newStyler.
	^ styler style: 'GtRrWorkerTaskContext>>value
[ result := aTaskContext value ] in GtRrInImageWorker>>taskRun:
FullBlockClosure(BlockClosure)>>on:do:
GtRrInImageWorker>>taskRun:
[ self taskRun: self taskPoll ] in GtRrInImageWorker>>taskPollForever
FullBlockClosure(BlockClosure)>>repeat
GtRrInImageWorker>>taskPollForever
[ self taskPollForever ] in GtRrInImageWorker>>start
[self value.
			"IMPORTANT: Do not step over next line of code. See method comments for details"
			Processor terminateRealActive] in FullBlockClosure(BlockClosure)>>newProcess
' asRopedText
]
