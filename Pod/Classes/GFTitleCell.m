//
//  GFTitleCell.m
//  GeoFormsMappit
//
//  Created by Nick Blackwell on 2014-08-08.
//  Copyright (c) 2014 Nick Blackwell. All rights reserved.
//

#import "GFTitleCell.h"

@implementation GFTitleCell

@synthesize delegate, tableView, fieldName;






- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}



-(void)setFieldParameters:(NSDictionary *) fieldParameters{
    
    
    
    NSString *field=[fieldParameters objectForKey:@"field"];
    if(field){
        fieldName=field;
    }
    
    NSString *placeholder=[fieldParameters objectForKey:@"placeholder"];
    if(placeholder){
         [self.titleField setPlaceholder:placeholder];
    }
    


    
    
    NSString *value=[self.delegate getFormDataForKey:fieldName];
   
    
    if(value==nil){
        value=[fieldParameters objectForKey:@"value"];
    }
    
    if(value){
        [self.titleField setText:value];
    }
    
    
}


- (IBAction)onEditTitle:(id)sender {
    
    [self.delegate setFormData:self.titleField.text forKey:fieldName];
    
}
@end
