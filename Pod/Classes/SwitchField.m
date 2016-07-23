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
    
    
    NSNumber *value=nil;
    NSDictionary *details=self.delegate.details;
    
    if(details!=nil){
        value=[details objectForKey:fieldName];
    }
    
    if(value==nil){
        value=[fieldParameters objectForKey:@"value"];
    }
    
    if(value){
        [self.switchField setSelected:[value boolValue]];
        [self.delegate.details setObject:value forKey:fieldName];
    }
    
}


- (IBAction)onToggleSwitch:(id)sender {
    [self.delegate.details setObject:[NSNumber numberWithBool:[_switchField isSelected]] forKey:fieldName];
}
@end
