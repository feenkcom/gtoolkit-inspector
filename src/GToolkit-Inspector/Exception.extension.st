Extension { #name : #Exception }

{ #category : #'*GToolkit-Inspector' }
Exception >> gtDebugActionFor: anAction [
	<gtAction>
	signalContext ifNil: [ ^ anAction empty ].
	^ anAction button 
		icon: BrGlamorousIcons debug;
		action: [ [ self debug ] fork ]
]

{ #category : #'*GToolkit-Inspector' }
Exception >> gtMessageTextFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Message';
		text: [ self messageText ]
]
