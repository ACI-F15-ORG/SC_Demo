//execute lines by holding shift and pressing return

// arithmetic
1 + 1;

// strings
"strings";

// all primitives are objects, executing them returns the object's value.
// we can use this to add function calls to the objects, such as printing
// to the console
"strings".postln;

// notice that the above example returns the value of the object, which is
// printed to the Post window, and the postln function also prints the
// string to the Post window

// variables are a little different in supercollider... SC pays strict
// attention to scope, as in other languages. However, SC enforces
// special syntax for different kinds of variables.

// at this scope, which is the file level or global scope, we must define
// and set variables in one of two ways: is using a single lowercase
// letter ranged a-z

a = 9;
a.postln;

// alphabetic letters are terrible for longterm use, since they don't
// describe anything. if we want to get a little more specific, we
// can use the other form, which is a ~ character followed by alpha-
// numeric characters of any case (as well as underscore)

~thisIsValid = 14;

~so_is_this = 3;

~me2 = 8;

// normal arithmetic with the variables we have set
~me2 + ~thisIsValid;

~so_is_this + a;

a + "random message";

// in the last example we did something funny. we added objects of
// two different types. certain operators are clever enough to figure
// out what you mean, but it also points out something the we didn't do
// before: define the variable type.

// another funny trick with these operations is the use of parentheses.
// from algebra, we know how parens are use to group operations and
// dictate their order of execution
5 * (4 + 1);

// but in SC, the parens can also be a fully-fledged object in themselves.
// check it out:
~parens = ();

// notice how the initialization returned an empty set of parens in the
// Post window? this is because we have actually set ~parens to an object
// type referred to in SC as an Event

// execute the following to see the documentation for the Event class:
Event.help;

// this quickly gets into some territory we're not quite ready for,
// but 99% of the time we'll be using parens to execute groups of code
// lines all at the same time. for this reason, i'm going to call them
// blocks, unless we have a good reason to call them something else
// later.

// the two ways to execute code groups are to highlight the parens and
// everything in between and press shift+return as we have been doing.

// otherwise, we can click anywhere within the top level parens and
// press cmd+return or ctrl+return
(
~thisIsValid * 9;
~me2 * 9;
)

// in the last example we only got one value back from the execution
// of the code block. this is because the block only returns the value
// from the last expression evaluated in the block.

// we can still post any lines we want, however, as well as mix and
// match parentheses levels:
(
"".postln;
(~thisIsValid * 9).postln;
(~me2 * 9).postln;
b = 13;
)

// back to variables - if you now execute 'b', you'll get the variable
// we set inside the block.
b;

// we don't usually want to flood the global variable space, so we
// use a different syntax for scoped variables:
(
var b, hakuna_matata;

b = 444;
b.postln;

hakuna_matata = 19;
hakuna_matata.postln;
)

// and if we execute our global b again:
b;

// a few notes: first, you can not have multiple var lines in a scope,
// or else you'll get a syntax error. bummer, but that's the way it is.
// plus, you have to put the var declarations on the first line.

// also, what the what? why not just use var declarations at all levels?
// well, that is because the 'var' keyword helps make certain that the
// variables you are using are differentiated from global scope and they
// are also destroyed immediately at the end of the scope they are contained
// within. this is the same as other languages, but SC is a quirky language
// that is frustratingly contradictory at times and chose to enforce this
// one thing syntactically. in the case of var declarations at the global
// scope, they actually return nil and are released right after definition,
// so you don't even get a chance to try to use them.

// but don't take levar burton's word for it:
var nachos = 99;
nachos.postln;

// it don't work.





// okay, basic syntactic stuff aside, why are we talking so much about the
// language to start, instead of making sound?

// well, first SC can be a bit of a chore to learn, since it does some things
// very flexibly and other things both highly idiosyncractically and very
// inflexibly.

// this is in part due to the structure of SC itself. there are in fact two
// different parts of SuperCollider. the first is 'sclang', which we have
// been getting to know. the second is 'scsynth'. within the IDE, or any other
// IDE (such as Sublime Text, EMACS, etc.) that has been setup to use sclang,
// we have the interpreting and parsing layer of the language. this means that
// sclang figures out what your SC code is supposed to do and transforms that
// code into different code that the program knows how to do.

// what is super weird about SC, however, is that the language that it is
// translating your code into is a strangely formatted TCP/UDP packet. the
// specific API for the implementation is Open Sound Control, or OSC.

// so if all of your sclang code is converted to network packets, then where
// are they going? the answer is: 'scsynth'. as such, scsynth is a server that
// must be booted and runs externally from sclang. in the simplest case, you
// are booting a server on your own computer and sending sclang sends its
// packets to that local server. however, other configurations can involve
// really weird configurations, such as one client talking to 10 remote servers or
// 20 clients all talking to a single remote server. all you would need is
// the ip address and port of the computers hosting the scsynth servers.

// enough gab, this is how you do it:
s.boot;

// the previous command should make a bunch of stuff happen in the Post window.
// in case you got excited during the previous part of the demo and set 's' to
// something else, execute the following:
s = Server.local;
s.boot;

// since all of the code we executed before this involved simple printing,
// arithmetic and variable definition, we never actually needed to send
// any messages to the server.

// that changes now:
{ SinOsc.ar([400, 401], 0, 0.1) * Saw.ar([11, 33], 1) * EnvGen.kr(Env.sine(10)) }.play;
// borrowed from Mark Polishook tutorial

// THIS IS ONE OF THE MOST IMPORTANT NOTES SO FAR:
// at some point in your experiences using SC, you will make a sound so loud
// and ear piercing that it would make a banshee shift uncomfortably
// in their seat. at other times, you will simply want to stop playing sound.
// in either case, there is a quick keystroke that will stop all currently
// sounding nodes in the server. just press:
//
// cmd+period or ctrl+period