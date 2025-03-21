//Groups as Ordering Tools
g = Group.new;
h = Group.before(g);
g.free; h.free;

(
SynthDef(\tutorial_DecaySin2, {
	|outBus = 0, effectBus, direct=0.5, freq=440|
	var source;
	source  = Pan2.ar(Decay2.ar(Impulse.ar(Rand(0.3,1), 0, 0.125), 0.3, 1,
		SinOsc.ar(SinOsc.kr(0.2, 0, 110, freq))), Rand(-1.0, 1.0));
	Out.ar(outBus, source * direct);
	Out.ar(effectBus, source * (1 - direct));
}).add;

SynthDef(\tutorial_Reverb2, {
	|outBus=0, inBus|
	var input;
	input = In.ar(inBus, 2);
	16.do({ input = AllpassC.ar(input, 0.04, Rand(0.001, 0.04), 3)});
	Out.ar(outBus, input);
}).add;
)

(
~sources = Group.new;
~effects = Group.after(~sources);
~bus = Bus.audio(s, 2);
)

(
x = Synth(\tutorial_Reverb2, [\inBus, ~bus], ~effects);
y = Synth(\tutorial_DecaySin2, [\effectBus, ~bus, \outBus, 0], ~sources);
z = Synth(\tutorial_DecaySin2, [\effectBus, ~bus, \outBus, 0, \freq, 660], ~sources);
)

~sources.free; ~effects.free;
~bus.free;

Environment.new.push;
currentEnvironment.pop;

//All the addActions
g = Group.new;
h = Group.head(g); //add h to the head of g
x = Synth.tail(h, \default); //add x to the tail of h
s.queryAllNodes;
x.free; h.free; g.free;


//'queryAllNodes' and node IDs


//The Root Node and the Default Group
s.boot;
a = Synth(\default);
a.group;

{SinOsc.ar(mul: 0.2)}.scope(1);
s.queryAllNodes;

//Groups as, well, groups . . .
g = Group.new;
//make 4 synths in g
//1.0.rand2 returns a random number from -1 to 1
4.do({ { arg amp = 0.1; Pan2.ar(SinOsc.ar(440 + 110.rand, 0, amp), 1.0.rand2) }.play(g); });
g.set(\amp, 0.005);
g.free;

Group.superclass;
Group.superclass.help;
Group.findRespondingMethodFor('set');
Group.findRespondingMethodFor('postln');
Group.helpFileForMethod('postln');













