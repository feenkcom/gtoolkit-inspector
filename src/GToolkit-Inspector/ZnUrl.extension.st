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
ZnUrl >> gtUrlFor: aView [
	<gtView>
	^ aView textEditor
		title: 'URL';
		priority: 1;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self printString asRopedText ]
]
