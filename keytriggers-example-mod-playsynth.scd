s.meter



(
SynthDef(\sinTest, {
	arg freq = 400;
	var sig;
	sig = SinOsc.ar(freq, 0, 1);
	Out.ar(0, sig);
}).add;
)






(





w = Window.new("play", Rect(0, 0, 70, 70));

w.view.keyDownAction_({ arg view, char;

    if(char == $a, {
 a=Synth(\sinTest);
    });

    if(char == $A, {
        a.free;
    });

});

w.front;

)