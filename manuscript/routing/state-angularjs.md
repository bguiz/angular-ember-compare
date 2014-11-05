## Finite State Machine in AngularJs' Router

AngularJs' choice of a finite state machine places a significant impact on
its routing capability.

In traditional websites, most pages would share common sections,
such as the header, footer, navigation menu, and side bars.
The more complex ones shared more than that -
perhaps the site had several pages dedicated to "Games",
and several pages dedicated to "Stories".
All the "Games" pages would share a certain section,
that would not be present in the "Stories" pages.
Similarly, all the "Stories" pages would share a certain section,
that would not be present in any of the "Games" pages.

In AngularJs, you may apply the `ngView` directive to a DOM element.
When the URL changes, the router determines the new MVC state of the application,
and the contents of the `ngView` element are removed,
and rendered using the new MVC state.

Since the router is driven by a *finite* state machine under the hood,
there can only be one `ngView` rendered within the application at any time.
This, of course, precludes us from implementing the scenario above,
with the "Games" and "Stories" sections in the scenario described above.

### Workarounds

The techniques employed by AngularJs developers to get around this
generally fall into in one of two categories:

- Simply repeat the content in the templates, and code in the controllers,
  for the states with shared content
- Do not use AngularJs' router, and instead use a 3rd party library,
  [ui-router](https://github.com/angular-ui/ui-router),
  which provides an alternative router that uses a hierarchical state machine.

Some from the AngularJs core team have identified this as a problem,
and have drafted this proposal for
[router design in AngularJs 2.0](https://groups.google.com/forum/#!topic/angular-dev/mO6jmYhvsMk).
It draws inspiration from EmberJs' router, and a few others.
Thus, it appears that AngularJs may have support for this in
future versions, as there has been a significant community demand for this feature.
