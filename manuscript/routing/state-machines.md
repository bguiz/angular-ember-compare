## Routing and State Machines

State machines are a mathematical concept which has found practical application
in a number of things ranging from circuit board design to -
you guessed it - routing in single page applications.

There are two main types of state machines that are of interest to us
in this context:
- [finite state machines](http://en.wikipedia.org/wiki/Finite-state_machine)
and
- [hierarchical state machines](http://en.wikipedia.org/wiki/UML_state_machine#Hierarchically_nested_states).

### Finite State

A Finite State Machine is one that defines a number of states that
an application (the *machine*), can be in.
The application is only allowed to be in one state at any point of time.
The finite state machine also must define a series of transitions,
between one state and another, and the triggering conditions for each of them.

### Hierarchical State

A hierarchical state machine is a more **complex version** of a finite state machine.
It allows any state to define an entire finite state machine within itself.
This may be done recursively, and the end result is a **hierarchy of states**.
The same rules regarding states and transitions still apply,
however due to the hierarchy, there is one interesting property -
there may be more than one state active at a time.
Between sibling states in one finite state machine,
only one of them may be active at any one point of time, and this still holds true.
However, if this state contains a finite state machine of its own,
amongst its child states, one of them is allowed to be active as well.

This is all rather theoretical - what is the application of
state machines to single page applications?

Routers are objects that provide routing functionality.
Both AngularJs and EmberJs have implemented their routers using state machines.

The router objects store the URL and MVC state for each route in the application
in a state machine.

### Managing Transitions and Demarcation

The state machine is particularly useful in **managing transitions** between one
route and another; in particular,
transitions come in handy too add hooks to set up or tear down each state.
This would include things like re-rendering a section of the DOM,
and adding/ removing listeners.
These are key parts of "*plumbing*" type of work that SPA
frameworks take care of -
the grunt work that happens behind the scenes that would be very tedious
(not to mention boring) to do by hand each time.
Tedious, but extremely important.
It ensures that at any point of time,
the state is fully one *or* another,
and not in some indeterminate or in-between state that could be hard to recover from.

State machines also make it easier to ensure that the application is **performant**,
and does not suffer from things such as memory leaks
due to stale event listeners for DOM elements that no longer exist,
by demarcating clear entry and exit points where set ups and tear downs need to take place.
