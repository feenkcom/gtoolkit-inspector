Extension { #name : #Exception }

{ #category : #'*GToolkit-Inspector' }
Exception >> gtDebugActionFor: anAction [
	<gtAction>
	signalContext ifNil: [ ^ anAction empty ].
	^ anAction button 
		icon: BrGlamorousIcons debug;
		action: [ [ self debug ] fork ]
]
