Extension { #name : 'ExceptionSet' }

{ #category : '*GToolkit-Inspector' }
ExceptionSet >> gtExceptionsFor: aView [
	<gtView>
	exceptions ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Exceptions';
		items: [ exceptions ]
]
