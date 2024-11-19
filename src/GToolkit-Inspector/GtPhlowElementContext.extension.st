Extension { #name : #GtPhlowElementContext }

{ #category : #'*GToolkit-Inspector' }
GtPhlowElementContext >> gtLiveFor: aView [
	<gtView>
	self element ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Element';
		priority: 1;
		object: [ self element ];
		view: #gtLiveFor:
]

{ #category : #'*GToolkit-Inspector' }
GtPhlowElementContext >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'Is view title';
			boolean: self isViewTitle.
		GtPhlowOverviewItem new
			name: 'Is view content';
			boolean: self isViewContent.
		GtPhlowOverviewItem new
			name: 'Is tool';
			boolean: self isTool.
		GtPhlowOverviewItem new
			name: 'Is tool label';
			boolean: self isToolLabel.
		GtPhlowOverviewItem new
			name: 'Is action';
			boolean: self isAction.
		GtPhlowOverviewItem new
			name: 'Is exception';
			boolean: self isException.
		GtPhlowOverviewItem new
			name: 'Is popup container';
			boolean: self isPopupContainer.
		GtPhlowOverviewItem new
			name: 'Element';
			value: self element.
		GtPhlowOverviewItem new
			name: 'Entity';
			value: self entity.
		GtPhlowOverviewItem new
			name: 'Tool view model';
			value: self toolViewModel.
		GtPhlowOverviewItem new
			name: 'First parent with view content';
			secureValue: [ self firstParentWithViewContent ];
			ifExceptionValueDescription: [ :anException | 'Not found' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ].
		GtPhlowOverviewItem new
			name: 'First child with view title';
			secureValue: [ self firstChildWithViewTitle ];
			ifExceptionValueDescription: [ :anException | 'Not found' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ].
		GtPhlowOverviewItem new
			name: 'All children with view title';
			secureValue: [ self allChildrenWithViewTitle ];
			ifExceptionValueDescription: [ :anException | 'Not found' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ].
		GtPhlowOverviewItem new
			name: 'First child with view content';
			secureValue: [ self firstChildWithViewContent ];
			ifExceptionValueDescription: [ :anException | 'Not found' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ].
		GtPhlowOverviewItem new
			name: 'First child with composite view content';
			secureValue: [ self firstChildWithCompositeViewContent ];
			ifExceptionValueDescription: [ :anException | 'Not found' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ].
		GtPhlowOverviewItem new
			name: 'View content';
			secureValue: [ self viewContent ];
			ifExceptionValueDescription: [ :anException | 'Not found' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ].
		GtPhlowOverviewItem new
			name: 'Text view content';
			secureValue: [ self textViewContent ];
			ifExceptionValueDescription: [ :anException | 'Not found' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ].
		GtPhlowOverviewItem new
			name: 'Popup container parent';
			secureValue: [ self firstPopupContainerParentDo: [ :anElement | anElement ] ifNone: [ nil ] ];
			ifExceptionValueDescription: [ :anException | 'Not found' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ].
		GtPhlowOverviewItem new
			name: 'First child with action';
			secureValue: [ self firstChildWithAction ];
			ifExceptionValueDescription: [ :anException | 'Not found' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]. }
]

{ #category : #'*GToolkit-Inspector' }
GtPhlowElementContext >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Overview';
		priority: 0;
		items: [ self gtOverview ];
		column: 'Name' text: #name;
		column: 'Description' text: #description;
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
GtPhlowElementContext >> gtPhlowViewFor: aView [
	<gtView>
	self entity ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Entity';
		priority: 2;
		object: [ self entity ];
		view: #gtLiveFor:
]
