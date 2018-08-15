private
findPageContaining: anElement ifPresent: aPresentBlock ifAbsent: anAbsentBlock
	<return: #BlElement>
	
	anElement withParentsDo: [ :eachParentElement |
		(eachParentElement viewModel isNotNil and: [
			(pager viewModel pages includes: eachParentElement viewModel) ])
				ifTrue: [ ^ aPresentBlock  value: eachParentElement ] ].
			
	^ anAbsentBlock value