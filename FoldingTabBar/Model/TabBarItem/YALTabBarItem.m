// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALTabBarItem.h"

@interface YALTabBarItem ()

@end

@implementation YALTabBarItem

#pragma mark - Initialization

- (instancetype)initWithItemImage:(UIImage *)itemImage
                    leftItemImage:(UIImage *)leftItemImage
                   rightItemImage:(UIImage *)rightItemImage {
    self = [super init];
    if (self) {
        _itemImage = itemImage;
        _leftImage = leftItemImage;
        _rightImage = rightItemImage;
    }
    return self;
}

@end
