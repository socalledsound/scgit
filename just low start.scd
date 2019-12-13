(
~lowStart1 = Routine({
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
				\detune, exprand(0.01, 0.1),
			    \pan, rrand(-1.0, 1.0);
			]
		);
	};
});
)

(

Routine.run({


~lowStart1.play;


});

)