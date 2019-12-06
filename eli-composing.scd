(
SynthDef(\bpfSin, {
	arg freq=500, atk=3, sus=0, rel=3, c1=1, c2=(-1), cf=1500, rq=0.2, amp=1, out = 0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk, sus, rel],[c1, 0, c2]), doneAction: 2);
	sig  = SinOsc.ar(freq);
	sig = BPF.ar(sig, cf, rq);
	sig = sig * env *amp;
	Out.ar(out, sig);

}).add;

)


(
SynthDef(\bpfSinDeTune, {
	arg freq=500, atk=3, sus=0, rel=3, c1=1, c2=(-1), cf=1500, rq=0.2, amp=1, out = 0, detune = 0.2, cfmin=1800, cfmax=2000, rqmin=0.01, rqmax=0.2, pan=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk, sus, rel],[c1, 0, c2]), doneAction: 2);
	sig  = SinOsc.ar(freq * LFNoise1.kr(0.5, detune).midiratio);
	sig = BPF.ar(
		sig,
		LFNoise1.kr(0.2).exprange(cfmin, cfmax),
		LFNoise1.kr(0.4).exprange(rqmin, rqmax)
	);
	sig = Pan2.ar(sig, pan);
	sig = sig * env *amp;
	Out.ar(out, sig);

}).add;
)


(
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



(
SynthDef(\bpfSinDeTune3, {
	arg freq=500, atk=3, sus=0, rel=3, c1=1, c2=(-1), cf=1500, rq=0.2, amp=1, out = 0, detune = 0.2, cfmin=1800, cfmax=2000, cfhzmin=0.1, cfhzmax=0.3, rqmin=0.01, rqmax=0.2, pan=0, lsf=200, ldb=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk, sus, rel],[c1, 0, c2]), doneAction: 2);
	sig  = SinOsc.ar(freq * LFNoise1.kr(0.5, detune).midiratio);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin, cfhzmax)
		).exprange(cfmin, cfmax)}!2,
		{LFNoise1.kr(0.4).exprange(rqmin, rqmax)}!2
	);
	sig = BLowShelf.ar(sig, lsf, 0.5, ldb);
	sig = Pan2.ar(sig, pan);
	sig = sig * env *amp;
	Out.ar(out, sig);

}).add;
)




//Synth(\bpfEli, [\freq, 200]);


(
[58,63,67,72].midicps.do{
	arg f;
	Synth(
		\bpfSin,
		[
			\freq, f,
			\amp, 0.125,
			\cf, f * exprand(1,12),
			\rq, exprand(0.01, 0.5)
		]
	);
};
)


(
12.do{
	Synth(
		\bpfSin,
		[
			\freq, exprand(100,12000),
			\amp, 0.125,
			\cf, exprand(20, 6000),
			\rq, exprand(0.01, 0.5)
		]
	);
};
)

(
12.do{
	Synth(
		\bpfSin,
		[
			\freq, (Scale.major.degrees * 32).choose,
			\amp, 0.3,
			\cf, exprand(20, 6000),
			\rq, exprand(0.01, 0.5)
		]
	);
};
)



(
10..20.do{
	Synth(
		\bpfSin,
		[
			\freq, (Scale.major.degrees * 32).choose,
			\amp, 0.3,
			\cf, exprand(20, 6000),
			\rq, exprand(0.01, 0.5)
		]
	);
};
)

(
	10..20.do{
		Synth(
			\bpfSinDeTune,
			[
				\freq, (Scale.major.degrees + 60).midicps.choose,
				\amp, 0.35,
				\atk, exprand(10.0, 20.0),
				\rel, exprand(10.0, 20.0),
				\cf, exprand(10000, 14000),
				\rq, exprand(0.01, 0.5),
				\detune, exprand(0.01, 0.1)
			]
		);
	};
)



(
	10..20.do{
	var freq = [50,62,75].choose;
		Synth(
			\bpfSinDeTune,
			[
				\freq, freq*8,
				\amp, 0.05,
				\atk, exprand(1.0, 2.0),
				\rel, exprand(10.0, 20.0),
				\cfmin, freq*2,
			    \cfmax, freq*10,
				\rqmin, 0.01,
		        \rqmax, 0.1,
				\detune, exprand(0.01, 0.1),
			    \pan, rrand(-1.0, 1.0);
			]
		);
	};
)




(
	10..20.do{
	var f = 50;
	//var freq = [f, f*2, f*3].choose;
	var freq = [f,f*1.25,f*1.5].choose;
	//freq = [50,62,75].choose;
	 //freq = [25,50,100].choose;
	//freq = [32.5,65,130].choose;
	//freq = [4
	  Synth(
			\bpfSinDeTune,
			[
				\freq, freq*8/2,
				\amp, 0.05,
				\atk, exprand(10.0, 20.0),
				\rel, exprand(10.0, 20.0),
				\cfmin, freq*2,
			    \cfmax, freq*10,
			    \cfhzmin, 0.1,
			    \cfhzmax, 1,
				\rqmin, 0.01,
		        \rqmax, 0.1,
				\detune, exprand(0.01, 0.1),
			    \pan, rrand(-1.0, 1.0),
			    \ldb, 0
			]
		);
	};
)



(
	10..20.do{
	var f = 50;
	var freq = [f, f*2, f*3].choose;
	//var freq = [f,f*1.25,f*1.5].choose;
	//freq = [50,62,75].choose;
	 //freq = [25,50,100].choose;
	//freq = [32.5,65,130].choose;
	//freq = [4
	  Synth(
			\bpfSinDeTune,
			[
				\freq, freq*8/2,
				\amp, 0.05,
				\atk, exprand(10.0, 20.0),
				\rel, exprand(10.0, 20.0),
				\cfmin, freq*2,
			    \cfmax, freq*10,
			    \cfhzmin, 0.1,
			    \cfhzmax, 1,
				\rqmin, 0.01,
		        \rqmax, 0.1,
				\detune, exprand(0.01, 0.1),
			    \pan, rrand(-1.0, 1.0),
			    \ldb, 0
			]
		);
	};
)






(
	10..20.do{
	var freq;
	freq = [50, 62, 75].choose;
	// freq = [25,50,100].choose;
	//freq = [55,67,82].choose;

	  Synth(
			\bpfSinDeTune,
			[
				\freq, freq*8/4,
				\amp, 0.2,
				\atk, exprand(10.0, 20.0),
				\rel, exprand(10.0, 20.0),
				\cfmin, freq*2,
			    \cfmax, freq*10,
			    \cfhzmin, 0.1,
			    \cfhzmax, 1,
				\rqmin, 0.01,
		        \rqmax, 0.1,
				\detune, exprand(0.01, 0.1),
			    \pan, rrand(-1.0, 1.0),
			    \ldb, 2
			]
		);
	};
)


(
  Pbind(
	\instrument, \bpfSinDeTune3,
	\dur, 4,
	\midinote, Pseq(
		[12,25,50],
		[50,25,100],
		[50,62,75],
		10),
\detune, 0.2,
\cmin, 10000,
\cmax, 15000,
\atk, 1,
	\rel, exprand(1,8),
\ldb, 6,
\amp, 0.4,
\out, 0

).play;

)



