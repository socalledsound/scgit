(
SynthDef.new(\wavey, {
	arg freq=200;
	var temp, sum, env;

	sum = 0;
	env = EnvGen.kr(Env.perc(0.01, 5, 1, -2), doneAction:2);
	10.do{
		arg x, i;
		temp = VarSaw.ar(freq*LFNoise1.kr({Rand(0.001, 0.001)}!2).exprange(2.1,2.0), 0 + i/10, {ExpRand(0.005,0.05)}!2);
		sum = sum + temp;
	};
	sum = sum * 0.05 * env;
//	sum = BLowShelf.ar(sum, 100, 1,-24);
	Out.ar(0, sum);
}).add;
)
(
Routine.run({
10.do{arg x, i;
		Synth.new(\wavey,[freq: 200]);
0.1.wait;
}
})
)