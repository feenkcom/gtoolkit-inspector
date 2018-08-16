private
computePageWidthFor: anObject
	"The width is recorded when user explicitely resizes the page, it is then later
	used while inspecting an object of that same type.
	If there is no recorded width, inspector takes the width of a previous page if one exists
	or falls back to the default width"
	<return: #Number>

	^ PageWidthPerClass
		at: anObject class
		ifAbsent: [ pager pages
			ifEmpty: [ self defaultPageWidth ]
			ifNotEmpty: [ pager pages last embellisher width ] ]