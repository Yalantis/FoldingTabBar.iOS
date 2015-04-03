// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALAnimatingTabBarConstants.h"

CGFloat const YALBottomSelectedDotDefaultSize = 4.f;
CGFloat const YALBottomSelectedDotOffset = 16.f;
CGFloat const YALTabBarViewDefaultHeight = 80.f;
CGFloat const YALExtraTabBarItemsDefaultHeight = 48.f;
CGFloat const YALForExtraTabBarItemsDefaultOffset = 15.f;
UIEdgeInsets const YALTabBarViewHDefaultEdgeInsets = {10.f, 14.f, 10.f, 14.f};
UIEdgeInsets const YALTabBarViewItemsDefaultEdgeInsets = {0.f, 0.f, 0.f, 0.f};


CFTimeInterval const kYALExpandAnimationDuration = 1.0;

CGFloat const kDegreeToRadiansRatio = M_PI / 180.f;

YALAnimationParameters const kYALBounceAnimationParameters = (YALAnimationParameters) {
    .duration = kYALExpandAnimationDuration * 2.0 / 3.0,
    .damping = 0.5,
    .velocity = 3.0
};

YALAnimationParameters const kYALExtraLeftTabBarItemAnimationParameters = (YALAnimationParameters) {
    .duration = kYALExpandAnimationDuration * 3.0 / 4.0,
    .damping = 0.74,
    .velocity = 1.2,
    .fromValue = 0.0,
    .toValue = M_PI * 2.0 * 2.0
};

YALAnimationParameters const kYALExtraRightTabBarItemAnimationParameters = (YALAnimationParameters) {
    .duration = kYALExpandAnimationDuration * 3.0 / 4.0,
    .damping = 0.74,
    .velocity = 1.2,
    .fromValue = 0.0,
    .toValue = M_PI * 2.0 * -2.0
};

YALAnimationParameters const kYALTabBarExpandAnimationParameters = (YALAnimationParameters) {
    .duration = kYALExpandAnimationDuration / 2.0,
    .damping = 0.5,
    .velocity = 0.6
};

YALAnimationParameters const kYALTabBarCollapseAnimationParameters = (YALAnimationParameters) {
    .duration = kYALExpandAnimationDuration * 0.6,
    .damping = 1,
    .velocity = 0.2
};

YALCenterButtonAnimationsParameters const kYALCenterButtonExpandAnimationParameters = (YALCenterButtonAnimationsParameters) {
    .rotation = (YALAnimationParameters) {
        .duration = kYALExpandAnimationDuration / 4.0,
        .fromValue = 0.0,
        .toValue = M_PI * 2.0 + 45.0 * kDegreeToRadiansRatio
    },
    .bounce = (YALAnimationParameters) {
        .beginTime = kYALExpandAnimationDuration / 4.0,
        .fromValue = 45.0 * kDegreeToRadiansRatio + M_PI / 8.0,
        .toValue = 45.0 * kDegreeToRadiansRatio
    }
};

YALCenterButtonAnimationsParameters const kYALCenterButtonCollapseAnimationParameters = (YALCenterButtonAnimationsParameters) {
    .rotation = (YALAnimationParameters) {
        .duration = kYALExpandAnimationDuration / 4.0,
        .fromValue = 0.0,
        .toValue = 315.0 * kDegreeToRadiansRatio
    },
    .bounce = (YALAnimationParameters) {
        .beginTime = kYALExpandAnimationDuration / 4.0,
        .fromValue = M_PI / 8.0,
        .toValue = 0.0
    }
};

YALSelectedDotAnimationsParameters const kYALSelectedDotAnimationsParameters =
(YALSelectedDotAnimationsParameters) {
    .scaleX = (YALAnimationParameters) {
        .duration = kYALExpandAnimationDuration / 4.0,
        .fromValue = 0.0,
        .toValue = 1.0
    },
    .scaleY = (YALAnimationParameters) {
        .duration = kYALExpandAnimationDuration / 4.0,
        .fromValue = 0.0,
        .toValue = 1.0
    }
};

YALAdditionalButtonsAnimationsParameters const kYALAdditionalButtonsAnimationsParameters = (YALAdditionalButtonsAnimationsParameters) {
    .scaleX = (YALAnimationParameters) {
        .duration = kYALExpandAnimationDuration / 4.0,
        .fromValue = 0.0,
        .toValue = 1.0
    },
    .scaleY = (YALAnimationParameters) {
        .duration = kYALExpandAnimationDuration / 4.0,
        .fromValue = 0.0,
        .toValue = 1.0
    },
    .rotation = (YALAnimationParameters) {
        .duration = kYALExpandAnimationDuration / 4.0,
        .fromValue = 0.0,
        .toValue = M_PI * 2.0 * 5.0
    },
    .bounce = (YALAnimationParameters) {
        .beginTime = kYALExpandAnimationDuration / 4.0,
        .fromValue = M_PI / 8.0,
        .toValue = 0.0
    }
};

YALExtraTabBarItemViewAnimationParameters const kYALShowExtraTabBarItemViewAnimationParameters = (YALExtraTabBarItemViewAnimationParameters) {
    .duration = kYALExpandAnimationDuration / 2.0,
    .damping = 0.5f,
};

YALExtraTabBarItemViewAnimationParameters const kYALHideExtraTabBarItemViewAnimationParameters = (YALExtraTabBarItemViewAnimationParameters) {
    .duration = kYALExpandAnimationDuration / 8.0,
};
