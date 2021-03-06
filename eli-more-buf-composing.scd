(
SynthDef(\bufferThing, {
	arg atk=1.0, sus=1.0, rel=1.0, buf=0, rate=1, pos=0, freq=400, rq, bpfmix=0, pan=0, amp=1, out=0, c1=0, c2=0;
	var sig, env;
	env = EnvGen.kr(Env.new([0, 1, 1, 0],[atk, sus, rel],[c1, 0, c2]), doneAction:2);
	sig = PlayBuf.ar(1, buf, rate*BufRateScale.kr(buf), startPos:pos);
	sig = XFade2.ar(sig, BPF.ar(sig, freq, rq, 1/rq.sqrt), bpfmix*2-1);
	sig = sig*env;
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(out, sig);

}).add;
)


(
SynthDef(\reverb, {
	arg in, predelay=0.1, revTime = 1.8, lpf=4500, mix=0.15, amp=1, out=0;
	var dry, wet, temp, sig;
	dry = In.ar(in, 2);
	temp = In.ar(in, 2);
	wet = 0;
	temp = DelayN.ar(temp, 0, 2, predelay);
	16.do{
		temp = AllpassN.ar(temp, 0.05, {Rand(0.001, 0.05)}!2, revTime);
			temp = LPF.ar(temp, lpf);
			wet = wet + temp;
		};
		sig = XFade2.ar(dry, wet, mix*2-1, amp);
		Out.ar(out, sig);
}).add;
)





//b.add(\ ->
(

b = Dictionary.new;
PathName("/home/df/sc-sounds/").entries.do{
	arg subfolder;
	b.add(
		subfolder.folderName.asSymbol ->
		Array.fill(
			subfolder.entries.size,
			{
				arg i;
				Buffer.read(s,subfolder.entries[i].fullPath);
			}
		)
	)
};

)


(

//Routine.new(

rrand(4,10).do{
	Synth(
		\bufferThing,
		[
			\buf, b[\op2018stems][[4,5,6,7,8].choose],
			\atk, exprand(2,3),
			\sus, 1,
			\rel, exprand(2,3),
			\bpfmix, 1,
			\freq, (Scale.lydian.degrees+69).choose.midicps * [0.25,0.5].choose,
			\rq, exprand(0.001, 0.008),
			\rate, exprand(0.6, 1.2),
			\pan, rrand(-0.5,0.5),
			\amp, exprand(2,4),
		]
	)
};
)



~reverbBus = Bus.audio(s, 2);

~reverbSynth = Synth(\reverb, [\in, ~reverbBus]);
~reverbSynth.set(\revTime, 20.0);
~reverbSynth.set(\mix, 0.9);