api - inspector
spawn: aSelectedObject
	| aPageView |

	aPageView := aSelectedObject gtViewsFor: GtPhlowExplicitView new.
	aPageView asElementDo: [ :aPageContentElement |
		pager addPage: (self createPageWithContent: aPageContentElement for: aSelectedObject) ]