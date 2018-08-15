private
createPageWithContent: aContentElement for: anObject
	| aPageModel aPageDecorator aPageElement |
	
	"width should depend on anObject"
	aPageDecorator := BrPagerPageDecorator new width: 400.
	
	aPageModel := BrPagerPageModel new.
	aPageModel model: anObject.
	aPageModel decorator: aPageDecorator.

	aPageElement := BlElement new
		viewModel: aPageModel;
		addChild: aContentElement;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	^ aPageElement