# Controllers

![Controllers in SPAs](/images/spa-controller.png)

Controllers are the final piece of the MVC puzzle.
They are the glue that binds models to views/ templates.
Their responsibilities include manipulating models,
as well as responding to user interactions on the view.

Now, when these tasks performed separately, these are not particularly interesting.
However, their real utility becomes apparent when they interact with
both models and views simultaneously.
For example, the user might click a button rendered by a view,
that triggers an action on the controller,
which modifies a model.
Then some of the attributes that have changed on the model are bound
by the template, and the view is notified of this change,
and the relevant section of the DOM is re-rendered.

In this sequence of events, the controller is what sits in between
the model and the view, passing the appropriate messages between them,
enabling all this to happen.

![Model-View-Controller interactions](/images/200px-MVC-Process.svg.png)

Unlike some of their older SPA framework counterparts,
both AngularJs and EmberJs support **two-way** binding.
That is:

1. When the model state changes,
   if any parts of the view are bound to the part of the model that has changed,
   those parts of the view are re-rendered.
2. When the view state changes,
   if those parts of the view are bound to parts of the model,
   those parts of the model are changed.
