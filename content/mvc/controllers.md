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
