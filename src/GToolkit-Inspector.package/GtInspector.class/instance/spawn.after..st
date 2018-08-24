api - inspector
spawn: aSelectedObject after: aPageElement
	| aPageView |

	aPageView := aSelectedObject gtViewsFor: GtPhlowEmptyView new.
	aPageView asElementDo: [ :aPageContentElement |
		pager removePagesAfter: aPageElement.
		pager addPage: (self createPageWithContent: aPageContentElement for: aSelectedObject) ]