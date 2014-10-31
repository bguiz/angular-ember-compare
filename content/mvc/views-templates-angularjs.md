### Templates in AngularJs

![Views in AngularJs](/img/angularjs-view.png)

Syntax:

        <body ng-controller="FooController">
            <input ng-model="foo" value="bar">
            <button ng-click="changeFoo()">{{buttonText}}</button>
        </body>

AngularJs uses a DOM-based templating mechanism.
This means that the templates are the rendered HTML.
When the application runs, the elements are rendered with
the original contents of the template.
Subsequently, AngularJs kicks in, and traverse the entire DOM tree,
inspecting for special decorations,
and then modifies the DOM according to the desired behaviour.
In fact, if you are quick - or set some break points -
you will notice a flicker between the two.

The special decorations that it looks out for are:

- Directives
    - Elements or attributes that link to modules known to AngularJs
    - AngularJs comes with several built in directives,
      and all of them are prefixed with `ng-`\*
    - The developer may also define his own custom directives
- Markup
    - Any part of the markup which appears between double squiggly braces,
      `{{like this}}`
    - AngularJs evaluates the expression within these braces,
      and substitutes it for the result

AngularJs allows for an extremely expressive syntax to be added to the
expressions within the templates,
including JavaScript expression,
and filters using a UNIX-style pipe (`|`) syntax.
