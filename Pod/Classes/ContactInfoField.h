//
//  ContactInfoField.h
//  Pods
//
//  Created by Nick on 2016-09-12.
//
//

#import <UIKit/UIKit.h>
#import "GFDelegateCell.h"
#import "FeatureField.h"

@interface ContactInfoField : UITableViewCell<GFDelegateCell, FeatureField>
@property NSString *fieldName;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *contactButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *contactIcon;

@end
