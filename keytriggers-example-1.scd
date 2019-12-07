w = Window.new("timer", Rect(0, 0, 70, 70));

w.view.keyDownAction_({ arg view, char;

    if(char == $a, {
        w.background_(Color.black);
        // UI events need to be on AppClock not SystemClock
        AppClock.sched(3, {
            w.background_(Color.red);
            postln ("boom");
            nil // returning nil prevents rescheduling
        });

        postln("started timer");
    });

    if(char == $z, {
        AppClock.clear;
        postln("cancelled timer");
    });

});

w.front;