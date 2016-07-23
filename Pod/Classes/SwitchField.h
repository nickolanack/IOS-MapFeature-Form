//
//  SwitchField.h
//  Pods
//
//  Created by Nick on 2016-07-19.
//
//

#import <Foundation/Foundation.h>
#import "GFDelegateCell.h"
#import "FeatureField.h"

@interface SwitchField : UITableViewCell<GFDelegateCell, FeatureField>

@property NSString *fieldName;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *fieldLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UISwitch *switchField;

- (IBAction)onToggleSwitch:(id)sender;
@end
