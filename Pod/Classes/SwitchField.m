//
//  SwitchField.m
//  Pods
//
//  Created by Nick on 2016-07-19.
//
//

#import "SwitchField.h"

@implementation SwitchField

@synthesize delegate, tableView, fieldName;




-(void)setFieldParameters:(NSDictionary *) fieldParameters{
    
    
    
    NSString *field=[fieldParameters objectForKey:@"field"];
    if(field){
        fieldName=field;
    }

    
    NSString *label=[fieldParameters objectForKey:@"label"];
    if(label){
        [_fieldLabel setText:label];
    }
    
    
    NSNumber *value=[self.delegate getFormDataForKey:fieldName];
   
    
    if(value==nil){
        value=[fieldParameters objectForKey:@"value"];
    }
    
    if(value){
        [self.switchField setOn:[value boolValue]];
        [self.delegate setFormData:value forKey:fieldName];
    }
    
}


- (IBAction)onToggleSwitch:(id)sender {
     [self.delegate setFormData:[NSNumber numberWithBool:[_switchField isOn]] forKey:fieldName];
}
@end
