## Routes in EmberJs

Routing in EmberJs is implemented through one `Router` object,
and multiple `Route` objects.
The primary functions of a `Route` object are to fetch or construct
the MVC state of the application when activated.
Typically this would involve fetching the model,
then passing the model to the controller,
and finally telling the view to render its template.

The default implementation of the `Route` object does all of these things,
out of the box, without the developer having to do anything.
The model however, will simply be empty.
In most cases, we want our routes to have models,
and fetch these models from a server.
Thus, typically the default routes are extended
to implement a custom `model` hook.

```javascript
App.FoosRoute = Ember.Route.extend({
    model: function() {
        return [{name: 'f1'}, {name: 'f2'}, {name: 'f3'}];
    }
});
```

That controller always returns an array with hard-coded contents.
Useful for stubbing or prototyping, but for applications in production,
most likely we will want to retrieve data from an external data source,
such as an API server:

```javascript
App.FoosRoute = Ember.Route.extend({
    model: function() {
        var req = Ember.RSVP.resolve(Ember.$.getJSON('/api/foos'));
        return req.then(function resolve(response) {
            return response.foos;
        });
    }
});
```

Here we use [`jQuery.getJSON()`](http://api.jquery.com/jquery.getjson/)
to perform the AJAX request.
AJAX requests, are, of course, asynchronous,
and thus they need to be dealt with using either callbacks or promises.
In EmberJs, the `model` hook of any route is expected to return one of two types:

- a plain ol' JavaScript object (POJSO)
- a promise

If a POJSO is returned, EmberJS uses that value immediately.
If, on the other hand, a promise is returned,
EmberJs waits until the promise resolves or rejects,
and only then does it continue
to initialise the controller and pass the model to it.

Above, we need to wrap the promise-like object returned by `jQuery.getJSON()`
using `Ember.RSVP.resolve()` in order to obtain a promise object that EmberJs
knows how to use correctly.
This is yet another stumbling block for anyone starting with EmberJs,
because it quite often means that the application does not work as expected.
It would be great if this is better documented in EmberJs,
or better still, if EmberJs ships with its own AJAX constructs,
as AngularJs does with its `$http` modules.
