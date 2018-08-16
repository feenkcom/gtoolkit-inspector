private
createPageWithContent: aContentElement for: anObject
	"Create and configure an inspector page for a given object and corresponding content element.
	My job is to set up the pager page decorator and configure the neccesary event listeners"
	| aPageModel aPageEmbellisher aPageElement |

	"width should depend on anObject"
	aPageEmbellisher := GtInspectorPagerPageEmbellisher new.
	aPageEmbellisher inspector: self.
	aPageEmbellisher width: (self computePageWidthFor: anObject).
	aPageEmbellisher whenResizedDo: [ :anExtent | self recordPageWidth: anExtent x for: anObject ].

	aPageModel := BrPagerPageModel new.
	aPageModel model: anObject.
	aPageModel embellisher: aPageEmbellisher.

	aPageElement := BlElement new
		viewModel: aPageModel;
		addChild: aContentElement;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	^ aPageElement