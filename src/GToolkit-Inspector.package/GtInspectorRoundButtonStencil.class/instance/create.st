api - instantiation
create
	^ BrButton new
		background: Color white;
		look: BrIconLook + BrShadowLook new;
		geometry: BlEllipse new;
		layout: BlLinearLayout horizontal alignCenter;
		size: self size;
		when: BlMouseEnterEvent do: [ :anEvent | anEvent currentTarget background: Color veryVeryLightGray lighter ];
		when: BlMouseLeaveEvent do: [ :anEvent | anEvent currentTarget background: Color white ];
		yourself