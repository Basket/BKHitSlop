# BKHitSlop

## Installation

1. Add BKHitSlop to your Podfile.
2. In your terminal, run `pod install`.

## Usage


1. Add `#import <BKHitSlop/BKHitSlop.h>` to your source file (or to your prefix header, if you want to access it anywhere in your project).
2. Implement the method `myButton.bk_hitSlop = UIEdgeInsetsMake(-50, -50, -50, -50);
` on your button (or other UIView) - or your preferred UIEdgeInsets value. Negative values are ignored.

## FAQ

**Q:** How does it work?  
**A:** Simple! UIViews have a method `-pointInside:withEvent:` which decides whether an event's point (presumably, a touch's point) lies inside itself. When you touch the screen, the UIView hierarchy queries for the "best" view to respond to that touch. BKHitSlop swaps the implementation out for our own. This is (mostly) safe.

When you set the hit slop, first, we check if the point would normally be considered inside the view, according to the original implementation - if so, we just short-circuit and return YES. Otherwise, the views' bounds are inset by the UIEdgeInsets value.

_Aside: This is why the inset's components don't have any effect unless negative. Note that a negative inset goes **outward** rather than **inward**._

Anyways, once we've done that to figure out the new rectangle to test, we use `CGRectContainsPoint` to see if the point is inside that rectangle.
