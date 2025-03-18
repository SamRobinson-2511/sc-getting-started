//byte code

{SinOsc.ar(440, 0, 0.2)}.play;

SynthDef.new("tutorial-SinOsc", {|out| Out.ar(out, SinOsc.ar(440, 0, 0.2))}).play;

//SynthDef versus Functions
//Out
(
SynthDef.new("tutorial-SinOsc-stereo", {
	|out|
	var outArray;
	outArray = [SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)];
	Out.ar(out, outArray)
}).play;
)

x = {SinOsc.ar(660, 0, 0.2)}.play;
y = SynthDef.new("tutorial-SinOsc", { |out| Out.ar(out, SinOsc.ar(440, 0, 0.2)) }).play;
x.free;
y.free;

SynthDef.new("tutorial-PinkNoise", {|out| Out.ar(out, PinkNoise.ar(0.3))}).add;
x = Synth.new("tutorial-PinkNoise");
y = Synth.new("tutorial-PinkNoise");
x.free; y.free;

//randomness with function
f = { SinOsc.ar(440 + 200.rand, 0, 0.2)};
x = f.play;
y = f.play;
z = f.play;
x.free; y.free; z.free;

//no randomness with SynthDef
(
SynthDef("tutorial-NoRand", {
	|out|
	Out.ar(out, SinOsc.ar(440 + 200.rand, 0, 0.2))
}).add;
)

x = Synth("tutorial-NoRand");
y = Synth("tutorial-NoRand");
z = Synth("tutorial-NoRand");
x.free; y.free; z.free;


//Creating variety with SynthDefs
//Rand it works
SynthDef("tutorial-Rand", {|out| Out.ar(out, SinOsc.ar(Rand(440, 660), 0, 0.2))}).add;
x = Synth("tutorial-Rand");
y = Synth("tutorial-Rand");
z = Synth("tutorial-Rand");
x.free; y.free; z.free;


//using args in the UGen Graph Function
(
SynthDef("tutorial-args", {
	|freq=440, out=0|
	Out.ar(out, SinOsc.ar(freq, 0, 0.2))
}).add;
)
x = Synth("tutorial-args");
y = Synth("tutorial-args", ["freq", 660]);
z = Synth("tutorial-args", ["freq", "out", 1]);
x.free; y.free; z.free;


//More about synth
(
SynthDef("tutorial-args", {
	|freq=440, out=0|
	Out.ar(out, SinOsc.ar(freq, 0, 0.2))
}).add;
)
s.scope;
x = Synth.new("tutorial-args");
x.set("freq", 660);
x.set("freq", 880, "out", 1);
x.free;

//Some notes on symbols strings synthdef and arg names
"a String" === "a String" //false
\aSymbol === 'aSymbol'//true
"this" === \this //false








