// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "CATransaction+TransactionWithAnimationsAndCompletion.h"

@implementation CATransaction (TransactionWithAnimationsAndCompletion)

+ (void)transactionWithAnimations:(void(^)(void))animations andCompletion:(void(^)(void))completion {
    [CATransaction begin]; {
        [CATransaction setCompletionBlock:completion];
        if (animations) {
            animations();
        }
    } [CATransaction commit];
}

@end
