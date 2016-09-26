// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import <UIKit/UIKit.h>

@class YALFoldingTabBar;
@class YALFoldingTabBarController;

NS_ASSUME_NONNULL_BEGIN

@protocol YALTabBarDataSource <NSObject>

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
    YALTabBarStateCollapsed,
    YALTabBarStateExpanded
};

@interface YALFoldingTabBar : UIView

- (instancetype)initWithController:(YALFoldingTabBarController *)controller;

/**
 *  Default data source is YALFoldingTabBarController.
 */
@property (nonatomic, weak, nullable) id<YALTabBarDataSource> dataSource;

/**
 *  Default delegate is YALFoldingTabBarController.
 */
@property (nonatomic, weak, nullable) id<YALTabBarDelegate> delegate;

@property (nonatomic, assign) YALTabBarState state;
@property (nonatomic, assign) NSUInteger selectedTabBarItemIndex;

@property (nonatomic, copy) UIColor *tabBarColor;
@property (nonatomic, copy) UIColor *dotColor;
@property (nonatomic, assign) UIEdgeInsets tabBarViewEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets tabBarItemsEdgeInsets;
@property (nonatomic, assign) CGFloat extraTabBarItemHeight;
@property (nonatomic, assign) CGFloat offsetForExtraTabBarItems;

- (void)changeExtraLeftTabBarItemWithImage:(UIImage * _Nullable)image;
- (void)changeExtraRightTabBarItemWithImage:(UIImage * _Nullable)image;

@end

NS_ASSUME_NONNULL_END
