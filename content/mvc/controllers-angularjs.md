### Controllers in AngularJs

![Controllers in AngularJs](/img/angularjs-controller.png)

Controllers in AngularJs are not, strictly speaking, controllers.
In fact AngularJs does not call itself an MVC framework,
[it calls itself an MVW (model-view-whatever) framework](http://plus.google.com/+AngularJS/posts/aZNVhj355G2) instead.
That being said, that is only true from a academic purist's point of view;
through a practical lens, they most certainly are.

Syntax:

        angular.module('application', []).controller('FooCtrl', function($scope) {
            $scope.someProperty = 'More exclamation marks';
            $scope.someAction = function() {
                $scope.someProperty += '!';
            };
        });

The `$scope` object is [prototypically inherited](https://github.com/angular/angular.js/wiki/Understanding-Scopes#angular-scope-inheritance) from its parent's
`$scope` object - in this case the main application object.
It is made available through AngularJs' dependency injection framework.
This in itself is a fascinating topic that warrants a discussion of its own,
as it is a *beautiful* piece of software engineering architecture.
Understanding it lies at core of understanding AngularJs.
Unfortunately, this is not one of the criteria for comparison.
I would however, suggest this article on
[understanding dependency injection](https://github.com/angular/angular.js/wiki/Understanding-Scopes#angular-scope-inheritance)
for a primer on the basics;
and this article on [inheritance patterns](http://blog.mgechev.com/2013/12/18/inheritance-services-controllers-in-angularjs/)
as further reading.
