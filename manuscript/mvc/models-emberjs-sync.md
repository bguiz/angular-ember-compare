## Sync'ing EmberJs Models

The syntax above, was, strictly speaking, not exactly a models,
they are merely objects.
This general purpose wrapper is sufficient for use as models,
provided that you are happy to write your own AJAX for all operations.
This [article shows one great way to do this](http://eviltrout.com/2013/03/23/ember-without-data.html).

The canonical way to do this, is using Ember Data.
Ember Data is essentially an [ORM](https://en.wikipedia.org/wiki/Object-relational_mapping)
that gives you the tools to define your models in Ember,
and synchronise them with your RESTful API back end.

To define a model, we have:

```javascript
var Foo = DS.Model.extend({
    name: DS.attr('string')
});
var myModel = Foo.create({ name: 'foo1' });
```

The primary difference here is that instead of `Ember.Object.extend()`,
use `DS.Model.extend()`,
and the attributes that the model is expected to have are defined;
except for `id` which is assumed to exist.

It also provides a means to define relationships between the different model classes:

```javascript
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
```

Ember Data has a `RESTAdapter`, which allows you to sync the state
of these models with the back end, via a RESTful API.
This API must conform to a [strict format](http://emberjs.com/guides/models/the-rest-adapter/)
that is quite similar to [JSON API](http://jsonapi.org/format/);
notably with regards to relationships and side loading.

While this sounds like an everything-included solution,
in reality, it is quite likely not be such a smooth ride.
The format of the API that Ember Data expects is quite precise,
and chances are the existing API that you have make your web application talk to
is going to differ, and break your application.
Ember Data does provide the ability to customise and even write your own
adapters, however, things can get very hairy very quickly -
just take a look at this attempt to make
[embedded instead of side loaded data work, using Ember Data](http://mozmonkey.com/2013/12/loading-json-with-embedded-records-into-ember-data-1-0-0-beta/).

If your back end is written in Ruby on Rails, however,
you are in luck, as Ember Data includes an
[`ActiveModelAdapter`](http://emberjs.com/api/data/classes/DS.ActiveModelAdapter.html)
that should simply work out of the box.

For those who are writing applications whose back end is **not** Ruby on Rails,
and are not starting from scratch,
or are not in a position to change the back end API -
which, I suspect, would constitute the majority of all developers -
what options are available?

- ~~Ember Data~~
- [Ember Model](https://github.com/ebryn/ember-model):
  Follows the same syntax as Ember Data, and written by a member of the core team of EmberJs
- [Ember RESTless](https://github.com/endlessinc/ember-restless):
  Also follows the same syntax as Ember Data
- [Ember without Ember Data](http://eviltrout.com/2013/03/23/ember-without-data.html):
  Use raw `Ember.Object`s and write everything by hand.

Both Ember Model and Ember RESTless provide good alternatives to Ember Data
if you want a "managed" approach, but want more flexibility than Ember Data allows.
The Ember without Ember Data approach works well best when your application
does not need a "managed" approach at all.

Overall, when it comes to sync'ing models with a server,
developers using EmberJs are put in a pretty hard spot.
Ember Data is the recommended way to do this,
yet it is [not yet production ready](http://emberjs.com/blog/2014/03/18/the-road-to-ember-data-1-0.html) -
and it has been in ["1.0.0 beta" for 8 months now](https://github.com/emberjs/data/releases/tag/v1.0.0-beta).

This leaves us to choose from several different 3rd party solutions,
and fragments the community in terms of the number of different ways that
a particular feature can be implemented.
