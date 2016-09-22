//
//  TextField.h
//  Pods
//
//  Created by Nick on 2016-07-19.
//
//

#import <Foundation/Foundation.h>
#import "UserInputFeatureField.h"
#import "FeatureField.h"

@interface TextField : UITableViewCell<UserInputFeatureField, UITextViewDelegate, FeatureField>

@property NSString *fieldName;
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *textField;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *placeholder;

@end
