## Controllers

Controllers are the final piece of the MVC puzzle.
They are the glue that binds models to views/ templates.
Their responsibilities include manipulating models,
as well as responding to user interactions on the view.

Now when performed separately, these are not particularly interesting.
However, their real utility becomes apparent when they interact with
both models and views simultaneously.
For example, the user might click a button rendered by a view,
that triggers an action on the controller,
which modifies a model.
Then some of the attributes that have changed on the model are bound
by the template, and the view is notified of this change,
and the relevant section of the DOM is re-rendered.
In this sequence of events, the controller is what sits in between
the model and the view, passing the appropriate messages between them,
enabling all this to happen.

![Model-View-Controller interactions](http://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/MVC-Process.svg/200px-MVC-Process.svg.png)

Unlike some of their older SPA framework counterparts,
both AngularJs and EmberJs support two-way binding.
That is:

	1. When the model state changes,
	   if any parts of the view are bound to the part of the model that has changed,
	   those parts of the view are re-rendered.
	2. When the view state changes,
	   if those parts of the view are bound to parts of the model,
	   those parts of the model are changed.

### Controllers in AngularJs

Controllers in AngularJs are not, strictly speaking, controllers.
In fact Angular does not call itself an MVC framework,
[it calls itself an MVW (model-view-whatever) framework](http://plus.google.com/+AngularJS/posts/aZNVhj355G2) instead.
That being said, that is only true from a academic purist's point of view;
through a practical lens, they most certainly are.

Syntax:

		angular.module('app', []).controller('FooCtrl', function($scope) {
			$scope.someProperty = 'More exclamation marks';
			$scope.someAction = function() {
				$scope.someProperty += '!';
			};
		});

The `$scope` object is [proptypically inherited](https://github.com/angular/angular.js/wiki/Understanding-Scopes#angular-scope-inheritance) from its parent's
`$scope` object - in this case the main application object.
It is made available through AngularJs' dependency injection framework.
This in itself is a fascinating topic that warrants a discussion of its own,
as it is a *beautiful* piece of software engineering architecture.
Understanding it lies at core of understanding AngularJs.
Unfortunately, this is not one of the criteria for comparison.
I would however, suggest this article on
[understanding dependency injection](https://github.com/angular/angular.js/wiki/Understanding-Scopes#angular-scope-inheritance)
for a primer on the basics;
and this article on [inheritance paterns](http://blog.mgechev.com/2013/12/18/inheritance-services-controllers-in-angularjs/)
as further reading.

### Two-way binding in AngularJs

Syntax:

		<div ng-controller="FooCtrl">
			<button ng-click="someAction()">Press me</button>
			<p>{{someProperty}}</p>
			<input type="text" value="{{someProperty}}">
		</div>

The template above is not a very useful one,
by providing two different ways to modify the same propertyon the controller's
`$scope`, however, it is a succinct demonstration of two-way binding.

When the button is clicked, the controller modifies the model.
The template contains a `<p>` tag whose contents are bound to the model,
and the view listens for the change on the model and updates its contents.
The template also contains another binding to the same model,
in the `<input>` tag's `value` attribute,
and this is also updated, in a similar manner.
Both of these sequences are one way bindings, from model to view.

Now, instead of modifying the model, we modify the view instead,
by typing into the input field.
The model listens for the change in the view,
and when the input field is modified,
it detects a change and updates the model.
The `<p>` tag, of course, is still bound to the model,
and it listens for a change on the model,
and updates its contents, as it did before.
This is two-way bidning in action,
with the first sequence from view to model,
and the second sequence from model back to view.

This magic that happens behind the scenes does come at a cost though.
As apps become more complex, it becomes more important to know
how two-way binding works.
The canonical use case for when this becomes especially important
occurs when you have extremely large or complex properties on the `$scope` -
too complex for it to be included in the dirty checking
which gets performed in each digest cycle.
So instead of storing these properties on the `$scope`,
we we store them outside of it,
and then manually notify the controller whenever the property has been updated.
This is accomplished through [`$watch`](https://docs.angularjs.org/api/ng/type/$rootScope.Scope#$watch) and `$apply`,
and using them correctly is contingent upon understanding
how two-way binding works, and how it works together with the digest cycle.
These techniques, however, ar beyond the scope of this comparison.
I would suggest this article [on performance tuning](http://tech.small-improvements.com/2013/09/10/angularjs-performance-with-large-lists/)
as further reading on this technique, and several others.

### Controllers in EmberJs

EmberJs controllers conform to the pure MVC definition of them.

Syntax:

App.FooController = Ember.Controller.extend({
    someProperty: 'More exclamation marks',
    actions: {
        someAction: function() {
            this.set('someProperty', this.get('someProperty') + '!');
        }
    }
});

EmberJs enforces a clean separation between properties and actions
within a controller -
all actions are grouped into a single hash.

Another things worth pointing out here,
is that unlike AngularJs,
EmberJs distinguishes between properties set on the controller,
and models used by the controller.
Models are typically created and passed in a controller by a `Ember.Route` object,
which we shall take a look at when we look at routing.
This is because there is only one instance of any controller instantiated,
and thus its state does *not* get reset each time.
This is can be confusing when working with EmberJs for the first time.

Another thing worth noting is that we had to name this controller `FooController`.
In ANgularJs, we were free to name our controller anything we wished to -
`BarCtrl` would have worked jsut as well as `FooCtrl`.
In EmberJs, however, we must take care to name our controllers -
and most other types of objects -
according to the specified naming convention.
This is a common beginner's gotcha, and takes getting used to.
Until then, do not hesitate to refer to the handy tables,
in the [naming conventions guide](http://emberjs.com/guides/concepts/naming-conventions/)
as a reference.
A completely customised naming strategy is also possible,
by extending (or replacing) EmberJs' [default resolver](http://emberjs.com/api/classes/Ember.DefaultResolver.html).
However, this is often more effort than it is worth,
and most developers will choose to stick to the default resolver.

### Two-way binding in EmberJs

Syntax:

        <div>
            <button {{action 'someAction'}}>Exclaim harder</button>
            <p>{{someProperty}}</p>
            {{input type="text' value=someProperty}}
        </div>

Two-way binding in EmberJs works in a very similar fashion to
the way it works in AngularJs -
so we will only cover the differences.

The contents of the `<p>` tag get bound and behave as expected.
However, element attributes are problematic -
we cannot bind any model values to DOM element attributes
using the usual squiggly bracket syntax.
The reason for this is that EmberJs inserts `<script>` tags -
one before and one after -
each bound section of the template;
and of while this works well outside of elements,
it does not work too well for attributes.

We need to use the [`{{bind-attr}}` Handlebars helper](http://emberjs.com/guides/templates/binding-element-attributes/)
instead.
As this is a very common use case for `<input>` tags,
there is an `{{input}}` Handlebars helper that does this for us.

The implication of this is that getting two-way binding to work in EmberJs
can be quite complicated, as there is more syntax to learn.

### Imperative vs Declarative Syntax in Two-way Binding

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

### Imperative vs Declarative Syntax in Controllers

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

When developing apps with [BackboneJs](http://backbonejs.org/),
the lack of two-way binding capability was the single biggest drain in productivity.
One had to specify in the templates where the models were to be rendered.
Subsequently one had to specify listeners for each change on the model,
and each change on the view,
and write codeto handle the change to propagate model changes to the view,
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
web apps - I cannot emphasise this enough.

We also took a look at some software enginnering paradigms,
like imperative versus declarative styles of programming,
and the different approaches each framework takes on computed properties;
and their impact upon computational effiency,
and ease to work with.

We have now covered the trifecta of the parts of both AngularJs and EmberJs
that allow us to organise code according to the MVC pattern.
Both frameworks excel at supporting the MVC pattern,
providing an excellent infrasructure upon which to build these.

While MVC lies at the core of developing a single page app,
that is not all there is to it.
Next we will take a look at two more crucial parts of the framework,
routing and components.
