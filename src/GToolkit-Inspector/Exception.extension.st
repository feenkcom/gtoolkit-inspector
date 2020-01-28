Extension { #name : #Exception }

{ #category : #'*GToolkit-Inspector' }
Exception >> gtDebugActionFor: anAction [
	<gtAction>
	signalContext ifNil: [ ^ anAction noAction ].
	^ anAction button 
		icon: BrGlamorousIcons debug;
		action: [ [ self debug ] fork ]
]

{ #category : #'*GToolkit-Inspector' }
Exception >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [ self asDebuggableElement ]
]

{ #category : #'*GToolkit-Inspector' }
Exception >> gtMessageTextFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Message';
		priority: 2;
		text: [ self messageText ]
]
