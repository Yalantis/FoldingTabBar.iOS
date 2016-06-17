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
- (BOOL)tabBar:(YALFoldingTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index;

- (void)tabBarWillCollapse:(YALFoldingTabBar *)tabBar;
- (void)tabBarWillExpand:(YALFoldingTabBar *)tabBar;

- (void)tabBarDidCollapse:(YALFoldingTabBar *)tabBar;
- (void)tabBarDidExpand:(YALFoldingTabBar *)tabBar;

- (void)tabBarDidSelectExtraLeftItem:(YALFoldingTabBar *)tabBar;
- (void)tabBarDidSelectExtraRightItem:(YALFoldingTabBar *)tabBar;

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
@property (nonatomic, copy) UIColor *dotColor;
@property (nonatomic, assign) UIEdgeInsets tabBarViewEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets tabBarItemsEdgeInsets;
@property (nonatomic, assign) CGFloat extraTabBarItemHeight;
@property (nonatomic, assign) CGFloat offsetForExtraTabBarItems;

@end
