// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YALTabBarItem : NSObject

@property (nonatomic, strong, nullable) UIImage *itemImage;
@property (nonatomic, strong, nullable) UIImage *leftImage;
@property (nonatomic, strong, nullable) UIImage *rightImage;
@property (nonatomic, strong, nullable) UIImage *leftHighlightedImage;
@property (nonatomic, strong, nullable) UIImage *rightHighlightedImage;

- (instancetype)initWithItemImage:(UIImage * _Nullable)itemImage
                    leftItemImage:(UIImage * _Nullable)leftItemImage
                   rightItemImage:(UIImage * _Nullable)rightItemImage;

@end

NS_ASSUME_NONNULL_END
