// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (YALTabBarViewAnimations)

+ (CAAnimation *)animationForAdditionalButton;
+ (CAAnimation *)animationForExtraLeftBarItem;
+ (CAAnimation *)animationForExtraRightBarItem;
+ (CAAnimation *)animationForTabBarExpandFromRect:(CGRect)fromRect toRect:(CGRect)toRect;
+ (CAAnimation *)animationForTabBarCollapseFromRect:(CGRect)fromRect toRect:(CGRect)toRect;
+ (CAAnimation *)animationForCenterButtonExpand;
+ (CAAnimation *)animationForCenterButtonCollapse;
+ (CAAnimation *)showSelectedDotAnimation;

@end
