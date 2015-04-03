// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import <UIKit/UIKit.h>

extern CGFloat const YALBottomSelectedDotDefaultSize;
extern CGFloat const YALBottomSelectedDotOffset;
extern CGFloat const YALTabBarViewDefaultHeight;
extern CGFloat const YALExtraTabBarItemsDefaultHeight;
extern CGFloat const YALForExtraTabBarItemsDefaultOffset;
extern UIEdgeInsets const YALTabBarViewHDefaultEdgeInsets;
extern UIEdgeInsets const YALTabBarViewItemsDefaultEdgeInsets;


extern CFTimeInterval const kYALExpandAnimationDuration;

typedef struct {
    CFTimeInterval beginTime;
    CFTimeInterval duration;
    double fromValue;
    double toValue;
    double damping;
    double velocity;
} YALAnimationParameters;

typedef struct {
    YALAnimationParameters scaleX;
    YALAnimationParameters scaleY;
    YALAnimationParameters rotation;
    YALAnimationParameters bounce;
} YALAdditionalButtonsAnimationsParameters;

typedef struct {
    YALAnimationParameters rotation;
    YALAnimationParameters bounce;
} YALCenterButtonAnimationsParameters;

typedef struct {
    NSTimeInterval duration;
    NSTimeInterval delay;
    CGFloat damping;
    CGFloat velocity;
    UIViewAnimationOptions options;
} YALExtraTabBarItemViewAnimationParameters;

typedef struct {
    YALAnimationParameters scaleX;
    YALAnimationParameters scaleY;
} YALSelectedDotAnimationsParameters;

extern YALAdditionalButtonsAnimationsParameters const kYALAdditionalButtonsAnimationsParameters;
extern YALSelectedDotAnimationsParameters const kYALSelectedDotAnimationsParameters;
extern YALAnimationParameters const kYALExtraLeftTabBarItemAnimationParameters;
extern YALAnimationParameters const kYALExtraRightTabBarItemAnimationParameters;
extern YALAnimationParameters const kYALTabBarExpandAnimationParameters;
extern YALAnimationParameters const kYALTabBarCollapseAnimationParameters;
extern YALCenterButtonAnimationsParameters const kYALCenterButtonExpandAnimationParameters;
extern YALCenterButtonAnimationsParameters const kYALCenterButtonCollapseAnimationParameters;
extern YALAnimationParameters const kYALBounceAnimationParameters;
extern YALExtraTabBarItemViewAnimationParameters const kYALShowExtraTabBarItemViewAnimationParameters;
extern YALExtraTabBarItemViewAnimationParameters const kYALHideExtraTabBarItemViewAnimationParameters;