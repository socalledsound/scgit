b = buffer.alloc(s, 2048);

(
var sig, wt;
sig = Signal.newClear(1024);
sig.waveFill({
	arg x, old, i;
	var out;
	out = sin(x.pow(1.5));
	out = out * 1.5;
	out = out.fold(-1, 1);
	out = out.cubed;
}, 0, 2pi);

wt = sig.asWavetable;
b.loadCollection(wt);

//sig.plot;
)


{Osc.ar(b, MouseX.kr(10,10000,1) * [1,2.01], mul:0.2!2)}.play