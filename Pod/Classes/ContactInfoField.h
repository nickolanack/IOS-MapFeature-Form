//
//  ContactInfoField.h
//  Pods
//
//  Created by Nick on 2016-09-12.
//
//

#import <UIKit/UIKit.h>
#import "UserInputFeatureField.h"
#import "FeatureField.h"

@interface ContactInfoField : UITableViewCell<UserInputFeatureField, FeatureField>
@property NSString *fieldName;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *contactButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *contactIcon;
- (IBAction)onTapContactInfoButton:(id)sender;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelField;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *icon;

@end
