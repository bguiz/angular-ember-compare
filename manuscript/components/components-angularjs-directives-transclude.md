### `transclude`

Next, we add `transclude`, like so:

```javascript
App.directive('fooComponent', function() {
    return {
        restrict: 'E',
        transclude: true,
        templateUrl: 'components/foo.html'
    };
});
```

&hellip; and we modify the  template file at `components/foo.html`:

```html
<div>
    <div ng-transclude></div>
    <p>Foo component</p>
</div>
```

Do not let the word transclude scare you -
I think of it, simply, as *include with an outside transfer*.
All it really means is that we can now do this in the DOM:

```html
<foo-component>
    <p>Some text included from outside the component</p>
</foo-component>
```

And `<p>` tag containing "Some text included from outside the component",
will get rendered within the `<div>` tag with the `ng-transclude` attribute.
