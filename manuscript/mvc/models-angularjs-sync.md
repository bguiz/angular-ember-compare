## Sync'ing AngularJs Models

AngularJs models are just POJSOs,
thus when you need to sync them with the server,
you are left to implement the means yourself.

The following are the most popular ways to accomplish this,
arranged in order of least to most "managed".

- `$http`
    - An AngularJs directive that you would use in a manner similar to `jQuery.ajax`.
      Use this is you wish to specify interactions on a per request basis,
      such as when you need the most fine-grained level of control.
- `$resource`
    - An AngularJs directive that wraps `$http`,
      which allows you to group various `$http` requests together.
- [restangular](https://github.com/mgonto/restangular)
    - A 3rd party library that makes it easy to sync models with a RESTful API.

We will not go into the syntax for each method here,
as each is fairly straight forward to use.
The hardest part of this lies in deciding which level of abstraction is
appropriate for your application.

As a developer, this is pretty good,
as you have several great options to choose from.
