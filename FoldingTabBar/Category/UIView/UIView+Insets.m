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

#define IS_IPHONE [[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone

BOOL isIPhoneX() {
    if (IS_IPHONE) {
        BOOL isLandscapeIPhoneX = CGSizeEqualToSize(NATIVE_SIZE, IPHONE_X_LANDSCAPE_SIZE);
        BOOL isPortraitIPhoneX = CGSizeEqualToSize(NATIVE_SIZE, IPHONE_X_PORTRAIT_SIZE);
        
        return isLandscapeIPhoneX || isPortraitIPhoneX;
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
