## Models in EmberJs

![Models in EmberJs](/images/emberjs-model.png)

In EmberJs, the syntax used to express a model is more complex than in AngularJs,
as POJSOs may not be used directly,
and instead must be "wrapped" using an EmberJs object, like so:

```javascript
var Foo = Ember.Object.extend();
var myModel = Foo.create({ id: 1, name: 'foo1' });
```

Noteworthy here is that we first defined a class for our model, `Foo`,
and then created an instance of that class, `myModel`.
We needed to do this because models in EmberJs are expected
to conform to a certain interface, in order to work with the rest of the framework.
POJSOs are not going to provide this interface,
hence we define a class for our model, before instantiating one.

The most important, and frequently used parts of this interface,
are accessing and changing properties:

`myModel.set('name', 'newFooName');` changes the state of the model.

`myModel.get('name');` reads the state of the model.

A common question asked, is, if AngularJs can use POJSOs for models,
what is preventing EmberJs from doing the same too?
One of the main reasons for this is that it is not possible to create
observers for property changes on POJSOs (yet).
As such, a wrapper class is used to observe property changes -
whenever `.get()` and `.set()` get called.

My article on [using accessors versus using dirty checking here](http://blog.bguiz.com/post/57373805814/accessors-vs-dirty-checking-in-javascript-frameworks)
covers this topic in greater detail.
To summarise, however:
Wrapper objects with accessors (EmberJs' approach) and
dirty checking (AngularJs' approach),
are merely different ways to solve the same problem,
of observing state changes on models.
