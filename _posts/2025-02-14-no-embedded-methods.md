
Typical python style is to write:
~~~~
class Foo:
	def __init__(self):
		...
	def method(self, ...):
		...
~~~~

And this typically grows unmanageable with method defintions growing
to 10s (or 100s!) of lines long and the entire class definition become
a tangled mess of unreadable garbage that spans 1000s of lines.  To
avoid this mess, I propose never doing that.  Instead, always write:

~~~~
class Foo: pass

def init(self: Foo):
	...

def method(self: Foo, ...):
	...

Foo.__init__ = init
Foo.method = method
~~~~

Despite the warning in the Python docs ("Note that this practice
usually only serves to confuse the reader of a program"), this has
several benefits and I believe the Python docs are incorrect on
this point.

When the method definitions are embedded in the class definition,
you cannot provide a type annotation for `self`, but moving the
method definition out of the class definition allows the type
annotations.  This wouldn't be a big deal except in the aforementioned
case when you are staring at a function definition on line 5345 of
a file and the `class Foo` line occurs on line 3400, and you simply
don't have context to even be certain which class definition you
are currently looking at.

This reduces indentation level by 1.  Whether or not this is
significant is debatable, but each level of indentation roughly
corresponds to a layer of abstraction which means one more level
of cognitivie exertion.  One could argue that reducing the indentation
incrementally reduces the complexity.

I really don't see a downside to this style.  Arguably, this clutters
the namespace a bit, since `method` is now accessible via `Foo.method`
(assuming this class is defined in the `Foo` module) as well as in
the class namespace, and it makes it impossible to use the zero-argument
form of `super` but these are trivial concerns.  Remember the Tao
of Python: "Explicit is better than implicit", from which we conclude
that one should never use the zero argument version of `super` and
that pretending an importer cannot access your methods easily is
foolish so it is better to make them explicitly visible in the
global namespace of the module.  As long as the importer uses the
`from Foo import Foo` form of import, the namespace issue seems
irrelevant.
