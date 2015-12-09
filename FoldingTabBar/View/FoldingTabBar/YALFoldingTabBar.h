// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import <UIKit/UIKit.h>

@class YALFoldingTabBar;
@class YALFoldingTabBarController;

@protocol YALTabBarDataSource <NSObject>

@required
- (NSArray *)leftTabBarItemsInTabBarView:(YALFoldingTabBar *)tabBarView;
- (NSArray *)rightTabBarItemsInTabBarView:(YALFoldingTabBar *)tabBarView;
- (UIImage *)centerImageInTabBarView:(YALFoldingTabBar *)tabBarView;

@end

@protocol YALTabBarDelegate <NSObject>

@optional

- (void)tabBar:(YALFoldingTabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index;

- (void)tabBarWillCollapse:(YALFoldingTabBar *)tabBarView;
- (void)tabBarWillExpand:(YALFoldingTabBar *)tabBarView;

- (void)tabBarDidCollapse:(YALFoldingTabBar *)tabBarView;
- (void)tabBarDidExpand:(YALFoldingTabBar *)tabBarView;

- (void)tabBarDidSelectExtraLeftItem:(YALFoldingTabBar *)tabBarView;
- (void)tabBarDidSelectExtraRightItem:(YALFoldingTabBar *)tabBarView;

@end

typedef NS_ENUM(NSUInteger, YALTabBarState) {
    YALStateCollapsed,
    YALStateExpanded
};

@interface YALFoldingTabBar : UIView

- (instancetype)initWithController:(YALFoldingTabBarController *)controller;

@property (nonatomic, assign, readonly) YALTabBarState state;
@property (nonatomic, assign) NSUInteger selectedTabBarItemIndex;

@property (nonatomic, copy) UIColor *tabBarColor;
@property (nonatomic, assign) UIEdgeInsets tabBarViewEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets tabBarItemsEdgeInsets;
@property (nonatomic, assign) CGFloat extraTabBarItemHeight;
@property (nonatomic, assign) CGFloat offsetForExtraTabBarItems;

@end
