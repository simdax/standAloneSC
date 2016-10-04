// =====================================================================
// SuperCollider Workspace
// =====================================================================


(
var t;
Pdefn(\rot, 0); Pdefn(\step, 2); Pdefn(\nb, 4);
Pdefn(\basse, Pstep(Pseries(Pdefn(\rot).asStream, Pdefn(\step).asStream, Pdefn(\nb).asStream).wrap(-2, 4), 2).repeat);


Pdef(\acc,
	Pbind(
		\basse, Pdefn(\basse),
		\degree, Pkey(\basse) + [0,2,4],
		\amp, 0.1,
	)
	.midi(0,1),
	true // track
);

~pdef={
	arg prefix;

	Pdef(prefix,
		Pbind(
			\dir, Pseed(Pdefn(\degSeed++prefix), Prand([-1,0,1])).integrate,
			\dur, Pseed(Pdefn(\degDur++prefix), Prand([1,2])),
			\amp, 0.5,
			\accord, Pchords(		PdefCol(\acc, \basse)	),
			\mtranspose, Pdefn(\appo++prefix),
			\degree, PdegreeToKey(
				Pkey(\dir) + Pdefn(\depart++prefix),
				Pkey(\accord),
				7
			),
			\stretch, Pdefn(\stretch++prefix).reciprocal,
		)
		.midi(2,prefix)
		.fin(Pdefn(\notes++prefix).asStream)
		.repeat(Pdefn(\repeats++prefix).asStream)
	);
	
	Pdef(prefix).source.postln;
	t=~tabV.add(prefix); t.addFlowLayout;
	PdefnAllGui(parent:t)
	.prefix_(prefix.asString).filtering_(true);


	(
		degSeed:1000.rand, depart:0,
		degDur:100.rand, stretch:[2,4,8].choose,
		appo:0,
		notes:(4..8).choose, repeats:1 
	)
	.keysValuesDo{arg k,v; Pdefn((k++prefix),v)};

	
};

~obj=(pl:{arg s, id;
	id=id.asSymbol;
	if(Pdef(id).source.isNil)
	{~pdef.(id)}
	{Pdef(id).play}
})

)


