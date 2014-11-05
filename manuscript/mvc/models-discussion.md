## Discussion

We have taken a look at how to use models, and how to sync them with a server,
in both AngularJs and EmberJs.
There are quite a few significant differences between them.

As we will soon see,
AngularJs and EmberJs have different philosophies regarding opinionation.
AngularJs leans towards providing many different ways to accomplish any one task,
letting the developer choose which one fits their needs best.
Providing multiple ways to do sync models with the server is exactly what
you would expect.

EmberJs, on the other hand, leans towards choosing the one best,
or [*omakase*](https://twitter.com/tomdale/status/285821254928322561 "Omakase (お任せ, o-makase) is a Japanese phrase that means I'll leave it to you (from Japanese to entrust (任せる, makaseru))."),
way of doing a particular task,
and requiring all developers to follow that.
In most facets of a SPA framework,
the EmberJs team has come up with this *omakase* way to do things.
However, it appears that they are still figuring out the best way
for how to sync models with the server.
Having different ways to accomplish this runs orthogonal to this philosophy.

The most significant difference between AngularJs models and EmberJs models,
is the mechanism that each framework uses to observe changes on them.
The pros and cons of the approach chosen by each framework:

- AngularJs uses dirty checking:
    - Dead simple syntax (identical to POJSOs)
    - Incurs a heavy performance penalty when number of models is large, or when for models are complex
- EmberJs uses wrapper objects with accessors
    - More complex, verbose syntax
    - Incurs a much lighter performance penalty when number of models for model complexity becomes large

When the draft specification for `Object.observe()` gets formalised,
we will expect all of this to change,
as it will obviate the need for both wrapper objects with accessors, and dirty checking.

Models, however, are not very useful on their own.
Users cannot interact with them.
In order to display models, we need views, the *V* in MVC,
and we will be taking a look at them next.
