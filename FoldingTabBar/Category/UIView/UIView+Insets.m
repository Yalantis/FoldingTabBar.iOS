//
//  UIView+Insets.m
//  FoldingTabBar
//
//  Created by Sergey on 11/22/17.
//  Copyright © 2017 Sergey Butenko. All rights reserved.
//

#import "UIView+Insets.h"

#define NATIVE_SIZE [[UIScreen mainScreen] nativeBounds].size

#define IPHONE_X_PORTRAIT_SIZE CGSizeMake(1125, 2436)
#define IPHONE_X_LANDSCAPE_SIZE CGSizeMake(2436, 1125)

#define IPHONE_XR_PORTRAIT_SIZE CGSizeMake(828, 1792)
#define IPHONE_XR_LANDSCAPE_SIZE CGSizeMake(1792, 828)

#define IPHONE_XSM_PORTRAIT_SIZE CGSizeMake(1242 , 2688)
#define IPHONE_XSM_LANDSCAPE_SIZE CGSizeMake(2688, 1242)

#define IS_IPHONE [[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone

BOOL isIPhoneX() {
    if (IS_IPHONE) {
        BOOL isLandscapeIPhoneX = CGSizeEqualToSize(NATIVE_SIZE, IPHONE_X_LANDSCAPE_SIZE);
        BOOL isPortraitIPhoneX = CGSizeEqualToSize(NATIVE_SIZE, IPHONE_X_PORTRAIT_SIZE);
        
        BOOL isLandscapeIPhoneXS = CGSizeEqualToSize(NATIVE_SIZE, IPHONE_XR_LANDSCAPE_SIZE);
        BOOL isPortraitIPhoneXS = CGSizeEqualToSize(NATIVE_SIZE, IPHONE_XR_PORTRAIT_SIZE);
        
        BOOL isLandscapeIPhoneXSM = CGSizeEqualToSize(NATIVE_SIZE, IPHONE_XSM_LANDSCAPE_SIZE);
        BOOL isPortraitIPhoneXSM = CGSizeEqualToSize(NATIVE_SIZE, IPHONE_XSM_PORTRAIT_SIZE);
        
        return isLandscapeIPhoneX || isPortraitIPhoneX || isPortraitIPhoneXS || isLandscapeIPhoneXS || isPortraitIPhoneXSM || isLandscapeIPhoneXSM;
    }
    return false;
}

@implementation UIView (Insets)

-(CGFloat)bottomInset {
    if (@available(iOS 11, *)) {
        if (isIPhoneX()) {
            //Default bottom inset for iPhone X at portrait orientation
            return 34.f;
        }
    }
    return 0.f;
}

@end
