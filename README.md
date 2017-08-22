# TipIt

`TipIt` is a tip calculator for iOS.
Submitted by: Nicholas Park
Time spent: **12** hours spent total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)

The following **additional** features are implemented:
* [x] There is a tableview with the calculated tip and total for each individual based on the number of people

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://imgur.com/a/QCgG4' title='Video Walkthrough' width='' alt='Video Walkthrough' /> (http://imgur.com/a/QCgG4)

GIF created with [LiceCap](http://www.cockos.com/licecap/).


## Project Analysis

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** I feel that the iOS app development platform is very fast compared to other software on the market. It is very visual and allows for the code and UI to be developed in tandem. `Outlets` are objects that storyboard views are connected to by the `InterfaceBuilder` based on the id found in their xml. The ids are assigned automatically when control dragged from the storyboard to the file itself. `IBAction`s are similar in that the `InterfaceBuilder` matches methods from the storyboard to the `ibactions` in the designated viewcontroller file.

**Question 2**: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** The `arc` can only free up memory when instances have no references to them. The issue with closures is that if you set a reference to a closure that has a reference to `self` inside of the closure, you get a circular reference where the closure has a strong reference to the class and the class has a strong reference to the closure. The ARC sees the strong reference and can't fee up memory even when neither are needed or indeed being used. One way to resolve it is to make the references `weak` which become nil when the thing they refer to is deallocated. That way if the class the closure is referencing becomes deallocated, the closure's reference to it (being weak) becomes nil. 
