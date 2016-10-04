PdefnGuiPlus : PdefnGui{

	var <quantView;
	var <repView;

	// getName {
	// 	^if () { object.key } { 'anon' }
	// }
	makeViews {
		var lineheight = max(
			skin.buttonHeight * numItems + skin.headHeight,
			zone.bounds.height)  - (skin.margin.y * 2);
		var prop=[0.2,0.4,0.2,0.2] * bounds.width;

		nameView = DragBoth(zone, Rect(0,0, prop[0], lineheight))
		.font_(font)
		.align_(\center)
		.receiveDragHandler_({ arg obj; this.object = View.currentDrag });

		csView = EZText(zone,
			Rect(0,0, prop[1] , lineheight),
			nil, { |ez| object.source = ez.value; })
		.font_(font);

		quantView= EZNumber(zone, Rect(0,0, prop[2], lineheight),
			nil,[0,124,nil,1,4],
			{|source| object.quant=source.value},
		).font_(font);

		repView= EZNumber(zone, Rect(0,0, prop[3], lineheight),
			nil,[0,124,nil,1,4],
			{|source|
				object.quant=source.value
			},
		).font_(font)

	}

	checkUpdate {
		var newState = this.getState;

		var show = newState[\object].notNil;
		zone.visible_(show);
		if (show.not) {
			prevState = newState;
			^this
		};

		if (newState[\object] != prevState[\object]) {
			this.name_(this.getName);
		};
		// works with a little delay, but works
		if (newState[\source] != prevState[\source]) {
			defer { csView.textField.string_(object.source); };
		};
		if (newState[\quant] != prevState[\quant]) {
			defer { quantView.value_(object.quant); };
		};

		prevState = newState;
	}
}
