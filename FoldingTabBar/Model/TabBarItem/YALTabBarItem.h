// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YALTabBarItem : NSObject

@property (nonatomic, strong) UIImage *itemImage;
@property (nonatomic, strong) UIImage *leftImage;
@property (nonatomic, strong) UIImage *rightImage;

- (instancetype)initWithItemImage:(UIImage *)itemImage
                    leftItemImage:(UIImage *)leftItemImage
                   rightItemImage:(UIImage *)rightItemImage;

@end
