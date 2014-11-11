## Models in AngularJs

![Models in AngularJs](/images/angularjs-model.png)

AngularJs uses plain ol' JavaScript objects (POJSOs) for models.

```javascript
var myModel = { id: 1, name: 'foo1' };
```

Bam! It was as simple as that - you have got yourself an AngularJs model.

Changing the state of that model is also just as simple,
as the syntax is no different from manipulating POJSOs:

```javascript
myModel.name = 'myNewName';
```

Likewise, accessing state is just as easy:

```javascript
myModel.name; // (evaluates to "myNewName")
```

Can it really be that simple? &hellip; Where is the catch?

In order to get any use out of these models,
you will need to set them as a property of the `$scope` variable in a controller,
like so:

```javascript
$scope.myModel = myModel;
```

(more on [Controllers](mvc/controllers-angularjs.md))

&hellip; Simple!

However, there are implications when using POJSOs as models,
when binding data between the models and views.
It means that we need to do dirty checking -
keeping a copy of each model in its previous state,
and checking for differences at a particular interval.
This incurs a heavy performance penalty when models are numerous,
or when models get very complex;
and working around these limitations requires a in-depth understanding of
`$scope`, `$watch`, dirty checking, and run loops.

That is a rather advanced topic, and you can read more about the implications of using
[accessors versus using dirty checking here](http://blog.bguiz.com/post/57373805814/accessors-vs-dirty-checking-in-javascript-frameworks).

That being said, dirty checking is a pretty good value proposition in most cases,
as the majority web applications do not have very many models to deal with at once,
or have models that are complex enough,
to incur the performance penalty.
