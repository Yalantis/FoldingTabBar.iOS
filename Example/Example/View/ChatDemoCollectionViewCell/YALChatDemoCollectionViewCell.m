// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALChatDemoCollectionViewCell.h"

@interface YALChatDemoCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *chatImageView;
@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *notificationImageView;

@end

@implementation YALChatDemoCollectionViewCell

#pragma mark - Public

- (void)configureCellWithImage:(UIImage *)image
                      userName:(NSString *)name
                   messageText:(NSString *)messageText
                      dateText:(NSString *)dateText {
    self.chatImageView.image = image;
    self.userNameLabel.text = name;
    self.messageLabel.text = messageText;
    self.dateLabel.text = dateText;
}

#pragma mark - Private

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.notificationImageView.hidden = !selected;
    
    if (selected) {
        self.backgroundColor = [UIColor colorWithRed:108.f/255.f green:105.f/255.f blue:164.f/255.f alpha:1.0];
    } else {
        self.backgroundColor = [UIColor colorWithRed:102.f/255.f green:99.f/255.f blue:157.f/255.f alpha:1.0];
    }
}

@end
