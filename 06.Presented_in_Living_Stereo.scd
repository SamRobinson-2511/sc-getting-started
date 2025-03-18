{[SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)]}.play;

// Arrays
a = ["foo", "bar"];
a.at(0);
a.at(1);
a.at(2);

a[0];

{SinOsc.ar([440, 442], 0, 0.2)}.play;


(
{
	var freq;
	freq = [[660, 880], [440, 660], 1320, 880].choose;
	SinOsc.ar(freq, 0, 0.2);
}.play;
)

//Pan2.ar
{Pan2.ar(PinkNoise.ar(0.2), SinOsc.kr(0.5))}.play;
{Pan2.ar(PinkNoise.ar(0.2), -0.3)}.play;