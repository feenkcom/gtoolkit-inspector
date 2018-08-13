*GToolkit-Inspector
gtOpenInCodeBrowser
	<gtAction>
	^ [ BrButton new 
								look: BrMaterialToggleLabelledLook;
								label: 'Hello'; 
								action: [ self inform: self printString, 'Click on Hello' ] 
				]