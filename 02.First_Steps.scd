s.quit;
s.boot;

"Hello World!".postln;

"Hello there, I'm SuperCollider!".postln;
"Hello World!".postln;

(
"Call me,".postln;
"Ishmael.".postln;
)

(
"Call me?".postln;
"Ishmael.".postln;
)

//The World According to SuperCollider
//How to Use the Interpreter
s.boot;

{ FSinOsc.ar(800, 0, 0.1)}.play;

(
w = Window.new("Fading").front;
r = Routine({
	200.do({|i|
		w.view.background = Color.blue(val: 1, alpha: 1 - (i*0.005));
		0.005.wait;
	});
	w.close;
});
AppClock.play(r);
)


(
play({
// Three patches in one...
n = 5;    // number of strings
b = [    // array of possible impulse excitation behaviours
        { Impulse.ar(2 + 0.2.rand, 0.3) }, // slow phasing
        { Dust.ar(0.5, 0.3) },    // "wind chimes"
        { Impulse.ar(SinOsc.kr(0.05+0.1.rand, 2pi.rand, 5, 5.2), 0.3) } // races
    ].choose;    // choose one at random to use for all voices
Mix.new(
    Array.fill(n, {    // n strings tuned randomly to MIDI keys 60-90
        var delayTime;
        // calculate delay based on a random note
        delayTime = 1 / (60 + 30.rand).midicps;
        Pan2.ar(
            LeakDC.ar(    // removes DC buildup
                CombL.ar(    // used as a string resonator
                    Decay.ar(    // decaying envelope for noise
                        b.value,// instantiate an exciter
                        0.04,    // decay time of excitation
                        PinkNoise.ar(0.2)),// multiply noise by envelope
                    delayTime,     // max delay time
                    delayTime,    // actual delay time
                    4)),         // decay time of string
            1.0.rand2 // random pan position
        )
    }))
})
)

//Literals

//build a table of note names
(
var table = ();
value {
	var semitones = [0, 2, 4, 5, 7, 9, 11];
	var naturalNoteNames = ["c", "d", "e", "f", "g", "a", "b"];

	(0..9).do{|o|
		naturalNoteNames.do{|c, i|
			var n = (o + 1) * 12 + semitones[i];
			table[(c ++ o).asSymbol] = n;
			table[(c ++ "s" ++ o).asSymbol] = n + 1;
			table[(c ++ "ss" ++ o).asSymbol] = n + 2;
			table[(c ++ "b" ++ o).asSymbol] = n - 1;
			table[(c ++ "bb" ++ o).asSymbol] = n - 2;
		};
	};
};

table.atAll(#[c4, e4, gs4, c5, e5, gs5, c6]);
)


























