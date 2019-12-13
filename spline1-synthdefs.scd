

//synthdefs


(
SynthDef(\bpfSaw, {
	arg freq=500, atk=3, sus=0, rel=3, c1=1, c2=(-1), cf=1500, rq=0.2, amp=1, out = 0, detune = 0.2, cfmin=1800, cfmax=2000, cfhzmin=0.1, cfhzmax=0.3, rqmin=0.01, rqmax=0.2, pan=0, lsf=200, ldb=0;
	var sig, env, verb;
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





SynthDef(\bpfSawEQ, {
	arg freq=500, atk=3, sus=0, rel=3, c1=1, c2=(-1), cf=1500, rq=0.2, amp=1, out = ~reverbBus, detune = 0.2, cfmin=1800, cfmax=2000, cfhzmin=0.1, cfhzmax=0.3, rqmin=0.01, rqmax=0.2, pan=0, lsf=200, ldb=0, centerVal = 1000;
	var sig, env, verb;
	env = EnvGen.kr(Env([0,1,1,0],[atk, sus, rel],[c1, 0, c2]), doneAction: 2);
	sig  = Saw.ar(freq * LFNoise1.kr(0.5, detune).midiratio);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin, cfhzmax)
		).exprange(cfmin, cfmax)}!2,
		{LFNoise1.kr(0.4).exprange(rqmin, rqmax)}!2
	);

	sig = BPeakEQ.ar(sig, centerVal, 0.002, 12, 0.5);
	sig = BPeakEQ.ar(sig, centerVal-1000, 0.02, -12, 0.5);
	sig = BPeakEQ.ar(sig, centerVal+1000, 0.02, -12, 0.5);

	sig = BLowShelf.ar(sig, lsf, 0.5, ldb);
	//sig = Decay2.ar(sig, 0.5,0.6);

	//sig = DelayL.ar(sig, 1.0, 0.1);
	//sig = FreeVerb.ar(sig, 0.3, 0.99, 0.001);
	sig = Pan2.ar(sig, pan);
	sig = sig * env *amp;
	Out.ar(out, sig);

}).add;


SynthDef(\bpfSinDeTune2, {
	arg freq=500, atk=3, sus=0, rel=3, c1=1, c2=(-1), cf=1500, rq=0.2, amp=1, out = 0, detune = 0.2, cfmin=1800, cfmax=2000, rqmin=0.01, rqmax=0.2, pan=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk, sus, rel],[c1, 0, c2]), doneAction: 2);
	sig  = SinOsc.ar(freq * LFNoise1.kr(0.5, detune).midiratio);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(0.2).exprange(cfmin, cfmax)}!2,
			{LFNoise1.kr(0.4).exprange(rqmin, rqmax)}!2
	);
	sig = Pan2.ar(sig, pan);
	sig = sig * env *amp;
	Out.ar(out, sig);

}).add;


)

////////////////////////
//
///  routines
////
////
///////////////////////////////

~lowStart.play;

(
~lowStart = Routine({
	var freq = [50,62,75].choose;


	rrand(10,20).do{

		Synth(
			\bpfSinDeTune2,
			[
				\freq, freq*8/8,
			    \amp, exprand(0.01, 0.1),
				\atk, exprand(10.0, 20.0),
				\rel, exprand(10.0, 20.0),
				\cfmin, freq*2,
			    \cfmax, freq*10,
				\rqmin, 0.01,
		        \rqmax, 0.1,
				\detune, exprand(0.01, 0.2),
			    \pan, rrand(-1.0, 1.0);
			]
		);
	};
})
)
~lowStart.play;



(
Pbind(
	\instrument, \bpfSaw,
	\dur, Pexprand(0.5, 4.0, inf),
	\freq, Pexprand(10, 15, 120),
	\detune, 0.2,
	\atk, Pexprand(0.1,2.0),
	\rel, Pexprand(0.1,2.0),
	\cfmin, Prand([50,62,75]*4, inf) * Prand([0.5, 1.0, 4], inf),
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
	\cfmin, Prand([50,62,75]*4, inf),
	\cfmax, Pkey(\cfmin) * Pwhite(1.0001,1.002, inf),
	\amp, Pexprand(0.5,2.0),
	\rqmin, 0.002,
	\rqmax, 0.005,
    \pan, Pexprand(-1.0,1.0),
	\out, 0

).play;


)


