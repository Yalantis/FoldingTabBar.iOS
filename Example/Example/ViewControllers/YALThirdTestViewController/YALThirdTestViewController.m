// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALThirdTestViewController.h"

NSString *const YALChatDemoImageName = @"imageName";
NSString *const YALChatDemoUserName = @"userName";
NSString *const YALChatDemoMessageText = @"messageText";
NSString *const YALChatDemeDateText = @"dateText";

#define debug 1

//view
#import "YALChatDemoCollectionViewCell.h"

@interface YALThirdTestViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *chatDemoCollectionView;
@property (nonatomic, copy) NSArray *chatDemoData;

@end

@implementation YALThirdTestViewController

#pragma mark - View & LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chatDemoData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"YALChatDemoList" ofType:@"plist"]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.chatDemoCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    [self prepareVisibleCellsForAnimation];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self animateVisibleCells];
}

#pragma mark - Private

- (void)prepareVisibleCellsForAnimation {
    for (int i = 0; i < [self.chatDemoCollectionView.visibleCells count]; i++) {
        YALChatDemoCollectionViewCell * cell = (YALChatDemoCollectionViewCell *) [self.chatDemoCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        cell.frame = CGRectMake(-CGRectGetWidth(cell.bounds), cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
        cell.alpha = 0.f;
    }
}

- (void)animateVisibleCells {
    for (int i = 0; i < [self.chatDemoCollectionView.visibleCells count]; i++) {
        YALChatDemoCollectionViewCell * cell = (YALChatDemoCollectionViewCell *) [self.chatDemoCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        cell.alpha = 1.f;
        [UIView animateWithDuration:0.25f
                              delay:i * 0.1
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             cell.frame = CGRectMake(0.f, cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
                         }
                         completion:nil];
    }
}

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

- (void)tabBarViewDidCollapsed {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)tabBarViewDidExpanded {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)extraLeftItemDidPressed {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)extraRightItemDidPressed {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
         
     } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
          [self.chatDemoCollectionView performBatchUpdates:nil completion:nil];
     }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.chatDemoData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YALChatDemoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YALChatDemoCollectionViewCell class]) forIndexPath:indexPath];
    
    NSDictionary *dictionary = self.chatDemoData[indexPath.row];
    
    [cell configureCellWithImage:[UIImage imageNamed:dictionary[YALChatDemoImageName]]
                        userName:dictionary [YALChatDemoUserName]
                     messageText:dictionary [YALChatDemoMessageText]
                        dateText:dictionary [YALChatDemeDateText]];

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
    
    return CGSizeMake(CGRectGetWidth(self.view.bounds), layout.itemSize.height);
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
}

@end
