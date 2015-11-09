// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALFoldingTabBar.h"

//model
#import "YALTabBarItem.h"

#import "CAAnimation+YALTabBarViewAnimations.h"
#import "CATransaction+TransactionWithAnimationsAndCompletion.h"

typedef NS_ENUM(NSUInteger, YALAnimatingState) {
    YALAnimatingStateCollapsing,
    YALAnimatingStateExpanding
};

#import "YALAnimatingTabBarConstants.h"

@interface YALFoldingTabBar ()

@property (nonatomic, strong) NSArray *allBarItems;

@property (nonatomic, assign) YALTabBarState state;
@property (nonatomic, assign) YALAnimatingState animatingState;
@property (nonatomic, assign) BOOL isFinishedCenterButtonAnimation;

@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, assign) BOOL isAnimated;

@property (nonatomic, assign) CGRect collapsedFrame;
@property (nonatomic, assign) CGRect expandedFrame;

@property (nonatomic, assign) CGRect collapsedBounds;
@property (nonatomic, assign) CGRect expandedBounds;

@property (nonatomic, assign) NSUInteger counter;

//buttons used instead of native tabBarItems to switch between controllers
@property (nonatomic, strong) NSArray *leftButtonsArray;
@property (nonatomic, strong) NSArray *rightButtonsArray;

//extra buttons 'tabBarItems' for each 'tabBarItem'
@property (nonatomic, strong) UIButton *extraLeftButton;
@property (nonatomic, strong) UIButton *extraRightButton;

//model representation of tabBarItems. also contains info for extraBarItems: image, color, etc
@property (nonatomic, strong) NSDictionary *leftTabBarItems;
@property (nonatomic, strong) NSDictionary *rightTabBarItems;

//array of all buttons just for simple switching between controllers by index
@property (nonatomic, strong) NSArray *allAdditionalButtons;
@property (nonatomic, strong) NSMutableArray *allAdditionalButtonsBottomView;

@end

@implementation YALFoldingTabBar

#pragma mark - Initialations

- (instancetype)initWithFrame:(CGRect)frame state:(YALTabBarState)state {
    self = [super initWithFrame:frame];
    if (self) {
        _state = state;
        _selectedTabBarItemIndex = 0;
        _counter = 0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupUI];
}

#pragma mark - Private

- (void)setupUI {
    [self removeViewsBeforeUpdateUI];
    
    [self setupMainView];
    [self setupCenterButton];
    
    //collapsed frame equals to frame of the centerButton
    self.collapsedFrame = self.centerButton.frame;
    
    [self setupAdditionalTabBarItems];

    [self updateMaskLayer];

    [self setupExtraTabBarItems];
    [self setupTabBarItemsViewRepresentation];
    [self setupBarItemsModelRepresentation];
    [self prepareTabBarViewForInitialState];
}

- (void)removeViewsBeforeUpdateUI {

    if (self.mainView) {
        [self.mainView removeFromSuperview];
        self.mainView = nil;
    }

    if (self.extraLeftButton) {
        [self.extraLeftButton removeFromSuperview];
        self.extraLeftButton = nil;
    }

    if (self.extraRightButton) {
        [self.extraRightButton removeFromSuperview];
        self.extraRightButton = nil;
    }

    if (self.centerButton) {
        [self.centerButton removeFromSuperview];
        self.centerButton = nil;
    }
}

- (void)setupCenterButton {
    self.centerButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.mainView.frame) - CGRectGetHeight(self.mainView.frame) / 2.0f,
                                                                   CGRectGetMidY(self.mainView.frame) - CGRectGetHeight(self.mainView.frame) / 2.f,
                                                                   CGRectGetHeight(self.mainView.frame),
                                                                   CGRectGetHeight(self.mainView.frame))];
    
    self.centerButton.layer.cornerRadius = CGRectGetHeight(self.mainView.bounds) / 2.f;
    
    if ([self.dataSource respondsToSelector:@selector(centerImageInTabBarView:)]) {
        [self.centerButton setImage:[self.dataSource centerImageInTabBarView:self] forState:UIControlStateNormal];
    }
    
    [self.centerButton addTarget:self action:@selector(centerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.centerButton.adjustsImageWhenHighlighted = NO;
    
    [self addSubview:self.centerButton];
}

- (void)setupMainView {
    self.mainView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.bounds, self.tabBarViewEdgeInsets)];
        
    self.expandedFrame = self.mainView.frame;
    self.mainView.layer.cornerRadius = CGRectGetHeight(self.mainView.bounds) / 2.f;
    self.mainView.layer.masksToBounds = YES;
    self.mainView.backgroundColor = self.tabBarColor;
    
    [self addSubview:self.mainView];
}

- (void)setupAdditionalTabBarItems {
    NSArray *leftTabBarItems = [self.dataSource leftTabBarItemsInTabBarView:self];
    NSArray *rightTabBarItems = [self.dataSource rightTabBarItemsInTabBarView:self];
    
    NSUInteger numberOfLeftTabBarButtonItems = [leftTabBarItems count];
    NSUInteger numberOfRightTabBarButtonItems = [rightTabBarItems count];
    
    //calculate available space for left and right side
    CGFloat availableSpaceForAdditionalBarButtonItemLeft = CGRectGetWidth(self.mainView.frame) / 2.f - CGRectGetWidth(self.centerButton.frame) / 2.f - self.tabBarItemsEdgeInsets.left;
    
    CGFloat availableSpaceForAdditionalBarButtonItemRight = CGRectGetWidth(self.mainView.frame) / 2.f - CGRectGetWidth(self.centerButton.frame) / 2.f - self.tabBarItemsEdgeInsets.right;
    
    CGFloat maxWidthForLeftBarButonItem = availableSpaceForAdditionalBarButtonItemLeft / numberOfLeftTabBarButtonItems;
    CGFloat maxWidthForRightBarButonItem = availableSpaceForAdditionalBarButtonItemRight / numberOfRightTabBarButtonItems;
    
    NSMutableArray * reverseArrayLeft = [NSMutableArray arrayWithCapacity:[self.leftButtonsArray count]];
    
    for (id element in [leftTabBarItems reverseObjectEnumerator]) {
        [reverseArrayLeft addObject:element];
    }
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSMutableArray *mutableDotsArray = [NSMutableArray array];
    
    CGFloat deltaLeft = 0.f;
    if (maxWidthForLeftBarButonItem > CGRectGetWidth(self.centerButton.frame)) {
        deltaLeft = maxWidthForLeftBarButonItem - CGRectGetWidth(self.centerButton.frame);
    }
    
    CGFloat startPositionLeft = CGRectGetWidth(self.mainView.bounds) / 2.f - CGRectGetWidth(self.centerButton.frame) / 2.f - self.tabBarItemsEdgeInsets.left - deltaLeft / 2.f;
    
    for (int i = 0; i < numberOfLeftTabBarButtonItems; i++) {
        CGFloat buttonOriginX = startPositionLeft - maxWidthForLeftBarButonItem * (i+1);
        CGFloat buttonOriginY = 0.f;

        CGFloat buttonWidth = maxWidthForLeftBarButonItem;
        CGFloat buttonHeight = CGRectGetHeight(self.mainView.frame);
        
        startPositionLeft -= self.tabBarItemsEdgeInsets.right;
        
        YALTabBarItem *item = reverseArrayLeft[i];
        UIImage *image = item.itemImage;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonOriginX, buttonOriginY, buttonWidth, buttonHeight)];
        
        if (numberOfLeftTabBarButtonItems == 1) {
            CGRect rect = button.frame;
            rect.size.width = CGRectGetHeight(self.mainView.frame);
            button.bounds = rect;
        }
        
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(barItemDidTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.state == YALStateCollapsed) {
          button.hidden = YES;
        }
        
        
        [mutableArray addObject:button];
        button.adjustsImageWhenHighlighted = NO;
        
        [self.mainView addSubview:button];
    }
    
    NSMutableArray * reverseArrayLeftDotViews = [NSMutableArray arrayWithCapacity:[mutableDotsArray count]];
    
    for (id element in [mutableDotsArray reverseObjectEnumerator]) {
        [reverseArrayLeft addObject:element];
    }
    mutableDotsArray = reverseArrayLeftDotViews;

    self.leftButtonsArray = [mutableArray copy];
    
    [mutableArray removeAllObjects];
    
    CGFloat rightDelta = 0.f;
    if (maxWidthForRightBarButonItem > CGRectGetWidth(self.centerButton.frame)) {
        rightDelta = maxWidthForRightBarButonItem - CGRectGetWidth(self.centerButton.frame);
    }
    
    CGFloat rightOffset = self.tabBarItemsEdgeInsets.right;
    CGFloat startPositionRight = CGRectGetWidth(self.mainView.bounds) / 2.f + CGRectGetWidth(self.centerButton.frame) / 2.f + self.tabBarItemsEdgeInsets.right
    + rightDelta / 2.f;
    
    for (int i = 0; i < numberOfRightTabBarButtonItems; i++) {
        CGFloat buttonOriginX = startPositionRight;
        CGFloat buttonOriginY = 0.f;
        CGFloat buttonWidth = maxWidthForRightBarButonItem;
        CGFloat buttonHeight = CGRectGetHeight(self.mainView.frame);
        
        startPositionRight = buttonOriginX + maxWidthForRightBarButonItem + rightOffset;
        
        YALTabBarItem *item = rightTabBarItems [i];
        UIImage *image = item.itemImage;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonOriginX, buttonOriginY, buttonWidth, buttonHeight)];

        if (numberOfLeftTabBarButtonItems == 1) {
            CGRect rect = button.frame;
            rect.size.width = CGRectGetHeight(self.mainView.frame);
            button.bounds = rect;
        }
        
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(barItemDidTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.state == YALStateCollapsed) {
            button.hidden = YES;
        }
        [mutableArray addObject:button];
        button.adjustsImageWhenHighlighted = NO;
        [self.mainView addSubview:button];
    }
    
    self.rightButtonsArray = [mutableArray copy];
}

//collect all tabBarItems (models) to one array
- (void)setupBarItemsModelRepresentation {
    NSMutableArray *tempMutableArrayOfBarItems = [NSMutableArray array];
    
    NSArray *leftTabBarItems = [self.dataSource leftTabBarItemsInTabBarView:self];
    NSArray *rightTabBarItems = [self.dataSource rightTabBarItemsInTabBarView:self];
    
    for (YALTabBarItem *item in leftTabBarItems) {
        [tempMutableArrayOfBarItems addObject:item];
    }
    
    for (YALTabBarItem *item in rightTabBarItems) {
        [tempMutableArrayOfBarItems addObject:item];
    }
    
    self.allBarItems = [tempMutableArrayOfBarItems copy];
}

- (void)setupExtraTabBarItems {
    self.extraLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMidY(self.mainView.frame) - CGRectGetHeight(self.mainView.frame) / 2.f, self.extraTabBarItemHeight, self.extraTabBarItemHeight)];
    self.extraLeftButton.center = CGPointMake( - CGRectGetWidth(self.extraLeftButton.frame) / 2, self.mainView.center.y);
    self.extraLeftButton.backgroundColor = self.tabBarColor;
    self.extraLeftButton.layer.cornerRadius = CGRectGetWidth(self.extraLeftButton.frame) / 2.f;
    self.extraLeftButton.layer.masksToBounds = YES;
    
    [self.extraLeftButton addTarget:self action:@selector(extraLeftButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
    self.extraLeftButton.hidden = YES;
    
    [self addSubview:self.extraLeftButton];
    
    self.extraRightButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - CGRectGetWidth(self.centerButton.frame), CGRectGetMidY(self.mainView.frame) - CGRectGetHeight(self.mainView.frame) / 2.f, self.extraTabBarItemHeight, self.extraTabBarItemHeight)];
    self.extraRightButton.center = CGPointMake(self.extraRightButton.center.x + CGRectGetWidth(self.extraRightButton.frame) , self.mainView.center.y);
    self.extraRightButton.layer.cornerRadius = CGRectGetWidth(self.extraLeftButton.frame) / 2.f;
    self.extraLeftButton.layer.masksToBounds = YES;
    
    self.extraRightButton.backgroundColor = self.tabBarColor;
    [self.extraRightButton addTarget:self action:@selector(extraRightButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
    self.extraRightButton.hidden = YES;

    [self addSubview:self.extraRightButton];
}

- (void)setupTabBarItemsViewRepresentation {
    NSMutableArray *tempArray = [NSMutableArray array];
    NSMutableArray *reverseArray = [NSMutableArray arrayWithCapacity:[self.leftButtonsArray count]];
    
    for (id element in [self.leftButtonsArray reverseObjectEnumerator]) {
        [reverseArray addObject:element];
    }
    
    for (UIButton *button in [reverseArray arrayByAddingObjectsFromArray:self.rightButtonsArray]) {
        [tempArray addObject:button];
    }
    
    self.allAdditionalButtons = [tempArray copy];
    
    self.allAdditionalButtonsBottomView = [[NSMutableArray alloc] init];;
    for (UIButton *button in self.allAdditionalButtons) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, YALBottomSelectedDotDefaultSize,YALBottomSelectedDotDefaultSize)];
        dotView.center = CGPointMake(button.center.x, button.center.y + YALBottomSelectedDotOffset);
        dotView.layer.cornerRadius = CGRectGetHeight(dotView.frame) / 2.f;
        dotView.backgroundColor = self.dotColor ? self.dotColor : [UIColor blackColor];
        dotView.hidden = YES;
        [self.mainView addSubview:dotView];
        [self.allAdditionalButtonsBottomView addObject:dotView];
    }
}

- (void)prepareTabBarViewForInitialState {
    
    if (![self hasTabBarItems]) {
        return ;
    }
    
    //collapse mainView. tabBarItams are hidden.
    if (self.state == YALStateExpanded) {
        self.centerButton.transform = CGAffineTransformMakeRotation(M_PI_4);
    }
    self.mainView.frame = self.expandedFrame;
    
    //prepare current selected tabBarItem
    NSUInteger index = self.selectedTabBarItemIndex;
    
    if (self.selectedTabBarItemIndex != index) {
        UIView *previousSelectedDotView = self.allAdditionalButtonsBottomView [self.selectedTabBarItemIndex];
        previousSelectedDotView.hidden = YES;
        [self.allAdditionalButtonsBottomView replaceObjectAtIndex:self.selectedTabBarItemIndex withObject:previousSelectedDotView];
    }
    
    if (self.state == YALStateExpanded) {

        UIView *previousSelectedDotView = self.allAdditionalButtonsBottomView [self.selectedTabBarItemIndex];
        previousSelectedDotView.hidden = NO;
        [self.allAdditionalButtonsBottomView replaceObjectAtIndex:self.selectedTabBarItemIndex withObject:previousSelectedDotView];
    }
    
    if (self.state == YALStateExpanded && self.selectedTabBarItemIndex == index) {
        [self hideExtraLeftTabBarItem];
        [self hideExtraRightTabBarItem];
    }
    
    self.selectedTabBarItemIndex = index;
    
    //check if selected view controller needs extraLeftButton or extraRightButton
    YALTabBarItem *defaultSelectedTabBarItem = [self.allBarItems objectAtIndex:index];
    [self configureExtraTabBarItemWithModel:defaultSelectedTabBarItem];
    if (self.state == YALStateCollapsed) {
  
        
        if (defaultSelectedTabBarItem.leftImage) {
            self.extraLeftButton.center = CGPointMake(self.offsetForExtraTabBarItems + CGRectGetWidth(self.extraLeftButton.frame) / 2.f, self.extraLeftButton.center.y);
        }
        
        if (defaultSelectedTabBarItem.rightImage) {
            self.extraRightButton.center = CGPointMake(CGRectGetWidth(self.frame) - self.offsetForExtraTabBarItems - CGRectGetWidth(self.extraRightButton.frame) / 2.f, self.extraRightButton.center.y);
        }
    }
}

- (void)configureExtraTabBarItemWithModel:(YALTabBarItem *)item {
    if (item.leftImage) {
        self.extraLeftButton.hidden = NO;
        [self.extraLeftButton setImage:item.leftImage forState:UIControlStateNormal];
    } else {
        self.extraLeftButton.hidden = YES;
    }
    if (item.rightImage) {
        self.extraRightButton.hidden = NO;
        [self.extraRightButton setImage:item.rightImage forState:UIControlStateNormal];
    } else {
        self.extraRightButton.hidden = YES;
    }
}

- (BOOL)hasTabBarItems {
    return (self.allBarItems.count);
}

#pragma mark - Actions

- (void)centerButtonPressed {
    //we should wait until animation cycle is finished
    
    if (![self hasTabBarItems]) {
        return ;
    }
    
    self.counter ++;
    
    if (!self.isAnimated) {
        if (self.state == YALStateCollapsed) {
            [self expand];
        } else {
            [self collapse];
        }
    } else {
        if (self.animatingState == YALAnimatingStateCollapsing) {
            [self expand];
        } else  if (self.animatingState == YALAnimatingStateExpanding) {
            [self collapse];
        }
    }
}

- (IBAction)barItemDidTapped:(id)sender {
    if (self.isAnimated) {
        return;
    }
    
    NSUInteger index = [self.allAdditionalButtons indexOfObject:sender];
    
    if (self.selectedTabBarItemIndex != index) {
        YALTabBarItem *item = [self.allBarItems objectAtIndex:index];
        [self configureExtraTabBarItemWithModel:item];
        
        UIView *previousSelectedDotView = self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex];
        previousSelectedDotView.hidden = YES;
        [self.allAdditionalButtonsBottomView replaceObjectAtIndex:self.selectedTabBarItemIndex withObject:previousSelectedDotView];
    }
    
    self.selectedTabBarItemIndex = index;
    
    if ([self.delegate respondsToSelector:@selector(tabBarViewWillCollapse:)]) {
        [self.delegate tabBarViewWillCollapse:self];
    }

    [self collapse];
    
    if ([self.delegate respondsToSelector:@selector(itemInTabBarViewPressed:atIndex:)]) {
        [self.delegate itemInTabBarViewPressed:self atIndex:index];
    }
}

- (void)extraLeftButtonDidPress {
    if ([self.delegate respondsToSelector:@selector(extraLeftItemDidPressInTabBarView:)]) {
        [self.delegate extraLeftItemDidPressInTabBarView:self];
    }
}

- (void)extraRightButtonDidPress {
    if ([self.delegate respondsToSelector:@selector(extraRightItemDidPressInTabBarView:)]) {
        [self.delegate extraRightItemDidPressInTabBarView:self];
    }
}

#pragma mark - expand/collapse

- (void)expand {
    self.isFinishedCenterButtonAnimation = NO;
    self.animatingState = YALAnimatingStateExpanding;
    self.state = YALStateExpanded;
    
    if ([self.delegate respondsToSelector:@selector(tabBarViewWillExpand:)]) {
        [self.delegate tabBarViewWillExpand:self];
    }
    
    __block NSUInteger counterCurrentValue = self.counter;
    
    [CATransaction transactionWithAnimations:^{
        self.isAnimated = YES;
        [self animateTabBarViewExpand];
        [self hideExtraLeftTabBarItem];
        [self hideExtraRightTabBarItem];
        [self animateCenterButtonExpand];
        [self animateAdditionalButtons];
        [self showSelectedDotView];
    } andCompletion:^{
        if (counterCurrentValue == self.counter) {
            if ([self.delegate respondsToSelector:@selector(tabBarViewDidExpand:)]) {
                [self.delegate tabBarViewDidExpand:self];
            }
            self.isAnimated = NO;
        }
    }];
}

- (void)collapse {
    self.isFinishedCenterButtonAnimation = NO;
    self.animatingState = YALAnimatingStateCollapsing;
    self.state = YALStateCollapsed;
    
    if ([self.delegate respondsToSelector:@selector(tabBarViewWillCollapse:)]) {
        [self.delegate tabBarViewWillCollapse:self];
    }
    
    __block NSUInteger counterCurrentValue = self.counter;
    
    [CATransaction transactionWithAnimations:^{
        self.isAnimated = YES;
        [self animateTabBarViewCollapse];
        [self showExtraLeftTabBarItem];
        [self showExtraRightTabBarItem];
        [self animateCenterButtonCollapse];
        [self hideSelectedDotView];
        [self animateAdditionalButtons];
    } andCompletion:^{
        if (counterCurrentValue == self.counter) {
            if ([self.delegate respondsToSelector:@selector(tabBarViewDidCollapse:)]) {
                [self.delegate tabBarViewDidCollapse:self];
            }
        }
        self.isAnimated = NO;
    }];
}

- (void)hideSelectedDotView {
    UIView *previousSelectedDotView = self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex];
    previousSelectedDotView.hidden = YES;
    [self.allAdditionalButtonsBottomView replaceObjectAtIndex:self.selectedTabBarItemIndex withObject:previousSelectedDotView];
}

- (void)showSelectedDotView {
    UIView *previousSelectedDotView = self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex];
    previousSelectedDotView.hidden = NO;
    [previousSelectedDotView.layer addAnimation:[CAAnimation showSelectedDotAnimation] forKey:nil];
    [self.allAdditionalButtonsBottomView replaceObjectAtIndex:self.selectedTabBarItemIndex withObject:previousSelectedDotView];
}

#pragma mark - Animations

- (void)animateAdditionalButtons {
    for (UIView *button in self.allAdditionalButtons) {
        if (button.hidden) {
            [button.layer addAnimation:[CAAnimation animationForAdditionalButton] forKey:nil];
        }
        
        button.hidden = !button.hidden;
    }
}

- (void)animateTabBarViewExpand {
    CAAnimation *animation = [CAAnimation animationForTabBarExpandFromRect:self.collapsedBounds toRect:self.expandedBounds];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.mainView.layer.mask addAnimation:animation forKey:nil];
}

- (void)animateTabBarViewCollapse {
    CAAnimation *animation = [CAAnimation animationForTabBarCollapseFromRect:self.expandedBounds toRect:self.collapsedBounds];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.mainView.layer.mask addAnimation:animation forKey:nil];
}

- (void)showExtraLeftTabBarItem {
    [UIView animateWithDuration:kYALShowExtraTabBarItemViewAnimationParameters.duration
                          delay:kYALShowExtraTabBarItemViewAnimationParameters.delay
         usingSpringWithDamping:kYALShowExtraTabBarItemViewAnimationParameters.damping
          initialSpringVelocity:kYALShowExtraTabBarItemViewAnimationParameters.velocity
                        options:kYALShowExtraTabBarItemViewAnimationParameters.options
                     animations:^{
        self.extraLeftButton.center = CGPointMake(CGRectGetWidth(self.extraLeftButton.frame) / 2.f + self.offsetForExtraTabBarItems, self.extraLeftButton.center.y);
    } completion:NULL];
    
    CAAnimation *animation = [CAAnimation animationForExtraLeftBarItem];
    [self.extraLeftButton.layer addAnimation:animation forKey:nil];
}

- (void)showExtraRightTabBarItem {
    [UIView animateWithDuration:kYALShowExtraTabBarItemViewAnimationParameters.duration
                          delay:kYALShowExtraTabBarItemViewAnimationParameters.delay
         usingSpringWithDamping:kYALShowExtraTabBarItemViewAnimationParameters.damping
          initialSpringVelocity:kYALShowExtraTabBarItemViewAnimationParameters.velocity
                        options:kYALShowExtraTabBarItemViewAnimationParameters.options
                     animations:^{
        self.extraRightButton.center = CGPointMake(CGRectGetWidth(self.frame) - CGRectGetWidth(self.extraRightButton.frame) / 2.f - self.offsetForExtraTabBarItems, self.extraRightButton.center.y);
    } completion:NULL];
    
    CAAnimation *animation = [CAAnimation animationForExtraRightBarItem];
    [self.extraRightButton.layer addAnimation:animation forKey:nil];
}

- (void)hideExtraLeftTabBarItem {
    [UIView animateWithDuration:kYALHideExtraTabBarItemViewAnimationParameters.duration
                     animations:^{
                         self.extraLeftButton.center = CGPointMake( - CGRectGetWidth(self.extraLeftButton.frame) / 2.f, self.extraLeftButton.center.y);
                     }];
}

- (void)hideExtraRightTabBarItem {
    [UIView animateWithDuration:kYALHideExtraTabBarItemViewAnimationParameters.duration
                     animations:^{
                         self.extraRightButton.center = CGPointMake(self.extraRightButton.center.x + CGRectGetWidth(self.extraRightButton.frame) + self.offsetForExtraTabBarItems, self.extraRightButton.center.y);
                     }];
}

- (void)animateCenterButtonExpand {
    CAAnimation *animation = [CAAnimation animationForCenterButtonExpand];
    [self.centerButton.layer addAnimation:animation forKey:nil];
}

- (void)animateCenterButtonCollapse {
    CAAnimation *animation = [CAAnimation animationForCenterButtonCollapse];
    [self.centerButton.layer addAnimation:animation forKey:nil];
}

#pragma mark - Mutators

- (void)setTabBarColor:(UIColor *)tabBarColor {
    _tabBarColor = tabBarColor;
    self.mainView.backgroundColor = self.tabBarColor;
    self.extraLeftButton.backgroundColor = self.tabBarColor;
    self.extraRightButton.backgroundColor = self.tabBarColor;
}

- (void)setCollapsedFrame:(CGRect)collapsedFrame {
    _collapsedFrame = collapsedFrame;
    
    self.collapsedBounds = ({
        CGRect collapsedBounds = collapsedFrame;
        collapsedBounds.origin = CGPointZero;
        collapsedBounds.origin.x = CGRectGetWidth(self.expandedFrame) / 2 - CGRectGetWidth(collapsedBounds) / 2;
        collapsedBounds;
    });
    [self updateMaskLayer];
}

- (void)setExpandedFrame:(CGRect)expandedFrame {
    _expandedFrame = expandedFrame;
    
    self.expandedBounds = ({
        CGRect expandedBounds = expandedFrame;
        expandedBounds.origin = CGPointZero;
        expandedBounds;
    });
    [self updateMaskLayer];
}

#pragma mark - Private

- (void)updateMaskLayer {
    self.mainView.layer.mask = ({
        CAShapeLayer *layer = [CAShapeLayer new];
        CGRect rect = (self.state == YALStateExpanded) ? self.expandedBounds : self.collapsedBounds;
        
        layer.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height / 2].CGPath;
        
        layer;
    });
}

@end
