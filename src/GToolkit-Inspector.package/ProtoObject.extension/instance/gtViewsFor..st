*GToolkit-Inspector
gtViewsFor: aView
	"this is the default entry method for retrieving the wrapper view containing all views"
	^ self gtViewsFor: aView inContext: nil
		