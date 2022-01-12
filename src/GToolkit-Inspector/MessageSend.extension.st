Extension { #name : #MessageSend }

{ #category : #'*GToolkit-Inspector' }
MessageSend >> gtMethodFor: aView [ 
	<gtView>
	self selector ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Method';
		stencil: [ 
			self receiver class classAndMethodFor: self selector
				do: [ :c :m | (GtPharoMethodCoder forMethod: m) asCoderViewModel expanded: true ]
				ifAbsent: [ BlElement new ] ].
			
]

{ #category : #'*GToolkit-Inspector' }
MessageSend >> gtSourceCodeFor: aView [
	^ self gtMethodFor: aView
]
