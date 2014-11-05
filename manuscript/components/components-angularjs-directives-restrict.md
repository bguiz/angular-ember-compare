### `restrict` in AngularJs Directives

The bare minimum syntax would be:

```javascript
App.directive('fooComponent', function() {
    return {
        templateUrl: 'components/foo.html'
    };
});
```

&hellip; and we create a template file at `components/foo.html`:

```html
<div>
    <p>Foo component</p>
</div>
```

In order to use this, we add this to the template:

```html
<div foo-component>
</div>
```

All this does is take the template at `components/foo.html`
and render it within this `<div>`.
This does not look very much like a component,
and lacks a few features that we would expect of one.

Now we make it a little more useful using `restrict`:

```javascript
App.directive('fooComponent', function() {
    return {
        restrict: 'E',
        templateUrl: 'components/foo.html'
    };
});
```

Now, we may use it without a `<div>` tag:

```html
<foo-component>
</foo-component>
```

Setting `restrict` to `E` means that AngularJs will allow this directive
to be recognised *only* when the directive name is specified as an element.
Setting it in an attribute, or as a comment, will no longer work.

As a side note: Beware of the *self-closing tag*!
While `<div />` is perfectly legal HTML,
`<foo-component />` is **not**, and AngularJs' templating engine will
not be able to parse it.
Self-closing tags, also known as *void tags*,
are **not** allowed when defining custom element tags.
