var env, sig, wt, numSegs;

b = Buffer.alloc(s, 2048);

//env = Env([0,0.6,-0.9,0.3,0], [4,3,2,1], {rrand(-20,20)}!4);

numSegs = rrand(10,20);
env = Env(
	{rrand(-1.0, 1.0)}!(numSegs + 1),
	{exprand(1,20)}!numSegs,
	{rrand(-20,20)}!numSegs
);


sig = env.asSignal(1024);
wt = sig.asWavetable;
b.loadCollection(wt);


b.plot;

{Osc.ar(b, MouseX.kr(10, 10000, 1), mul:0.2!2)}.play;