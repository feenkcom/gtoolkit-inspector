initialize-release
buildTreeLayout
	| view |
	view := self defaultView.
	view addChildren: self nodes.
	view layout: self treeLayout.
	view forceLayout.
	^ view