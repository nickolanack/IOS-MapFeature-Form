//
//  ContactInfoField.m
//  Pods
//
//  Created by Nick on 2016-09-12.
//
//

#import "ContactInfoField.h"
#import "ContactInfoViewController.h"


@interface ContactInfoField ()

@property NSDictionary *formMetadata;

@end


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
    
    NSString *metadata=[fieldParameters objectForKey:@"formMetadata"];
    if(metadata){
        _formMetadata=metadata;
    }
    
    
    NSString *label=[fieldParameters objectForKey:@"label"];
    if(label){
        [self.labelField setText:label];
    }
    
    NSString *iconStr=[fieldParameters objectForKey:@"icon"];
    if(iconStr){
        [self.icon setImage:[UIImage imageNamed:iconStr] forState:UIControlStateNormal];
    }
    
    
    NSNumber *value=[self.delegate getFormDataForKey:fieldName];
    
    if(value==nil){
        value=[fieldParameters objectForKey:@"value"];
    }
    
    if(value){
    
    }
    
}

- (IBAction)onTapContactInfoButton:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserForm" bundle:nil];
    ContactInfoViewController *myController = (ContactInfoViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ContactForm"];
    
    
    [myController setFormMetadata:_formMetadata];
    
    
        [[self.delegate getNavigationController] pushViewController: myController animated:YES];
    
    
}
@end
