Extension { #name : #BlMorphicWindow }

{ #category : #'*GToolkit-Inspector' }
BlMorphicWindow >> gtActionExportAsPNGFor: anAction [
	<gtAction>
	^ anAction button
			icon: BrGlamorousIcons save asElement;
			action: [ 
				self exportAsPNGSilently.
				UIManager default defer: [ self inform: 'PNG file saved next to the image' ] ]
]

{ #category : #'*GToolkit-Inspector' }
BlMorphicWindow >> gtInspectorActionExportAsPNG [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :composite | 
			self exportAsPNGSilently.
			self inform: 'PNG file saved next to the image' ];
		icon: GLMUIThemeExtraIcons glamorousSave;
		title: 'Export as PNG'
	 
]
