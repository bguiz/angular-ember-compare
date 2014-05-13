## Components

Browsers used to display documents -
that is content that had text formatting and images.
Web pages used to be simplay what you could create using a word processor,
or see printed on a newspaper,
expect that it was delivered over the Internet,
and displayed on a computer screen.
They are much more than that now, however.
Web pages are interactive, and can repsond to the user in ways
that a newspaper cannot.
Some are so advanced in these types of interactions that the phrase,
"web page" no longer seems an apt description -
we call them *web applications*, or *web apps*.

The typical thing that we create with AngularJs and EmberJs are most certainly
not web pages any longer,
and fall squarely into the web app category.
That being said, the HTML that we implement our apps in is still very much
designed around syntax used to describe *document*s.
This makes things tricky for the developer,
because over the years, we have created workaround after workaround
to continue making this document-oriented syntax continue working for us.

Thankfully, the standards body that governs HTML recognises this,
and is evolving the spec to keep up with how HTML is being used.
The [Web Components Specification](http://www.w3.org/TR/components-intro/)
is a draft specification, which describes a way in which we can
create *components* that can be thought of as a building block,
which contains a HTML template, CSS styles, and Javascript behaviour.

Web components, however, are not yet available -
but both AngularJs and EmberJs provide their own ways to create components
that behave very similarly to web components,

### Components in AngularJs

AngularJs does not provide a direct construct for defining custom components.
It does, however, provide a lower-level construct - directives -
which can be used to create them.

Directives in AngularJs can be used to define they ways in which
Javascript application code interacts with the DOM.
We have already seen some of these in action in the previous articles:
`ngModel`, `ngController`, and `ngClick`.
The templates know where code for these directives shoulod be applied,
by inspecting DOM elements for the dasherised versions of directives' names:
`ng-model`, `ng-controller`, and `ng-click`.

These are all built-in directives, that ship with AngularJs.
You can create your own too, using
[`App.directive()`](https://docs.angularjs.org/guide/directive#creating-directives),
and we will be doing that to define our own component.

#### `restrict`, `transclude`, and isolate `scope` in AngularJs Directives

The bare minimum syntax would be:

        App.directive('fooComponent', function() {
            return {
                templateUrl: 'components/foo.html'
            };
        });

&hellip; and we create a template file at `components/foo.html`:

        <div>
            <p>Foo component</p>
        </div>

In order to use this, we add this to the template:

        <div foo-component>
        </div>

All this does is take the the template at `components/foo.html`
and render it within this `<div>`.
This does not look very much like a component,
and lacks a few features that we would expect of one.

Now we make a a little more useful using `restrict`:

        App.directive('fooComponent', function() {
            return {
                restrict: 'E',
                templateUrl: 'components/foo.html'
            };
        });

Now, we may use it without a `<div>` tag:

        <foo-component>
        </foo-component>

Setting `restrict` to `E` means that AngularJs will allow this directive
to be recognised *only* when the directive name is specified as an element.
Setting it in an attribute, or as a comment, will no longer work.

As a side note: Beware of the sel-closing tag!
While `<div />` is perfectly legal HTML,
`<foo-component />` is not, and AngularJs' temaplting engine will
not be able to parse it.
Self-closing tags, also known as void tags,
are not allowed when defining custom element tags.

Next, we add `transclude`, like so:

        App.directive('fooComponent', function() {
            return {
                restrict: 'E',
                transclude: true,
                templateUrl: 'components/foo.html'
            };
        });

&hellip; and we modify the  template file at `components/foo.html`:

        <div>
            <div ng-transclude></div>
            <p>Foo component</p>
        </div>

Do not let the word translude scare you -
I think of it, simply, as *include with an outside transfer*.
All it really means is that we can now do this in the DOM:

        <foo-component>
            <p>Some text included from outside the component</p>
        </foo-component>

And `<p>` tag cointaining "Some text included from outside the component",
will get rendered within the `<div>` tag with the `ng-transclude` attribute.

The final step, and likely the most important one, is of scope isolation.
In any AngularJs template, the default behaviour is for the scope available
on any element to be available on any of its child elements.
This is because a child inherits its scope prototypically from its parent's scope.
Scope isolation is about using a directive on a child element,
telling it use a new scope.
It also allows ways in which select parts of the parent scope
may be passed into the child scope.
This is a crucial thing to do when building components,
as components are supposed to be modular;
thus, if a component is to be useful in a number of different situations,
where its parent's scopes may be different,
that component should define exactly what it needs to be in its scope.

The most basic syntax would be:

        App.directive('fooComponent', function() {
            return {
                restrict: 'E',
                transclude: true,
                scope: true,
                templateUrl: 'components/foo.html'
            };
        });

Setting `scope` to  `true` simplay indicates that this directive will use its own
scope, that is brand new, and thus isolated from its parent's scope.
This is not very useful,
unless the template for this directive does not need to bind to anything.
To create a more useful isolate scope:

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

&hellip; and we use the component like this in the DOM:

        <foo-component bar=myBar baz="{{myBaz}}">
            <p>Some text included from outside the component</p>
        </foo-component>

That would mean that the component's scope would contain:

- `bar` which contains the value of `myBar` on the parent scope.
  Whenever the parent scope or the component scope's value changes,
  the change propagates to the other (two-way binding)
- `baz` which contains the evaluated value of the expression `myBaz`
  on the parent scope.
  When the value of the parent scope changes, the value in the child scope changes too;
  however, when the value in the child scope changes, the value in the parent scope will remain the same.
  This is useful when you know that the child scope should *not* be able to
  update the parent scope, and therefore do not need to expend the extra
  effort for two-way binding (it is more computationally expensive).

THe most important thing to note here is that by defining isolate scopes,
we are effectively defining the interface required by the component,
which is important when creating modular components.

This has been a very simplified explanation of the concepts of
`restrict`, `transclude`, and `scope` isolation in AngularJs directives,.
These resources cover them in greater depth:

- [Creating components with AngularJs](http://blog.ijasoneverett.com/2013/03/creating-components-with-angular-js/)
- [Understanding Scopes - Directives](https://github.com/angular/angular.js/wiki/Understanding-Scopes#-directives)
