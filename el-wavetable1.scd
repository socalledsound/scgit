
s.scope;
FreqScope.new;




(
b = Buffer.alloc(s, 2048);

~amps = [1] ++ ({[0, exprand(0.001,1.0)].choose}!31);

~sig = Signal.sineFill(1024, ~amps, 0!4);
~sig.plot("plain");

~wt = ~sig.asWavetable;
~wt.plot("wt");

b.loadCollection(~wt);
b.plot;
)

(
Routine.run({

{Osc.ar(b, MouseX.kr(100,1000,1), mul:0.05!2)}.play;

100 .do{
b.sine3(
	({exprand(0.75,100)}!16).sort,
	({exprand(0.05,0.7)}!16).sort.reverse,
	{rrand(0,2pi)}!16,
		asWavetable: true);
		0.001.wait;
	}

});
)



{Osc.ar(b, MouseX.kr(100,1000,1), mul:0.05!2)}.play;