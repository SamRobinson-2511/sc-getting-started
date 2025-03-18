{SinOsc.ar(440, 0, 0.2)}.play;

(
{
	SinOsc.ar(
		440, //440 hz
		0, //initial phase
		0.2//mul
	)
}.play;
)

//Polymorphism
(
{
	var ampOsc;
	ampOsc = SinOsc.kr(0.5, 1.5pi, 0.5, 0.5);
	SinOsc.ar(440, 0, ampOsc);
}.play;
)

// Functions: lambda expressions

/*{arg a, b, c; var d; d = a*b; c+d}*/

f = {arg a, b; a+b};
f.value(4,5).postln;
f.value(10, 200).postln;

{}.value.postln;

//Arguments

{arg a, b, c=3;}
//is equivalent to
{|a, b, c=3|}

{arg x = "stop", y, z=0;} //initialized args
{arg a, b, c ...d;} //any args after the first 3 will be assigned to d as an Array

{arg a = Array.geom(4, 100, 3); a*4}.value; //this is ok

{arg freq = Array.geom(4, 100, 3); Mix(SinOsc.ar(freq, 0, 0.1))}.play; //silence

{arg freq = #[100, 300, 900, 2700]; Mix(SinOsc.ar(freq, 0, 0.1))}.play; //args must be initialized on literals

//Literal Argument Defaults
f = {arg x = 1; x};
f.value(2);
f.value;
f.value(nil);

//Expression Argument Defaults
f = {arg x = 10.rand; x};
f.value(100);
f.value;
f.value(nil); //use expression style to define a default that cannot be overwritten by nil

f = {arg x = (3); x}; //parentheses are required when initializing an argument to an expression if the arg list is written in ||
f.value(nil);

(
var abc = 2;
{arg x = abc+1;x}
)

//error
(
var abc = 2;
{|x = abc+1|x}
)

//OK
(
var abc = 2;
{|x = (abc+1)|x}
)

//= can be omitted if () are there
(
var abc = 2;
{|x(abc+1)|x}
)

//Identical
{arg x = 10.rand; x};
(
{arg x;
	x ?? {x = 10.rand };
	x
}
)

//Variables
var level = 0, slope = 1, curve = 1;


//Function
//example

(
var a, b, c;
a = {[100, 200, 300].choose};
b = {10.rand + 1};
c = a + b;
c.value.postln;
)

//returning first argument itself
{|x| x}.value(1); //SuperCollider
[:x|x]value:1; //Smalltalk
((lambda(x)x)1); //Lisp













