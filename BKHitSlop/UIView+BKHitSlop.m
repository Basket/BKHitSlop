// Copyright (c) 2014-present 650 Industries, Inc. All rights reserved.

#import "UIView+BKHitSlop.h"

@import ObjectiveC;

static const void *UIViewBKHitSlopKey = "UIViewBKHitSlopKey";

static IMP __original_pointInside_withEvent_;
BOOL __swizzled_pointInside_withEvent_(UIView *self, SEL _cmd, CGPoint point, UIEvent *event);

@implementation UIView (BKHitSlop)

- (UIEdgeInsets)bk_hitSlop
{
    NSValue *value = objc_getAssociatedObject(self, UIViewBKHitSlopKey);
    if (value) {
        return [value UIEdgeInsetsValue];
    } else {
        return UIEdgeInsetsZero;
    }
}

- (void)bk_setHitSlop:(UIEdgeInsets)hitSlop
{
    NSValue *value = [NSValue valueWithUIEdgeInsets:hitSlop];
    objc_setAssociatedObject(self, UIViewBKHitSlopKey, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // The right way to swizzle, according to http://blog.newrelic.com/2014/04/16/right-way-to-swizzle/
        Method pointInside_withEvent_ = class_getInstanceMethod([UIView class], @selector(pointInside:withEvent:));
        __original_pointInside_withEvent_ = method_setImplementation(pointInside_withEvent_, (IMP)__swizzled_pointInside_withEvent_);
    });
}

@end

BOOL __swizzled_pointInside_withEvent_(UIView *self, SEL _cmd, CGPoint point, UIEvent *event) {

    BOOL pointInside = ((BOOL(*)(id, SEL, CGPoint, UIEvent *))__original_pointInside_withEvent_)(self, _cmd, point, event);
    if (pointInside) {
        return YES;
    }

    CGRect bounds = self.bounds;
    CGRect sloppedRect = UIEdgeInsetsInsetRect(bounds, self.bk_hitSlop);
    return CGRectContainsPoint(sloppedRect, point);
}
