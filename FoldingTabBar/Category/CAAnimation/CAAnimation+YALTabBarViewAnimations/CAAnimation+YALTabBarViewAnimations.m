// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "CAAnimation+YALTabBarViewAnimations.h"
#import "YALSpringAnimation.h"
#import "YALAnimatingTabBarConstants.h"

@implementation CAAnimation (YALTabBarViewAnimations)

#pragma mark - Additional buttons animations

+ (CAAnimation *)animationForAdditionalButton {
    CABasicAnimation *scaleX = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleX.fromValue = @(kYALAdditionalButtonsAnimationsParameters.scaleX.fromValue);
    scaleX.toValue = @(kYALAdditionalButtonsAnimationsParameters.scaleX.toValue);
    scaleX.duration = kYALAdditionalButtonsAnimationsParameters.scaleX.duration;
    
    CABasicAnimation *scaleY = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.fromValue = @(kYALAdditionalButtonsAnimationsParameters.scaleY.fromValue);
    scaleY.toValue = @(kYALAdditionalButtonsAnimationsParameters.scaleY.toValue);
    scaleY.duration = kYALAdditionalButtonsAnimationsParameters.scaleY.duration;
  
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.fromValue = @(kYALAdditionalButtonsAnimationsParameters.rotation.fromValue);
    rotation.toValue = @(kYALAdditionalButtonsAnimationsParameters.rotation.toValue);
    rotation.duration = kYALAdditionalButtonsAnimationsParameters.rotation.duration;
    rotation.fillMode = kCAFillModeForwards;
    rotation.removedOnCompletion = NO;
    
    YALSpringAnimation *bouncedRotation = [self rotationBouncedAnimationFromValue:kYALAdditionalButtonsAnimationsParameters.bounce.fromValue
                                                                          toValue:kYALAdditionalButtonsAnimationsParameters.bounce.toValue];
    bouncedRotation.beginTime = kYALAdditionalButtonsAnimationsParameters.bounce.beginTime;
    
    return [self groupWithAnimations:@[scaleX, scaleY, rotation, bouncedRotation] andDuration:kYALExpandAnimationDuration];
}

#pragma mark - Extra buttons animations

+ (CAAnimation *)animationForExtraLeftBarItem {
    return [YALSpringAnimation animationWithKeyPath:@"transform.rotation.z"
                                           duration:kYALExtraLeftTabBarItemAnimationParameters.duration
                                            damping:kYALExtraLeftTabBarItemAnimationParameters.damping
                                           velocity:kYALExtraLeftTabBarItemAnimationParameters.velocity
                                          fromValue:kYALExtraLeftTabBarItemAnimationParameters.fromValue
                                            toValue:kYALExtraLeftTabBarItemAnimationParameters.toValue];
}

+ (CAAnimation *)animationForExtraRightBarItem {
    return [YALSpringAnimation animationWithKeyPath:@"transform.rotation.z"
                                           duration:kYALExtraRightTabBarItemAnimationParameters.duration
                                            damping:kYALExtraRightTabBarItemAnimationParameters.damping
                                           velocity:kYALExtraRightTabBarItemAnimationParameters.velocity
                                          fromValue:kYALExtraRightTabBarItemAnimationParameters.fromValue
                                            toValue:kYALExtraRightTabBarItemAnimationParameters.toValue];
}

#pragma mark - Tab bar view animations

+ (CAAnimation *)animationForTabBarExpandFromRect:(CGRect)fromRect toRect:(CGRect)toRect {
    return [YALSpringAnimation animationForRoundedRectPathWithduration:kYALTabBarExpandAnimationParameters.duration
                                                               damping:kYALTabBarExpandAnimationParameters.damping
                                                              velocity:kYALTabBarExpandAnimationParameters.velocity
                                                             fromValue:fromRect
                                                               toValue:toRect];
}

+ (CAAnimation *)animationForTabBarCollapseFromRect:(CGRect)fromRect toRect:(CGRect)toRect {
    return [YALSpringAnimation animationForRoundedRectPathWithduration:kYALTabBarCollapseAnimationParameters.duration
                                                               damping:kYALTabBarCollapseAnimationParameters.damping
                                                              velocity:kYALTabBarCollapseAnimationParameters.velocity
                                                             fromValue:fromRect
                                                               toValue:toRect];
}

#pragma mark - Center button animation

+ (CAAnimation *)animationForCenterButtonExpand {
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.fromValue = @(kYALCenterButtonExpandAnimationParameters.rotation.fromValue);
    rotation.toValue = @(kYALCenterButtonExpandAnimationParameters.rotation.toValue);
    rotation.duration = kYALCenterButtonExpandAnimationParameters.rotation.duration;
    rotation.fillMode = kCAFillModeForwards;
    rotation.removedOnCompletion = NO;
    
    YALSpringAnimation *bouncedRotation = [self rotationBouncedAnimationFromValue:kYALCenterButtonExpandAnimationParameters.bounce.fromValue
                                                                          toValue:kYALCenterButtonExpandAnimationParameters.bounce.toValue];
    bouncedRotation.beginTime = kYALCenterButtonExpandAnimationParameters.bounce.beginTime;
    
    return [self groupWithAnimations:@[rotation, bouncedRotation] andDuration:kYALExpandAnimationDuration];
}

+ (CAAnimation *)animationForCenterButtonCollapse {
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.fromValue = @(kYALCenterButtonCollapseAnimationParameters.rotation.fromValue);
    rotation.toValue = @(kYALCenterButtonCollapseAnimationParameters.rotation.toValue);
    rotation.duration = kYALCenterButtonCollapseAnimationParameters.rotation.duration;
    rotation.fillMode = kCAFillModeForwards;
    rotation.removedOnCompletion = NO;

    YALSpringAnimation *bouncedRotation = [self rotationBouncedAnimationFromValue:kYALCenterButtonCollapseAnimationParameters.bounce.fromValue
                                                                          toValue:kYALCenterButtonCollapseAnimationParameters.bounce.toValue];
    bouncedRotation.beginTime = kYALCenterButtonCollapseAnimationParameters.bounce.beginTime;
    
    return [self groupWithAnimations:@[rotation, bouncedRotation] andDuration:kYALExpandAnimationDuration];
}

+ (CAAnimation *)showSelectedDotAnimation {
    CABasicAnimation *scaleX = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleX.fromValue = @(kYALSelectedDotAnimationsParameters.scaleX.fromValue);
    scaleX.toValue = @(kYALSelectedDotAnimationsParameters.scaleX.toValue);
    scaleX.duration = kYALSelectedDotAnimationsParameters.scaleX.duration;
    
    CABasicAnimation *scaleY = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.fromValue = @(kYALSelectedDotAnimationsParameters.scaleY.fromValue);
    scaleY.toValue = @(kYALSelectedDotAnimationsParameters.scaleY.toValue);
    scaleY.duration = kYALSelectedDotAnimationsParameters.scaleY.duration;
    
    return [self groupWithAnimations:@[scaleX, scaleY] andDuration:kYALExpandAnimationDuration / 2];
}

#pragma mark - Helpers -

#pragma mark Group

+ (CAAnimationGroup *)groupWithAnimations:(NSArray *)animations andDuration:(CFTimeInterval)duration {
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = duration;
    group.animations = animations;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    return group;
}

#pragma mark Rotation bounce animation

+ (YALSpringAnimation *)rotationBouncedAnimationFromValue:(double)fromValue toValue:(double)toValue {
    return [YALSpringAnimation animationWithKeyPath:@"transform.rotation.z"
                                           duration:kYALBounceAnimationParameters.duration
                                            damping:kYALBounceAnimationParameters.damping
                                           velocity:kYALBounceAnimationParameters.velocity
                                          fromValue:fromValue
                                            toValue:toValue];
}

@end
