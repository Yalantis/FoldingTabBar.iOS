// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALCustomHeightTabBar.h"
#import "YALAnimatingTabBarConstants.h"
#import "UIView+Insets.h"

@implementation YALCustomHeightTabBar

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize sizeThatFits = [super sizeThatFits:size];
    sizeThatFits.height = self.barHeight;
    
    return sizeThatFits;
}

- (CGFloat)barHeight {
    if (_barHeight != 0.f) {
        return _barHeight + self.bottomInset;
    } else {
        return YALTabBarViewDefaultHeight + self.bottomInset;
    }
}

@end
