
(
SynthDef(\bpfSaw, {
	arg freq=500, atk=3, sus=0, rel=3, c1=1, c2=(-1), cf=1500, rq=0.2, amp=1, out = 0, detune = 0.2, cfmin=1800, cfmax=2000, cfhzmin=0.1, cfhzmax=0.3, rqmin=0.01, rqmax=0.2, pan=0, lsf=200, ldb=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk, sus, rel],[c1, 0, c2]), doneAction: 2);
	sig  = Saw.ar(freq * LFNoise1.kr(0.5, detune).midiratio);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin, cfhzmax)
		).exprange(cfmin, cfmax)}!2,
		{LFNoise1.kr(0.4).exprange(rqmin, rqmax)}!2
	);
	sig = BLowShelf.ar(sig, lsf, 0.5, ldb);
	//sig = Decay2.ar(sig, 0.5,0.6);

	sig = DelayL.ar(sig, 1.0, 0.1);
	sig = FreeVerb.ar(sig, 0.3, 0.99, 0.001);
	sig = Pan2.ar(sig, pan);
	sig = sig * env *amp;
	Out.ar(out, sig);

}).add;
)


(
Pbind(
	\instrument, \bpfSaw,
	\dur, Pexprand(0.5, 4.0, inf),
	\freq, Pexprand(10, 15, 120),
	\detune, 0.2,
	\atk, Pexprand(0.1,2.0),
	\rel, Pexprand(0.1,2.0),
	\cfmin, Prand((Scale.major.degrees+50).midicps*2, inf) * Prand([0.5, 1.0, 4], inf),
	\cfmax, Pkey(\cfmin),
	\amp, Pexprand(0.5,2.0),
	\rqmin, 0.002,
	\rqmax, 0.005,
	\pan, Pexprand(-1.0,1.0),
	\out, 0

).play;

Pbind(
	\instrument, \bpfSaw,
	\dur, Pexprand(0.1, 4.0, inf),
	\freq, Pexprand(5, 25, 120),
	\detune, 0.2,
	\atk, Pexprand(0.1,4.0),
	\rel, Pexprand(0.1,4.0),
	\cfmin, Prand((Scale.major.degrees+50).midicps, inf),
	\cfmax, Pkey(\cfmin) * Pwhite(1.0001,1.002, inf),
	\amp, Pexprand(0.5,2.0),
	\rqmin, 0.002,
	\rqmax, 0.005,
    \pan, Pexprand(-1.0,1.0),
	\out, 0

).play;


)


