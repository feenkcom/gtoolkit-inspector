Extension { #name : #SignalLogger }

{ #category : #'*GToolkit-Inspector' }
SignalLogger class >> startBlocGlobalLogger [

	BlSpaceRenderSignal ignore.
	BlTaskExecutionSignal ignoreRepeatedTasks.
	self startSingleGlobalLogger.

]
