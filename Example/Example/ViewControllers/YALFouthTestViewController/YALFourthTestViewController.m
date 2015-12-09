// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALFourthTestViewController.h"

#define debug 1

@implementation YALFourthTestViewController

#pragma mark - YALTabBarInteracting

- (void)tabBarViewWillCollapse {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)tabBarViewWillExpand {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)tabBarDidCollapse:(YALFoldingTabBar *)tabBarView {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)tabBarDidExpand:(YALFoldingTabBar *)tabBarView {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

@end
