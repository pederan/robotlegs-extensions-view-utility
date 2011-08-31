As you can see there is not put any effort into design or "feel".
These examples are purely for showing the various features of the utility. 
It is up to you to take advantage of the utility so you can spend more time in making your application shine. 

Example 1 : Simple example showing
- View animation (animation- in and out)
- Response to stage resize (onStageResize())
- Navigating from one view to another
- Adding a view with constructor parameters 
- Map a listener to a button and reacting to mouse click event (mapButtonToView())
- Swapping views (swapView())
- Avoid a view to be removed even though it receives a remove signal (autoRemove set to false)

Example 2 : More advanced example demonstrating many of the features including:
- Using command to setup the view/container mapping
- Mapping a button click so that it a view is created on click (mapbuttonToView())
- Adding and swapping view between different contexts - deeplinking (addView(), swapView() or addChild())
- Remove views by passing class type (removeView)
- Remove view at a spesific context (removeAllViewsAtContext)
- Center position content (onStageResized)
- Listen to view added- and view removed signals
- Cleaning up the listeners in abstract method (destroy())

Example 3 : Extending the ComponentViewMediator
- Calling a view from a mediator extending ComponentViewMediator