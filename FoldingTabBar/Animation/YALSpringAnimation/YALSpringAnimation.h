// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import <QuartzCore/QuartzCore.h>

@interface YALSpringAnimation : CAKeyframeAnimation

+ (instancetype)animationWithKeyPath:(NSString *)keyPath
                            duration:(CFTimeInterval)duration
                             damping:(double)damping
                            velocity:(double)velocity
                           fromValue:(double)fromValue
                             toValue:(double)toValue;

+ (instancetype)animationForRoundedRectPathWithduration:(CFTimeInterval)duration
                                                damping:(double)damping
                                               velocity:(double)velocity
                                              fromValue:(CGRect)fromValue
                                                toValue:(CGRect)toValue;

@end
