private
updateCloseButtonVisiblity: aCloseButton
	((self contentElement viewModel = self inspector pager pages last)
		and: [ (self contentElement viewModel ~= self inspector pager pages first) ])
			ifTrue: [ aCloseButton visibility: BlVisibility visible ]
			ifFalse: [ aCloseButton visibility: BlVisibility hidden ]