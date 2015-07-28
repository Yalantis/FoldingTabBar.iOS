// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALFoldingTabBarController.h"

//model
#import "YALTabBarItem.h"

//protocol
#import "YALTabBarInteracting.h"

#import "YALAnimatingTabBarConstants.h"

@interface YALFoldingTabBarController () <YALTabBarViewDataSource, YALTabBarViewDelegate>

@property (nonatomic, assign) YALTabBarState state;

@end

@implementation YALFoldingTabBarController

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.tabBarViewHeight = YALTabBarViewDefaultHeight;
    
    [self setupTabBarView];
}

#pragma mark - View & LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
    [self.tabBar setShadowImage:[[UIImage alloc] init]];
    
    self.tabBar.hidden = YES;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = self.tabBarViewHeight;
    tabFrame.origin.y = self.view.frame.size.height - self.tabBarViewHeight;
    self.tabBar.frame = tabFrame;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self updateTabBarViewFrame];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];

    self.tabBarView.selectedTabBarItemIndex = selectedIndex;
    [self.tabBarView setNeedsLayout];
}

#pragma mark - Private

- (void)updateTabBarViewFrame {
    CGFloat tabBarViewOriginX = self.tabBar.frame.origin.x;
    CGFloat tabBarViewOriginY = self.tabBar.frame.origin.y;
    CGFloat tabBarViewSizeWidth = CGRectGetWidth(self.tabBar.frame);
    
    self.tabBarView.frame = CGRectMake(tabBarViewOriginX, tabBarViewOriginY, tabBarViewSizeWidth, self.tabBarViewHeight);
    [self.tabBarView setNeedsLayout];
}

- (void)setupTabBarView {
    self.tabBarView = [[YALFoldingTabBar alloc] initWithFrame:CGRectZero state:self.state];
        
    self.tabBarView.dataSource = self;
    self.tabBarView.delegate = self;
    
    [self.view addSubview:self.tabBarView];
}

- (id<YALTabBarInteracting>)currentInteractingViewController {
    if ([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        return (id<YALTabBarInteracting>)[(UINavigationController *)self.selectedViewController topViewController];
    } else {
        return (id<YALTabBarInteracting>)self.selectedViewController;
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

- (void)tabBarViewWillCollapse:(YALFoldingTabBar *)tabBarView {
    id<YALTabBarInteracting>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(tabBarViewWillCollapse)]) {
        [viewController tabBarViewWillCollapse];
    }
}

- (void)tabBarViewDidCollapse:(YALFoldingTabBar *)tabBarView {
    id<YALTabBarInteracting>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(tabBarViewDidCollapse)]) {
        [viewController tabBarViewDidCollapse];
    }
}

- (void)tabBarViewWillExpand:(YALFoldingTabBar *)tabBarView {
    id<YALTabBarInteracting>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(tabBarViewWillExpand)]) {
        [viewController tabBarViewWillExpand];
    }
}

- (void)tabBarViewDidExpand:(YALFoldingTabBar *)tabBarView {
    id<YALTabBarInteracting>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(tabBarViewDidExpand)]) {
        [viewController tabBarViewDidExpand];
    }
}

- (void)extraLeftItemDidPressInTabBarView:(YALFoldingTabBar *)tabBarView {
    id<YALTabBarInteracting>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(extraLeftItemDidPress)]) {
        [viewController extraLeftItemDidPress];
    }
}

- (void)extraRightItemDidPressInTabBarView:(YALFoldingTabBar *)tabBarView {
    id<YALTabBarInteracting>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(extraRightItemDidPress)]) {
        [viewController extraRightItemDidPress];
    }
}

- (void)itemInTabBarViewPressed:(YALFoldingTabBar *)tabBarView atIndex:(NSUInteger)index {
    self.selectedViewController = [self.viewControllers objectAtIndex:index];
}


@end
