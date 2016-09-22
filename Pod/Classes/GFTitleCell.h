//
//  GFTitleCell.h
//  GeoFormsMappit
//
//  Created by Nick Blackwell on 2014-08-08.
//  Copyright (c) 2014 Nick Blackwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInputFeatureField.h"
#import "FeatureField.h"

@interface GFTitleCell : UITableViewCell<UserInputFeatureField, UITextFieldDelegate, FeatureField>

@property (weak, nonatomic) IBOutlet UITextField *titleField;

@property NSString *fieldName;

- (IBAction)onEditTitle:(id)sender;


@end
