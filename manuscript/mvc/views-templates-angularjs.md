## Templates in AngularJs

![Views in AngularJs](/images/angularjs-view.png)

### Syntax

```html
<body ng-controller="FooController">
    <input ng-model="foo" value="bar">
    <button ng-click="changeFoo()">{{buttonText}}</button>
</body>
```

AngularJs uses a DOM-based templating mechanism.
This means that the templates **are** the rendered HTML.
When the application runs, the elements are first rendered with
the **original contents** of the template.

Subsequently, AngularJs kicks in, and traverses the entire DOM tree,
looking out for for special decorations,
and then modifies the DOM according to these decorations.
In fact, if you are quick (or cheat by setting some break points),
you will notice a flicker between the two.

The special decorations that it looks out for are:

- Directives
    - Elements or attributes that link to modules known to AngularJs
    - AngularJs comes with several built in directives,
      and all of them are prefixed with `ng-`\*
    - The developer may also define his own custom directives.
      We cover this  in [components](/components/components-angularjs-directives.html).
- Markup
    - Any part of the markup which appears between double squiggly braces,
      `{{like this}}`
    - AngularJs evaluates the expression within these braces,
      and substitutes it for the result

AngularJs allows for an extremely expressive syntax to be added to the
expressions within the templates,
including a limited subset of JavaScript expressions,
and filters using a UNIX-style pipe (`|`) syntax.
