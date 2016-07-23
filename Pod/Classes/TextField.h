//
//  TextField.h
//  Pods
//
//  Created by Nick on 2016-07-19.
//
//

#import <Foundation/Foundation.h>
#import "GFDelegateCell.h"
#import "FeatureField.h"

@interface TextField : UITableViewCell<GFDelegateCell,UITextViewDelegate, FeatureField>

@property NSString *fieldName;
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *textField;

@end
