SynthDef(\bufferThing, {
	arg atk=1.0, sus=1.0, rel=1.0, buf=0, rate=1, pos=0, freq=400, rq, bpfmix=0, pan=0, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env.new([0, 1, 1, 0],[atk, sus, rel],[c1, 0, c2]), doneAction:2);
	sig = PlayBuf.ar(1, buf, rate*BufRateScale.kr(buf), startPos:pos);
	sig = XFade2.ar(sig, BPF.ar(sig, freq, rq, 1/rq.sqrt), bpfmix*2-1);
	sig = sig*env;
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(out, sig);

}).add;


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



b[\op2018stems][0].play;
