Extension { #name : #ZnUrl }

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> gtActionWebBrowseFor: anAction [
    <gtAction>
    ^ anAction explicit stencil: [
        BrButton new
            aptitude: BrGlamorousButtonWithIconAptitude;
            action:  [ WebBrowser openOn: self ];
            icon: BrGlamorousIcons go asElement;
            label: 'Open in Web Browser' translated ]
]

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> gtQueryFor: aView [

	<gtView>
	query ifNil: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Queries';
		  priority: 3;
		  items: [ query associations ];
		  column: 'Property' text: #key;
		  column: 'Value' text: #value weight: 3;
		  send: #value
]

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> gtSegmentsFor: aView [

	<gtView>
	segments ifNil: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Segments';
		  priority: 2;
		  items: [ segments ];
		  column: 'Index' text: [ :_ :index | index ] width: 60;
		  column: 'Value' text: #yourself
]

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> gtUrlFor: aView [
	<gtView>
	^ aView textEditor
		title: 'URL';
		priority: 1;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self printString asRopedText ]
]
