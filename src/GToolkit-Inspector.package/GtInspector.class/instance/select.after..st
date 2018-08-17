api - inspector
select: aSelectedObject after: aPageElement
	(pager hasPageAfter: aPageElement) ifTrue: [
		self spawn: aSelectedObject after: aPageElement ]