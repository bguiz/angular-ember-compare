## Components in AngularJs

![Components in AngularJs](/images/angularjs-component.png)

AngularJs does not provide a direct construct for defining custom components.
It does, however, provide a lower-level construct - **directives** -
which can be used to create them.

Directives in AngularJs can be used to define the ways in which
JavaScript application code interacts with the DOM.
We have already seen some of these in action previously:
`ngModel`, `ngController`, and `ngClick`.
The templates know where code for these directives should be applied,
by inspecting DOM elements for the dash-erised versions of directives' names:
`ng-model`, `ng-controller`, and `ng-click`.

These are all built-in directives, that ship with AngularJs.
You can create your own too, using
[`App.directive()`](https://docs.angularjs.org/guide/directive#creating-directives),
and we will be doing just that to define our own component next:
`restrict`, `transclude` and isolate `scope`.
