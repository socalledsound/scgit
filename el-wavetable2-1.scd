


(
SynthDef.new(\vosc, {
	arg out =0, buf = 0, numBufs = 2;
	var sig, bufpos;
	bufpos = buf + MouseX.kr(0, numBufs-1);
	sig = VOsc.ar(bufpos, 300, mul: 0.2!2);
	Out.ar(out, sig);
	}
).add;
)

Synth(\vosc);