Extension { #name : #Exception }

{ #category : #'*GToolkit-Inspector' }
Exception >> gtDebugActionFor: anAction [
	<gtAction>
	signalContext ifNil: [ ^ anAction noAction ].
	^ anAction button 
		icon: BrGlamorousVectorIcons debug;
		action: [ [ self debug ] fork ]
]

{ #category : #'*GToolkit-Inspector' }
Exception >> gtHasStack [
	^ signalContext isNotNil and: [ self signalerContext isNotNil ]
]

{ #category : #'*GToolkit-Inspector' }
Exception >> gtLiveFor: aView [
	<gtView>
	self gtHasStack ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Stack';
		priority: 1;
		object: [ self signalerContext ];
		view: #gtStackFor:
]

{ #category : #'*GToolkit-Inspector' }
Exception >> gtMessageTextFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Message';
		priority: 2;
		text: [ self messageText ]
]
