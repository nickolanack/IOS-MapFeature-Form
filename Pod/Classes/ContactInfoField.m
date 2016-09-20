//
//  ContactInfoField.m
//  Pods
//
//  Created by Nick on 2016-09-12.
//
//

#import "ContactInfoField.h"

@implementation ContactInfoField
@synthesize delegate, tableView, fieldName;




-(void)setFieldParameters:(NSDictionary *) fieldParameters{
    
    
    self.contactButton.layer.borderColor=self.contactIcon.tintColor.CGColor;
    self.contactButton.layer.borderWidth=1.0;
    self.contactButton.layer.cornerRadius=26.75;
    
    float hieght=self.contactButton.frame.size.height;
    if(hieght>20&&hieght<200){
        self.contactButton.layer.cornerRadius=hieght/2.0;
    }
    NSString *field=[fieldParameters objectForKey:@"field"];
    if(field){
        fieldName=field;
    }
    
    
    NSString *label=[fieldParameters objectForKey:@"label"];
    if(label){
    
    }
    
    
    NSNumber *value=[self.delegate getFormDataForKey:fieldName];
    
    if(value==nil){
        value=[fieldParameters objectForKey:@"value"];
    }
    
    if(value){
    
    }
    
}

@end
