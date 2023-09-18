Extension { #name : #BlFocusFinder }

{ #category : #'*GToolkit-Inspector' }
BlFocusFinder >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Finder';
		priority: 10;
		stencil: [ 
			| anExplanation aRootPreview aReferenceBounds aDescription aNextFocusElement |
			
			aReferenceBounds := reference focusBoundsIn: rootElement direction: direction.
			aNextFocusElement := self nextFocusDo: #yourself ifNone: [ nil ].
			
			anExplanation := BrVerticalPane new
				padding: (BlInsets all: 20);
				hMatchParent;
				vFitContent;
				alignCenter.
				
			aDescription := BrEditor new
				fitContentLimited;
				aptitude: (BrGlamorousRegularEditorAptitude new);
				text: (('Find ' asRopedText foreground: Color gray),
					('next focus element' asRopedText foreground: (Color blue alpha: 0.75)),
					(' when moving ' asRopedText foreground: Color gray),
					((direction name, ' from the ', reference name) asRopedText foreground: (Color red alpha: 0.75))).
			
			aRootPreview := rootElement asSpartaForm asElement clipChildren: false.
			
			aRootPreview addChild: (BlElement new
				relocate: aReferenceBounds origin;
				size: aReferenceBounds extent;
				border: (BlBorder paint: (Color red alpha: 0.5) width: 2)).
				
			aNextFocusElement ifNotNil: [
				| aNextFocusBounds |
				
				aNextFocusBounds := (aNextFocusElement bounds inParent: rootElement) asRectangle.
				
				aRootPreview addChild: (BlElement new
					relocate: aNextFocusBounds origin;
					size: aNextFocusBounds extent;
					border: (BlBorder paint: (Color blue alpha: 0.5) width: 2)).
			].
				
			aRootPreview addChild: (direction gtArrowElementAt: aReferenceBounds center).
			
			anExplanation addChild: aDescription.
			anExplanation addChild: (aRootPreview asScalableElement
				clipChildren: false;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical fitContent ];
				fitWidth).	
		]
]
