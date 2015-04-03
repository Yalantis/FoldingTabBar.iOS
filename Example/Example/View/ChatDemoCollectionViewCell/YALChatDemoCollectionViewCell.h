// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import <UIKit/UIKit.h>

@interface YALChatDemoCollectionViewCell : UICollectionViewCell

- (void)configureCellWithImage:(UIImage *)image
                      userName:(NSString *)name
                   messageText:(NSString *)messageText
                      dateText:(NSString *)dateText;

@end
