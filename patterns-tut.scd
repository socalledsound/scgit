TempoClock.default.tempo = 1;

(
SynthDef.new(\sine, {
	arg freq=440, atk = 0.005, rel = 0.3, amp = 1, pan = 0;
	var sig, env;
	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.new([0,1,0],[atk, rel], [1, -1]), doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
	Out.ar(0, sig);
}).add;

)
(
p = Pbind(
	\instrument, \sine,
	\dur, Pseq([0.6,1.2,1.2,1.2,0.6,0.6], inf).trace,
	\freq, Pseq([110,220,110,110], inf).trace
).play
)

(
a = Pbind(
	\instrument, \sine,
	\dur, Pseq([1.2, 1.2, 2.4, 1.2], inf),
	\freq, Pseq([20,30,40], inf),
	\amp, 0.5
).play
)


p.stop;