## Views

So if templates handle all the rendering, what is left for the view to do?

As it turns out, in both AngularJs and EmberJs,
the developer will rarely ever have to touch the views.
This is because they are "batteries included",
taking care of most of the heavy lifting for us:

- Deciding when to render the templates
- Two-way binding
- Event handling/ proxying/ bubbling

This will come as a breath of fresh air for those who have
developed web apps using BackboneJs,
as it is just one of those tedious things that you will not have to do any more.
However, the developer will have to use views when they are doing something
more advanced, such as:

- Integrating with a 3rd party library that does not provide a AngularJs or EmberJs wrapper
- Do something specific upon completion of rendering
- Inheriting or using mixins to share code between several views or other classes

We shall take a brief look at views, and then focus on templates.
