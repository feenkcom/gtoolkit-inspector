*GToolkit-Inspector
gtResizersFor: aView
	<gtView: 10>
	| withAllParents |
	withAllParents := Array streamContents: [ :aStream |
		aStream nextPut: self.
		self parentsDo: [ :anElement | aStream nextPut: anElement ] ].
	
	^ aView explicit
		title: 'Resizers' translated;
		stencil: [
			| list |
			list := BrColumnedList new display: withAllParents reversed.
			list column 
				title: 'Icon';
				stencil: [ :each |
					| icon element |
					icon := each asSpartaForm scaledToSize: 16@16.
					element := BlElement new.
					element width: 16.
					element height: 16.
					element margin: (BlInsets all: 3).
					element background: icon.
					element ].
			list column 
				title: 'Width';
				stencil: [ :each | 
					| widthElement |
					widthElement := (BrListLabelStencil matchParent: each constraints horizontal resizer gtDisplayString) asElement.
					widthElement constraintsDo: [ :c | c horizontal exact: 150].
					widthElement ].
			list column 
				title: 'Height';
				stencil: [ :each | 
					| widthElement |
					widthElement := (BrListLabelStencil matchParent: each constraints vertical resizer gtDisplayString) asElement.
					widthElement constraintsDo: [ :c | c horizontal exact: 100].
					widthElement ].
			list column 
				title: 'Layout';
				stencil: [ :each | 
					| widthElement |
					widthElement := (BrListLabelStencil matchParent: each layout gtDisplayString) asElement.
					widthElement constraintsDo: [ :c | c horizontal exact: 150].
					widthElement ].		
			list column 
				title: 'Element';
				stencil: [ :each | (BrListLabelStencil matchParent: each gtDisplayString) ].			
			list
			].