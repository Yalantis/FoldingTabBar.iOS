// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import <UIKit/UIKit.h>

@class YALFoldingTabBar;

@protocol YALTabBarViewDataSource <NSObject>

@required
- (NSArray *)leftTabBarItemsInTabBarView:(YALFoldingTabBar *)tabBarView;
- (NSArray *)rightTabBarItemsInTabBarView:(YALFoldingTabBar *)tabBarView;
- (UIImage *)centerImageInTabBarView:(YALFoldingTabBar *)tabBarView;

@end

@protocol YALTabBarViewDelegate <NSObject>

@optional
- (void)itemInTabBarViewPressed:(YALFoldingTabBar *)tabBarView atIndex:(NSUInteger)index;

- (void)tabBarViewWillCollapse:(YALFoldingTabBar *)tabBarView;
- (void)tabBarViewWillExpand:(YALFoldingTabBar *)tabBarView;

- (void)tabBarViewDidCollapse:(YALFoldingTabBar *)tabBarView;
- (void)tabBarViewDidExpand:(YALFoldingTabBar *)tabBarView;

- (void)extraLeftItemDidPressInTabBarView:(YALFoldingTabBar *)tabBarView;
- (void)extraRightItemDidPressInTabBarView:(YALFoldingTabBar *)tabBarView;

@end

typedef NS_ENUM(NSUInteger, YALTabBarState) {
    YALStateCollapsed,
    YALStateExpanded
};

@interface YALFoldingTabBar : UIView

- (instancetype)initWithFrame:(CGRect)frame state:(YALTabBarState)state;

@property (nonatomic, weak) IBOutlet id<YALTabBarViewDataSource> dataSource;
@property (nonatomic, weak) IBOutlet id<YALTabBarViewDelegate> delegate;

@property (nonatomic, assign, readonly) YALTabBarState state;
@property (nonatomic, assign) NSUInteger selectedTabBarItemIndex;

@property (nonatomic, copy) UIColor *tabBarColor;
@property (nonatomic, copy) UIColor *dotColor;
@property (nonatomic, assign) UIEdgeInsets tabBarViewEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets tabBarItemsEdgeInsets;
@property (nonatomic, assign) CGFloat extraTabBarItemHeight;
@property (nonatomic, assign) CGFloat offsetForExtraTabBarItems;

@end
