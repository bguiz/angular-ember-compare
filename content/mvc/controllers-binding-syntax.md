### Imperative versus Declarative Syntax in Two-way Binding

In both AngularJs and EmberJs, the syntax used to accomplish two-way binding
between models and views is through declarative syntax in the templates.
We simply state what we properties we want to be bound in the template,
and let the framework figure out the how -
as a developer using either framework,
we do not need to figure out the code necessary for this to work.

By contrast, the lack of two-way binding in some other SPA frameworks,
such as BackboneJs, means that the developer has to code all the sequences of
actions for each property which he/ she wishes to be bound.
This is the opposite of the declarative style enabled by AngularJs and EmberJs -
it is an imperative style.

Some developers prefer an imperative style of programming,
and other developers prefer a declarative style of programming.
It is up to you to pick which works best.
The vast majority of those developing SPAs however,
prefer to use two-way binding,
and opt out of it in exceptional cases.

### Imperative versus Declarative Syntax in Controllers

Properties on AngularJs controllers are defined imperatively.

Properties on EmberJs controllers can be defined either imperatively or declaratively.

        var FoosController = Ember.ArrayController.extend({
            //this is an imperatively defined property
            filterText: '',

            //this is a declaratively defined property
            filteredModel: function() {
                var foos = this.get('model');
                var filterText = this.get('filterText');
                return foos.filter(function(foo) {
                    return foo.name.indexOf('filterText') >= 0;
                });
            }.property('model', 'filterText')
        });

Here EmberJs makes use of `Function.prototype.property()`
to define which properties are dependent upon changes on other properties.
What EmberJs does behind the scenes is create a
[Digraph](http://en.wikipedia.org/wiki/Directed_graph),
and whenever one of the watched properties changes,
traverses the graph to recompute all the other affected properties.
Pretty neat!

Noteworthy as well is that we can define computed properties as functions,
and when these are referred to elsewhere -
either in the templates or a `.get()` on the controller -
we simply refer to it by name, and not call the function.
In our example, we would use, in the templates:

        {{#each foo in filteredModel}}
        <p>{{foo.name}}</p>
        {{/each}}

Instead of:

        {{#each foo in filteredModel()}}
        <p>{{foo.name}}</p>
        {{/each}}

&hellip; which is different from AngularJs.
This happens because we have marked that function as being a property;
and is a great example of the
[uniform access principle](http://en.wikipedia.org/wiki/Uniform_access_principle).

In AngularJs, the way a computed property is defined is to create a function
on the scope.
If this property is used in a template, it gets called in every digest cycle.

EmberJs' way of specifying computed properties is a lot more succinct than
the way it is done in AngularJs.
This is also a lot more efficient than AngularJs' approach,
as it very neatly side steps the need to recompute them in each digest cycle.
While this can also be accomplished in AngularJs using `$watch`,
it is rather nice for the SPA framework to support this out of the box.

### Discussion

When developing applications with [BackboneJs](http://backbonejs.org/),
the lack of two-way binding capability was the single biggest drain in productivity.
One had to specify in the templates where the models were to be rendered.
Subsequently one had to specify listeners for each change on the model,
and each change on the view,
and write code to handle the change to propagate model changes to the view,
and view changes to the model.
This was tedious, but the main problem that this created was not its verbosity.
It was that there always was a chance of oversight,
that one of these change propagations would be missed due to oversight,
and lead to much head scratching down the road.

What was missing is that BackboneJs did *not* provide a means to define a
single-source of truth -
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
that is not all there is to it.
Next we will take a look at two more crucial parts of the framework,
routing and components.
