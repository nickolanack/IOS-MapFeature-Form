//
//  MediaItemsTableViewCell.h
//  Pods
//
//  Created by Nick on 2016-04-19.
//
//

#import <UIKit/UIKit.h>

@interface MediaItemsTableViewCell : UITableViewCell
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *mediaImage;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *takePhotoButton;

@end
