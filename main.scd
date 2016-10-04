

(
// init

MIDIClient.init(0, 3);
 Pdefn.removeAll;
 Pdef.removeAll;
Window.closeAll;

"test.scd".loadRelative;
~tabV=TabbedView2();

a=PdefAllGui();
a.filTextV.remove;
a.edits.do{arg x; x.nameBut.do(_.keyDownAction_(nil))};
a.parent.asView.keyDownAction_{arg s, c;
	try{~obj.pl(c.digit%16)}
};
Pdef(\acc).play
)
