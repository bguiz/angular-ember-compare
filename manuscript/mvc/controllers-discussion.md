## Discussion

When developing applications with [BackboneJs](http://backbonejs.org/),
the lack of two-way binding capability,
or even just any form of automatic binding,
was the single biggest drain in productivity.
One had to specify in the templates where the models were to be rendered.
Subsequently one had to specify listeners for each change on the model,
and each change on the view,
and write code to handle the change to propagate model changes to the view,
and view changes to the model.

This was tedious, but the main problem that this created was not its verbosity.
It was that there **always was a chance of oversight**.
A chance that one of these change propagations would be missed or forgotten,
and lead to much head scratching,
and detective work that could have otherwise been avoided, down the road.

What was missing was that BackboneJs did *not* provide a means to define a
**single-source of truth**   -
quite often that the models and views would stray, and get out of sync.
With two-way binding, however, the models are indeed the single source of truth,
changes to the models made anywhere -
be it code within a controller, or user interactions on a view -
will be propagated correctly.
Getting two-way binding out of the box,
as we do with both AngularJs and EmberJs,
is a great boon to productivity in developing
web applications - I cannot emphasise this enough.

We also took a look at some software engineering paradigms,
like imperative versus declarative styles of programming,
and the different approaches each framework takes on computed properties;
and their impact upon computational efficiency,
and ease to work with.

We have now covered the trifecta of the parts of both AngularJs and EmberJs
that allow us to organise code according to the MVC pattern.
Both frameworks excel at supporting the MVC pattern,
providing an excellent infrastructure upon which to build these.

While MVC lies at the core of developing a single page application,
that is *not all* there is to it.
Next we will take a look at two more crucial parts of each of these frameworks,
routing and components.
