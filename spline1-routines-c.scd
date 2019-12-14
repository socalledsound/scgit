/////////
//
//
//  spline 1 routines
//
//
/////////////////////////



(

~lowStart1 = Routine({
	var freq = [50,62,75].choose;


	rrand(10,20).do{

		Synth(
			\bpfSinDeTune2,
			[
				\freq, freq*8/8,
			    \amp, exprand(0.05, 0.3),
				\atk, exprand(10.0, 20.0),
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
});

~lowStart2_beats = Routine({
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
				\detune, exprand(0.01, 1.0),
			    \pan, rrand(-1.0, 1.0);
			]
		);
	};
});


~lowStart3_div4_clean = Routine({
	var freq = [50,62,75].choose;


	rrand(10,20).do{

		Synth(
			\bpfSinDeTune2,
			[
				\freq, freq*8/4,
			    \amp, exprand(0.01, 0.1),
				\atk, exprand(10.0, 20.0),
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
});

~lowStart3_div4_beats = Routine({
	var freq = [50,62,75].choose;


	rrand(10,20).do{

		Synth(
			\bpfSinDeTune2,
			[
				\freq, freq*8/4,
			    \amp, exprand(0.01, 0.1),
				\atk, exprand(10.0, 20.0),
				\rel, exprand(10.0, 20.0),
				\cfmin, freq*2,
			    \cfmax, freq*10,
				\rqmin, 0.01,
		        \rqmax, 0.1,
				\detune, exprand(0.01, 1.0),
			    \pan, rrand(-1.0, 1.0);
			]
		);
	};
});


~lowStart3_div2_clean = Routine({
	var freq = [50,62,75].choose;


	rrand(10,20).do{

		Synth(
			\bpfSinDeTune2,
			[
				\freq, freq*8/2,
			    \amp, exprand(0.01, 0.05),
				\atk, exprand(10.0, 20.0),
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
});

~lowStart3_div2_beats = Routine({
	var freq = [50,62,75].choose;


	rrand(10,20).do{

		Synth(
			\bpfSinDeTune2,
			[
				\freq, freq*8/2,
			    \amp, exprand(0.01, 0.05),
				\atk, exprand(10.0, 20.0),
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
});



~sevenLow = Routine({
var i=1;
	10.do{
		Pbind(
			\instrument, \bpfSawEQ,
			//\dur, Pseq([Pexprand(0.1, 4.0, 1), Pexprand(4.0, 8.0, 5)], inf),
			\dur, Pseq([1.0]++(0.5!12),inf),
//			\freq, Pexprand(50*2,50, 120),
			\freq,Pseq([[25,50,100,200,400, 800].choose!2,[25,62/2, 50, 62, 100, 62*2,200,62*4,400,62*8, 800,62*16].choose], inf),
			\detune, 0.1,
			\centerVal, Pexprand(8000,10000, inf),
			\atk, Pexprand(3.0,1.0, inf),
			\rel, Pexprand(3.0,1.0, inf),
			//\cfmin, Pexprand(40000, 80000, inf),
			\cfmin, Pseq([([25, 100, 200, 400].choose), 50],inf),
			\cfmax, Pkey(\cfmin) * Pwhite(1.0001,1.5, inf),
			\amp, Pexprand(0.5,0.8) * 40,
			\rqmin, 0.0002,
			\rqmax, 0.0005,
			\pan, Pexprand(-1.0,1.0),
			\out, 0

		).play;
		i=i*1.618;
		i.postln;
		(rrand(0.1,0.5)).wait;
	}
});


~sawTones4 =
Routine({
var i=1;
	/*	Pbind(
		\instrument, \bpfSawEQ,
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
	*/


	12.do{
		Pbind(
			\instrument, \bpfSawEQ,
			\dur, Pexprand(0.1, 4.0, inf),
			\freq, Pexprand(5, 25, 120),
			\detune, 0.2,
			\atk, Pexprand(0.1,4.0),
			\rel, Pexprand(0.1,4.0),
			\cfmin, Prand([50,62,75]*16*(i), inf),
			\cfmax, Pkey(\cfmin) * Pwhite(1.0001,1.002, inf),
			\amp, Pexprand(0.5,0.8)*20,
			\rqmin, 0.00002,
			\rqmax, 0.00005,
			\pan, Pexprand(-1.0,1.0),
			\out, 0

		).play;
		i=i*1.6;
		i.postln;
		(0.5).wait;
	}
});



~risingSaws = Routine({
	var j = 0;
Pbind(
	\instrument, \bpfSawEQ,
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

6.do{
10.do{var i=1;
Pbind(
	\instrument, \bpfSawEQ,
	\dur, Pexprand(0.1, 4.0, inf),
	\freq, Pexprand(5, 25, 120),
	\detune, 0.2,
	\atk, Pexprand(0.1,4.0),
	\rel, Pexprand(0.1,4.0),
			\cfmin, Prand([50,62,75]*(8+j)*(i+1), inf),
	\cfmax, Pkey(\cfmin) * Pwhite(1.0001,1.002, inf),
	\amp, Pexprand(0.5,0.8)*50,
	\rqmin, 0.00002,
	\rqmax, 0.00005,
    \pan, Pexprand(-1.0,1.0),
	\out, 0

).play;
	i=i+1;
	3.wait;
};
		j = j + 1;
	    j.postln;
		rrand(3,10).wait;
	}
});






Routine.run({

1.wait;
/*~sawTones4.play;
rrand(5,15).wait;
~lowStart1.play;
~lowStart2_beats.play;
~lowStart3_div4_beats.play;*/
~sevenLow.play;
rrand(5,15).wait;
/*~lowStart1.play;
~lowStart2_beats.play;
~lowStart3_div4_beats.play;*/
~risingSaws.play;
})
)