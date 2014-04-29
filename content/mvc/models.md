## Models

Models are objects that represent data that is used by the app.
The combination of all models define the state of the application.
SPA frameworks, like AngularJs and EmberJs,
come with methods to manage and interact with models.
They also come with means to sync or map their models with
their counterpart models on servers -
usually rows in a database via a [RESTful](http://stackoverflow.com/a/671132/194982) API.

### Models in AngularJs

AngularJs uses plain ol' Javascript objects (POJSOs) for models.

`var myModel = { id: 1, name: 'foo1' };`

Bam! It was as simple as that - you have got yourself an AngularJs model.

Changing the state of that model is also just as simple,
as the suyntax is no different from manipulating POJSOs:

`myModel.name = 'myNewName';`

Likewise, accessing state is just as easy:

`myModel.name` (evaluates to "myNewName")

Can it really be that simple? &hellip; Where is the catch?

In order to get any use out of these models,
you will need to set them as a property of the `$scope` variable in a controller,
like so:

`$scope.myModel = myModel;`

(more on [Controllers](mvc/controllers.md))

&hellip; Simple!

However, there are implications when usings POJSOs as models,
when binding data between the models and views.
It means that we need to do dirty checking -
keeping a copy of each model in its previous state,
and checking for differences at a particular interval.
This incurs a heavy performance penalty when models are numerous,
or when models get very complex;
and working around these limitations requires a in-depth understanding of
`$scope`, `$watch`, dirty checking, and run loops.

That is a rather advanced topic, and you can read more about the implications of
[using accessors vs using dirty checking here](http://blog.bguiz.com/post/57373805814/accessors-vs-dirty-checking-in-javascript-frameworks)

That being said, dirty checking is a pretty good value proposition in most cases,
as the many web apps do not have very many models to deal with at once,
or have models that are complex enough,
to incur the performance penalty.

### Sync'ing AngularJs Models

Angular models are just POJSOs,
thus when you need to sync them with the server,
you are left to implement the means yourself.

The following are the most popular ways to accomplish this,
arranged in order of least to most "managed".

- `$http`
    - An AngularJs directive that is very similar to `jQuery.ajax`.
      Use this is you wish to sepcify interactions on a per request basis,
      or when you need the most fine-grained level of control.
- `$resource`
    - An AngularJs directive that wraps `$http`,
      which allows you to group various `$http` requests together
- [restangular](https://github.com/mgonto/restangular)
    - A 3rd party library that makes it easy to sync models with a RESTful API

We will not go into the syntax of each method here,
as each is fairly straight forward to use.
The hardest part of this really lies in deciding which level of abstraction is
the most appropriate for your app.

As the developer, this is pretty good,
as you have several great options to choose from.

