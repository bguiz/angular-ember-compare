## Components

Browsers used to display documents -
that is content that had text formatting and images.
Web pages used to be simply what you could create using a word processor,
or see printed on a newspaper,
expect that it was delivered over the Internet,
and displayed on a computer screen.
They are much more than that now, however.
Web pages are interactive, and can respond to the user in ways
that a newspaper cannot.
Some are so advanced in these types of interactions that the phrase,
"web page" no longer seems an apt description -
we call them *web applications*, or *web applications*.

The typical thing that we create with AngularJs and EmberJs are most certainly
not web pages any longer,
and fall squarely into the web application category.
That being said, the HTML that we implement our applications in is still very much
designed around syntax used to describe *document*s.
This makes things tricky for the developer,
because over the years, we have created workaround after workaround
to continue making this document-oriented syntax continue working for us.

Thankfully, the standards body that governs HTML recognises this,
and is evolving its specifications to keep up with how HTML is being used.
The [Web Components Specification](http://www.w3.org/TR/components-intro/)
is a draft specification, which describes a way in which we can
create *components* that can be thought of as a building block,
which contains a HTML template, CSS styles, and JavaScript behaviour.

Web components, however, are not yet available -
but both AngularJs and EmberJs provide their own ways to create components
that behave very similarly to web components,

### Components in AngularJs

AngularJs does not provide a direct construct for defining custom components.
It does, however, provide a lower-level construct - directives -
which can be used to create them.

Directives in AngularJs can be used to define they ways in which
JavaScript application code interacts with the DOM.
We have already seen some of these in action in the previous articles:
`ngModel`, `ngController`, and `ngClick`.
The templates know where code for these directives should be applied,
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

All this does is take the template at `components/foo.html`
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

As a side note: Beware of the self-closing tag!
While `<div />` is perfectly legal HTML,
`<foo-component />` is not, and AngularJs' templating engine will
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

Do not let the word transclude scare you -
I think of it, simply, as *include with an outside transfer*.
All it really means is that we can now do this in the DOM:

        <foo-component>
            <p>Some text included from outside the component</p>
        </foo-component>

And `<p>` tag containing "Some text included from outside the component",
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

Setting `scope` to  `true` simply indicates that this directive will use its own
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

The most important thing to note here is that by defining isolate scopes,
we are effectively defining the interface required by the component,
which is important when creating modular components.

This has been a very simplified explanation of the concepts of
`restrict`, `transclude`, and `scope` isolation in AngularJs directives,.
These resources cover them in greater depth:

- [Creating components with AngularJs](http://blog.ijasoneverett.com/2013/03/creating-components-with-angular-js/)
- [Understanding Scopes - Directives](https://github.com/angular/angular.js/wiki/Understanding-Scopes#-directives)

### Components in EmberJs

The bare minimum syntax for an EmberJs component would be to simply create a template,
according to the naming conventions:

        {{!-- components/the-foo --}}
        <div>
            <p>The Foo</p>
        </div>

The naming convention is that they be prefixed with `components/`,
and the name must contain at least one hyphen (`-`).

In the DOM, we use a Handlebars helper with the same name as the component:

        {{the-foo}}

All this does however, is render one template within another -not very useful!
We want to be able to do the same three things that we did with the AngularJs directive:

- Use elements to represent the component in the DOM (element restriction)
- Display content from the outer template within the component (transclusion)
- Pass in select models or attributes from the outer template to the component (scope and scope isolation)

This is quite easily achieved:

        {{!-- components/the-foo --}}
        <div>
            <p>The Foo. Bar is: {{foo.bar}}</p>
            {{yield}}
        </div>

&hellip; and in the DOM:

        {{#the-foo foo=model}}
            <p>Some text included from outside the component</p>
        {{/the-foo}}

In EmberJs, we use a string-based templating language, Handlebars,
as opposed to a DOM-based templating language.
Thus, we will not ever write, in the DOM,
tags names that match the custom component names;
instead we use Handlebars helpers, in this case `{{the-foo}}`.

We display content from the outer template within the component,
simply by using the `{{yield}}` Handlebars helper.

We pass in select attributes from the outer template into the component by
defining those attributes within the Handlebars helper invoking the component.
This is the only part which requires some custom code.

        App.TheFooComponent = Ember.Component.extend({
            attributeBindings: ['foo']
        });

We create an object that extends `Ember.Component`,
according to the naming conventions,
and define which properties should be bound by the component
using the `attributeBindings` property.

All in all, extremely straight forward,
the trickiest part is getting the naming conventions right!
The [documentation for `Ember.Component`](http://emberjs.com/api/classes/Ember.Component.html)
is a good reference.

### Discussion

In comparing the various aspects of these two SPA frameworks so far,
in every single point of comparison,
EmberJs' offering has been significantly more complicated -
and harder to learn - than its AngularJs counterpart.
With components, however, the opposite is true,
with the learning curve for creating custom components in AngularJs
being far steeper than for creating custom components in EmberJs.
This is because AngularJs' offering is low-level, and more flexible.
In EmberJs, most decision have been made for you -
they can be thought of as
["element-restricted, isolate-scoped, transcluded directives"](http://docs.google.com/presentation/d/1e0z1pT9JuEh8G5DOtib6XFDHK0GUFtrZrU3IfxJynaA/present?slide=id.g177e4bd2b_0400).

While AngularJs does not provide a *component* per se,
it does provide a means to create them by combining a number of lower level concepts,
on AngularJs directives.
By combining them together in a certain pattern,
one can create components.
However, the developer is also free to do something else entirely,
and combine them in a different way, or treat some as optional,
and this flexibility allows for more specific needs to be catered to.

EmberJs components, on the other hand,
provide something very close to the web components specification out of the box,
and the developer merely has to extend `Ember.Component`
to get all this functionality.

Both AngularJs and EmberJs have plans to make their frameworks support the
web components specifications, when it comes out of draft status.
Miško Hevery has written about plans to [make web components work seamlessly with AngularJs directives](https://groups.google.com/forum/#!msg/polymer-dev/4RSYaKmbtEk/uYnY3900wpIJ).
Yehuda Katz, [describes plans for Web Components in EmberJs](https://gist.github.com/wycats/9144666b0c606d1838be),
and a concrete plan for "how Ember could adopt semantics similar to web components."

Knowing that both frameworks are aligned with the specifications is good,
because applications that are developed with these frameworks will themselves
will already be largely compliant with these standards,
and gain the benefits from inherent from being so,
such as future cross-browser support and portability.
