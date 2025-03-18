{[SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)]}.play;

f = {"Function Evaluated"}.postln;
f;

(
f = {
	"Starting Function Evaluation".postln;
	"Finishing Function Evaluation".postln;
};
)
f;

f = {"Function Evaluated".postln};
f.value;
f.value;
f.value;

(
f = {
	"Evaluating...".postln;
	2 + 3
};
f.value;
)

f = 3;
f.value;
f.value;

f = {3.0.rand};
f.value;
f.value;
f.value;


(
f = {arg a, b;
	a - b
};
f.value(5, 3);
)

(
f = {arg a, b;
	a / b
};
f.value(10, 2);
f.value(b:2, a:10);
)

(
f = {
	arg a, b, c, d;
	(a+b)*c-d
};
f.value(2, c:3, b:4, d:1);
)

(
f = {
	arg a, b=2;
	a+b
};
f.value(2);
)

(
f = {
	arg a, b;
	a + b
};
g = {
	|a, b|
	a + b
};
f.value(2, 2);
g.value(2,2);
)

(
f = {
	arg a, b;
	var firstResult, finalResult;
	firstResult = a + b;
	finalResult = firstResult * 2;
	finalResult
};
f.value(2,3);
)

//Scope
(
f = {
	var foo;
	foo = 3;
	foo
};
f.value;
foo; //error
)

(
var myFunc;
myFunc = {|input| input.postln};
myFunc.value("foo");
myFunc.value("bar");
)
myFunc; //error

(
f = {
	arg a;
	a.value + 3;
};
)
f.value(3);
g = { 3.0.rand };
f.value(g);
f.value(g);























































