// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALFoldingTabBarController.h"

//model
#import "YALTabBarItem.h"

#import "YALFoldingTabBar.h"
#import "YALAnimatingTabBarConstants.h"


@interface YALFoldingTabBarController () <YALTabBarDelegate, YALTabBarDataSource>

@property (nonatomic, assign) YALTabBarState state;

@end

@implementation YALFoldingTabBarController

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupTabBarView];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupTabBarView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupTabBarView];
    }
    return self;
}

#pragma mark - View & LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
    [self.tabBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tabBarView.frame = self.tabBar.bounds;
    
    for (UIView *view in self.tabBar.subviews) {
        [view removeFromSuperview];
    }
    [self.tabBar addSubview:self.tabBarView];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];

    self.tabBarView.selectedTabBarItemIndex = selectedIndex;
    [self.tabBarView setNeedsLayout];
}

- (void)setTabBarViewHeight:(CGFloat)tabBarViewHeight {
    CGRect newFrame = self.tabBar.frame;
    newFrame.size.height = tabBarViewHeight;
    [self.tabBar setFrame:newFrame];
}

- (CGFloat)tabBarViewHeight {
    return self.tabBar.frame.size.height;
}

#pragma mark - Private

- (void)setupTabBarView {
    for (UIView *view in self.tabBar.subviews) {
        [view removeFromSuperview];
    }
    
    self.tabBarView = [[YALFoldingTabBar alloc] initWithController:self];
    [self.tabBar addSubview:self.tabBarView];
}

- (id<YALTabBarDelegate>)currentInteractingViewController {
    if ([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        return (id<YALTabBarDelegate>)[(UINavigationController *)self.selectedViewController topViewController];
    } else {
        return (id<YALTabBarDelegate>)self.selectedViewController;
    }
}

#pragma mark - YALTabBarViewDataSource

- (NSArray *)leftTabBarItemsInTabBarView:(YALFoldingTabBar *)tabBarView {
    return self.leftBarItems;
}

- (NSArray *)rightTabBarItemsInTabBarView:(YALFoldingTabBar *)tabBarView {
    return self.rightBarItems;
}

- (UIImage *)centerImageInTabBarView:(YALFoldingTabBar *)tabBarView {
    return self.centerButtonImage;
}

#pragma mark - YALTabBarViewDelegate

- (void)tabBarWillCollapse:(YALFoldingTabBar *)tabBarView {
    id<YALTabBarDelegate>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(tabBarWillCollapse:)]) {
        [viewController tabBarWillCollapse:self.tabBarView];
    }
}

-(void)tabBarDidCollapse:(YALFoldingTabBar *)tabBarView {
    id<YALTabBarDelegate>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(tabBarDidCollapse:)]) {
        [viewController tabBarDidCollapse:self.tabBarView];
    }
}

-(void)tabBarWillExpand:(YALFoldingTabBar *)tabBarView {
    id<YALTabBarDelegate>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(tabBarWillExpand:)]) {
        [viewController tabBarWillExpand:self.tabBarView];
    }
}

- (void)tabBarDidExpand:(YALFoldingTabBar *)tabBarView {
    id<YALTabBarDelegate>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(tabBarDidExpand:)]) {
        [viewController tabBarDidExpand:self.tabBarView];
    }
}

//TODO: fix

- (void)tabBarDidSelectExtraLeftItem:(YALFoldingTabBar *)tabBarView {
    id<YALTabBarDelegate>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(tabBarDidSelectExtraLeftItem:)]) {
        [viewController tabBarDidSelectExtraLeftItem:self.tabBarView];
    }
}

- (void)tabBarDidSelectExtraRightItem:(YALFoldingTabBar *)tabBarView {
    id<YALTabBarDelegate>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(tabBarDidSelectExtraRightItem:)]) {
        [viewController tabBarDidSelectExtraRightItem:self.tabBarView];
    }
}

- (BOOL)tabBar:(YALFoldingTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index {
    UIViewController *viewControllerToSelect = self.viewControllers[index];

    BOOL shouldAskForPermission = [self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)];
    
    BOOL selectionAllowed = YES;
    
    if (shouldAskForPermission) {
        selectionAllowed = [self.delegate tabBarController:self shouldSelectViewController:viewControllerToSelect];
    }
    
    return selectionAllowed;
}

- (void)tabBar:(YALFoldingTabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index {
    self.selectedViewController = self.viewControllers[index];
}

@end
