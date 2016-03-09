// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALSecondTestViewController.h"

#define debug 1

@implementation YALSecondTestViewController

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

- (void)tabBarDidSelectExtraLeftItem:(YALFoldingTabBar *)tabBarView {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

-(void)tabBarDidSelectExtraRightItem:(YALFoldingTabBar *)tabBarView {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

@end
