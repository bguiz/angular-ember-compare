### Isolate `scope`

The final step, and likely the most important one, is of scope isolation.
In any AngularJs template, the default behaviour is for the scope available
on any element to be available on any of its child elements.
This is because a child inherits its scope prototypically from its parent's scope.

Scope isolation is about using a directive on a child element,
telling it to **use a new scope**.
It also allows ways in which select parts of the parent scope
may be passed into the child scope.
This is a crucial thing to do when building components,
as components are supposed to be modular.
Thus, if a component is to be useful in a number of different situations,
where its parent's scopes may be different,
that component should define exactly what it needs in its scope.

The most basic syntax would be:

```javascript
App.directive('fooComponent', function() {
    return {
        restrict: 'E',
        transclude: true,
        scope: true,
        templateUrl: 'components/foo.html'
    };
});
```

Setting `scope` to  `true` simply indicates that this directive will use its own
scope, that is brand new, and thus isolated from its parent's scope.
This is not very useful,
unless the template for this directive does not need to bind to anything.
To create a more useful isolate scope, we use an object:

```javascript
App.directive('fooComponent', function() {
    return {
        restrict: 'E',
        transclude: true,
        scope: {
            bar: '=', //two-way binding
            baz: '@', //attribute binding
        },
        templateUrl: 'components/foo.html'
    };
});
```

&hellip; and we use the component like this in the DOM:

```html
<foo-component bar=myBar baz="{{myBaz}}">
    <p>Some text included from outside the component</p>
</foo-component>
```

That would mean that the component's scope would contain:

- `bar` which contains the value of `myBar` on the parent scope.
  Whenever the parent scope or the component scope's value changes,
  the change propagates to the other (two-way binding)
- `baz` which contains the evaluated value of the expression `myBaz`
  on the parent scope.
  When the value of the parent scope changes, the value in the child scope changes too.
  However, when the value in the child scope changes, the value in the parent scope will remain the same.
  This is useful when you know that the child scope should *not* be able to
  update the parent scope, and therefore do not need to expend the extra
  effort for two-way binding (it is more computationally expensive).

The most important thing to note here is that by defining isolate scopes,
we are effectively **defining the interface** required by the component,
which is important when creating modular software.

This has been a very simplified explanation of the concepts of
`restrict`, `transclude`, and `scope` isolation in AngularJs directives.
These resources cover them in greater depth:

- [Creating components with AngularJs](http://blog.ijasoneverett.com/2013/03/creating-components-with-angular-js/)
- [Understanding Scopes - Directives](https://github.com/angular/angular.js/wiki/Understanding-Scopes#-directives)
