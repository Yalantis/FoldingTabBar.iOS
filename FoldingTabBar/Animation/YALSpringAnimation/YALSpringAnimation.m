// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALSpringAnimation.h"
#import <UIKit/UIKit.h>

static const NSUInteger kNumberOfPoints = 500;
static const double kDampingMutiplier = 10;
static const double kVelocityMutiplier = 10;

double yal_normalizeAnimationValue(double value, double damping, double velocity);

@implementation YALSpringAnimation

+ (instancetype)animationWithKeyPath:(NSString *)keyPath
                            duration:(CFTimeInterval)duration
                             damping:(double)damping
                            velocity:(double)velocity
                           fromValue:(double)fromValue
                             toValue:(double)toValue
{
    YALSpringAnimation *animation = [self.class animationWithKeyPath:keyPath];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = duration;
    animation.values = [self animationValuesFromValue:fromValue
                                              toValue:toValue
                                          withDamping:damping
                                          andVelocity:velocity];
    return animation;
}

+ (instancetype)animationForRoundedRectPathWithduration:(CFTimeInterval)duration
                                                damping:(double)damping
                                               velocity:(double)velocity
                                              fromValue:(CGRect)fromValue
                                                toValue:(CGRect)toValue
{
    YALSpringAnimation *animation = [self.class animationWithKeyPath:@"path"];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = duration;
    animation.values = [self animationValuesForPathFromValue:fromValue
                                                     toValue:toValue
                                                 withDamping:damping
                                                 andVelocity:velocity];
    return animation;
}

+ (NSArray *)animationValuesForPathFromValue:(CGRect)fromValue
                                     toValue:(CGRect)toValue
                                 withDamping:(double)damping
                                 andVelocity:(double)velocity
{
    NSArray *xValues = [self animationValuesFromValue:fromValue.origin.x
                                             toValue:toValue.origin.x
                                         withDamping:damping
                                         andVelocity:velocity];
    NSArray *widthValues = [self animationValuesFromValue:fromValue.size.width
                                                  toValue:toValue.size.width
                                              withDamping:damping
                                              andVelocity:velocity];
    NSMutableArray *pathValues = [NSMutableArray new];
    CGFloat cornerRadius = fromValue.size.height / 2.f;
    CGRect rect = fromValue;
    
    for (NSInteger i = 0; i < xValues.count; ++i) {
        CGFloat x = [(NSNumber *)xValues[i] floatValue];
        CGFloat width = [(NSNumber *)widthValues[i] floatValue];
        
        rect.origin.x = x;
        rect.size.width = width;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
        [pathValues addObject:(id)path.CGPath];
    }
    
    return [NSArray arrayWithArray:pathValues];
}

/*
 *  code below borrowed SpringAnimation.swift from:https://github.com/evgenyneu/SpringAnimationCALayer
 */

+ (NSArray *)animationValuesFromValue:(double)fromValue
                              toValue:(double)toValue
                          withDamping:(double)damping
                          andVelocity:(double)velocity
{
    NSMutableArray *values = [NSMutableArray new];
    CGFloat distanceBetweenValues = toValue - fromValue;
    velocity *= kVelocityMutiplier;
    damping *= kDampingMutiplier;
    
    for (double i = 0; i < kNumberOfPoints; ++i) {
        double x = i / kNumberOfPoints;
        double normalizedValue = yal_normalizeAnimationValue(x, damping, velocity);
        double value = toValue - distanceBetweenValues * normalizedValue;
        [values addObject:@(value)];
    }
    
    //  with different arguments alghorithm above produces values where
    //  last values not equal to toValue therefore line below is required(not a perfect fix for issue but will do for now)
    [values addObject:@(toValue)];
    
    return [NSArray arrayWithArray:values];
}

@end

double yal_normalizeAnimationValue(double value, double damping, double velocity) {
    return pow(M_E, -damping * value) * cos(velocity * value);
}
