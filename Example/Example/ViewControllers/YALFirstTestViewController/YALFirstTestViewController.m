// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALFirstTestViewController.h"

#define debug 1

@implementation YALFirstTestViewController

#pragma mark - YALTabBarInteracting

- (void)tabBarWillCollapse:(YALFoldingTabBar *)tabBar {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)tabBarWillExpand:(YALFoldingTabBar *)tabBar {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)tabBarDidCollapse:(YALFoldingTabBar *)tabBar {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)tabBarDidExpand:(YALFoldingTabBar *)tabBar {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

@end
