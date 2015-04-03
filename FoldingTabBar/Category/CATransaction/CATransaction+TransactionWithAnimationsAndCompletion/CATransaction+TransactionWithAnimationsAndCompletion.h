// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import <QuartzCore/QuartzCore.h>

@interface CATransaction (TransactionWithAnimationsAndCompletion)

+ (void)transactionWithAnimations:(void(^)(void))animations andCompletion:(void(^)(void))completion;

@end
