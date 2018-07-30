*GToolkit-Inspector
gtCommentFor: aView
	"This provides an editable comment of the current class"
	<gtView: 19>
	| view |
	view := self comment gtStringFor: aView.
	^ view title: 'Comment'