//
//  OptionsListField.h
//  Pods
//
//  Created by Nick Blackwell on 2016-07-16.
//
//

#import <UIKit/UIKit.h>
#import "GFDelegateCell.h"
#import "FeatureField.h"

@interface OptionsListField : UITableViewCell<GFDelegateCell, UIPickerViewDelegate, UIPickerViewDataSource, FeatureField>

@property (weak, nonatomic) IBOutlet UIPickerView *optionsField;

@property NSString *fieldName;



@end
