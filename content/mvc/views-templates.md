### Templates

![Views in SPAs](/img/spa-view.png)

However, almost all of them include one more feature in the same vein:
the template.
Templating, strictly speaking, is one of the responsibilities of a view in MVC,
however, they are large and complex enough to warrant a discussion on their own.
This is because all web applications - both traditional and single page -
ultimately need to render HTML, which is a document format.

Templates are essentially files with special syntax that allow the developer
to specify the logic with which to render the HTML.
This template typically has two inputs, one static, and the other dynamic.
The static inputs to the template are the bits that render HTML without any
change in between no matter the context.
The dynamic inputs to the template are the bits that render HTML differently
based on context.

In both AngularJs and EmberJs, the static inputs are pure HTML -
write them as you would a regular HTML document.
Similarly, in both frameworks, the dynamic inputs are identified as any parts
in between `{{` and `}}` (double squiggly brackets). <super>\*</super>

&nbsp;<super>\*</super> With AngularJs, in addition to this,
some dynamic input may be identified by `ng-`\* attributes,
and any custom designed directives added by the developer.
