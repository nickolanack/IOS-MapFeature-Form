//
//  OptionsField.h
//  Pods
//
//  Created by Nick on 2016-08-11.
//
//

#import <UIKit/UIKit.h>
#import "UserInputFeatureField.h"
#import "FeatureField.h"

@interface OptionsField : UITableViewCell<UserInputFeatureField, FeatureField>
@property NSString *fieldName;
@property (unsafe_unretained, nonatomic) IBOutlet UISegmentedControl *optionField;
- (IBAction)onChange:(id)sender;

@end
