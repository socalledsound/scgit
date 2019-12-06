TempoClock.default.tempo = 1;

(
SynthDef.new(\sine, {
	arg freq=440, atk = 0.005, rel = 0.3, amp = 1, pan = 0;
	var sig, env;
	sig = SinOsc.ar(freq);
	sig = Resonz.ar(sig, freq * 2);
	env = EnvGen.kr(Env.new([0,1,0],[atk, rel], [1, -1]), doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
	Out.ar(0, sig);
}).add;

)

(
SynthDef.new(\sineRes, {
	arg freq=440, atk = 0.005, rel = 0.3, amp = 1, pan = 0;
	var sig, env;
	sig = SinOsc.ar(freq);
	sig = Resonz.ar(sig, freq * 2);
	env = EnvGen.kr(Env.new([0,1,0],[atk, rel], [1, -1]), doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
	sig = sig + FreeVerb.ar(sig);
	Out.ar(0, sig);
}).add;

)


(

)
(

	~lowStart = Pbind(
	\instrument, \sine,
	\dur, Pwhite(0.05, 0.5, inf),
	\freq, Pexprand(20, 200, 100),
	\atk, Pwhite(30.0, 60.0, inf),
	\rel, Pwhite(30.0, 60.0, inf),
	\amp, Pexprand(0.01, 0.1, inf),
	\pan, Pwhite(-0.8, 0.8, inf),
);

   ~hiTin = Pbind(
	\instrument, \sineRes,
	\dur, Pwhite(0.05, 0.5, inf),
	\freq, Pexprand(6000, 12000, 20),
	\atk, Pwhite(10.0, 20.0, inf),
	\rel, Pwhite(10.0, 20.0, inf),
	\amp, Pexprand(0.001, 0.01, inf),
	\pan, Pwhite(-0.8, 0.8, inf),
);

~medTones = Pbind(
	\instrument, \sineRes,
	\dur, Pwhite(0.05, 0.5, inf),
	\freq, Pexprand(600, 6600, 20),
	\atk, Pwhite(10.0, 20.0, inf),
	\rel, Pwhite(10.0, 20.0, inf),
	\amp, Pexprand(0.001, 0.01, inf),
	\pan, Pwhite(-0.8, 0.8, inf),
);

~narrowMed = Pbind(
	\instrument, \sineRes,
	\dur, Pwhite(0.05, 0.5, inf),
	\freq, Pexprand(600, 800, 20),
	\atk, Pwhite(10.0, 20.0, inf),
	\rel, Pwhite(10.0, 20.0, inf),
	\amp, Pexprand(0.001, 0.01, inf),
	\pan, Pwhite(-0.8, 0.8, inf),
);



Routine{


	fork{
		75.wait;
		fork{
			30.wait;
			4.do{
			~narrowMed.play;
			~medTones.play;
				rrand(45,60).wait;

			};
		};
		6.do{
			~hiTin.play;
			30.wait;

		};
	};

	3.do{
		~lowStart.play;
		postln("hi");

		50.wait;
	}


}.play;
)



(
a = Pbind(
	\instrument, \sineRes,
	\dur, Pwhite(0.05, 0.5, inf),
	\freq, Pexprand(600, 6600, 20),
	\atk, Pwhite(10.0, 20.0, inf),
	\rel, Pwhite(10.0, 20.0, inf),
	\amp, Pexprand(0.001, 0.01, inf),
	\pan, Pwhite(-0.8, 0.8, inf),
).play;
)


(
a = Pbind(
	\instrument, \sineRes,
	\dur, Pwhite(0.05, 0.5, inf),
	\freq, Pexprand(600, 800, 20),
	\atk, Pwhite(10.0, 20.0, inf),
	\rel, Pwhite(10.0, 20.0, inf),
	\amp, Pexprand(0.001, 0.01, inf),
	\pan, Pwhite(-0.8, 0.8, inf),
).play;
)



(
a = Pbind(
	\instrument, \sineRes,
	\dur, Pwhite(0.05, 0.5, inf),
	\freq, Pexprand(6000, 12000, 20),
	\atk, Pwhite(10.0, 20.0, inf),
	\rel, Pwhite(10.0, 20.0, inf),
	\amp, Pexprand(0.001, 0.01, inf),
	\pan, Pwhite(-0.8, 0.8, inf),
).play;
)



