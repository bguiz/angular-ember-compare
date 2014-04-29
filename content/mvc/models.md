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

### Models in EmberJs

In EmberJs, the syntax used to express a model is more complex than in AngularJs,
as POJSOs may not be used directly,
and instead must be "wrapped" using an Ember object, like so:

        var Foo = Ember.Object.extend();
        var myModel = Foo.create({ id: 1, name: 'foo1' });

Noteworthy here is that we first defined a class for our model, `Foo`,
and then created an instance of that class, `myModel`.
We needed to do this because models in Ember are expected
to conform to a certain interface, in order to work with the rest of the framework.
POJSOs are not going to provide this interface,
hence we define a class for our model, before instantiating one.

The most important, and frequently used parts of this interface,
are accessing and changing porperties:

`myModel.set('name', 'newFooName');` changes the state of the model.

`myModel.get('name');` reads the state of the model.

A common question asked, is, if AngularJs can use POJSOs for models,
what is preventing EmberJs from doing the same too?
One of the main reasons for this is that it is not possible to create
observers for property changes on POJSOs (yet).
As such, a wrapper class is used to observe property changes -
whenever `.get()` and `.set()` get called.
[Using accessors vs using dirty checking here](http://blog.bguiz.com/post/57373805814/accessors-vs-dirty-checking-in-javascript-frameworks)
covers this topic in greater detail.
Essentially wrapper objects with accessors (EmberJs' approach) and
dirty checking (AngularJs' approach),
are merely different ways to solve the same problem,
of observing state changes on models.

### Sync'ing EmberJs Models

The syntax above, was strictly speaking, not exactly a models,
they are merely objects.
This egeneral purpose wrapper is sufficient for use as models,
provided that you are happy to write your own AJAX for all operations.
This [article shows one great way to do this](http://eviltrout.com/2013/03/23/ember-without-data.html).

The canonical way to do this, is using Ember Data.
Ember Data is essentially an [ORM](https://en.wikipedia.org/wiki/Object-relational_mapping)
that gives you the tools to define your models in Ember,
and synchronise them with your RESTful API backend.

To define a model, we have:

        var Foo = DS.Model.extend({
            name: DS.attr('string')
        });
        var myModel = Foo.create({ name: 'foo1' });

The primary difference here is that instead of `Ember.Object.extend()`,
use `DS.Model.extend()`,
and the attributes that the model is expected to have are defined;
except for `id` which is assumed to exist.

It also provides a means to define relationshsips between the different model classes:

    var Foo = DS.Model.extend({
        name: DS.attr('string'),
        bars: DS.hasMany('bar')
    });
    var Bar = DS.Model.extend({
        name: DS.attr('string'),
        foo: DS.belongsTo('foo')
    });
    //create or fetch some Bar models
    var myModel = Foo.create({
        name: 'foo1',
        bars: [100, 101] //IDs of the Bar models
    });

Ember Data has a `RESTAdapter` allow you to sync that state
of these models with the backend via a RESTful API.
This API must conform to a [strict format](http://emberjs.com/guides/models/the-rest-adapter/)
that is quite similar to [JSON API](http://jsonapi.org/format/);
notably the way that relationships and sideloading are defined.

While this sounds like an everything-included solution,
in reality, it is quite likely not be such a smooth ride.
The format of the API that Ember Data expects is quite precise,
and chances are the existing API that you have make your web app talk to
is going to differ, and break your app.
Ember Data does provide the ability to customise and even write your own
adapters, however, things can get very hairy very quickly -
just take a look at this attempt to make
[embedded instead of sideloaded data work with Ember Data](http://mozmonkey.com/2013/12/loading-json-with-embedded-records-into-ember-data-1-0-0-beta/).
If your backend is written in Rails, hwoever, you are in luck,
as Ember Data includes an [`ActiveModelAdapter`](http://emberjs.com/api/data/classes/DS.ActiveModelAdapter.html)
that will work out of the box.

For those who are writing apps whose backend is not Rails,
and are not starting from scratch,
or are not in a position to change the backend API -
which I suspect is the majority of all developers -
what options are available?

- <strikethrough>Ember Data</strikethrough>
- [Ember Model](https://github.com/ebryn/ember-model):
  follows the same syntax as Ember Data, and written by a member of the core team of EmberJs
- [Ember RESTless](https://github.com/endlessinc/ember-restless)
  also follow the same syntax as Ember Data
- [Ember without Ember Data](http://eviltrout.com/2013/03/23/ember-without-data.html)
  use `Ember.Object` and write everything by hand.

Both Ember Model and Ember RESTless provide good alternatives to Ember Data
if you want a "managed" approach, but want more flexibility than Ember Data allows.
The Ember without Ember Data approach works well best when your app
does not need a "managed" approach at all.

Overall, when it comes to sync'ing models with a server,
developers using EmberJs are put in a pretty hard spot.
Ember Data is the recommended way to do this,
yet it is [not yet production ready](http://emberjs.com/blog/2014/03/18/the-road-to-ember-data-1-0.html) -
and it has been in ["1.0.0 beta" for 8 months now](https://github.com/emberjs/data/releases/tag/v1.0.0-beta).

This leaves us to choose from several different 3rd party solutions,
and fragments the community in terms of the number of different ways that
a particular feature can be implemented

### How this might change with ES6

There is currently [a draft proposal in ECMAScript 6](http://wiki.ecmascript.org/doku.php?id=harmony:observe,
the standards specification for the next version of Javascript,
for `Object.observe()`.
The specification calls for native methods on all POJSOs to observe for
changes made to their state.
This ability will turn the issue of wrapper objects with accessors versus
dirty checking on its head,
as both of them will no longer be necessary to listen for changes in models,
and to accomplish data-binding between models and views.
This article, even goes as far as to say ["Everything you think you know about data binding — and every trick MVC libraries are using to pull it off — is about to be flipped on its head"](http://bocoup.com/weblog/javascript-object-observe/).

It is pertinent to remember, that while some browsers, as well as NodeJs,
have already implemented `Object.observe()`,
it is still under discussions, and is still presently a proposal,
not yet an official specification, so actual implementation variations,
and adoption across all devices, is still relatively unknown.
