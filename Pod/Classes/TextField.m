//
//  TextField.m
//  Pods
//
//  Created by Nick on 2016-07-19.
//
//

#import "TextField.h"

@implementation TextField

@synthesize delegate, tableView, fieldName;



-(void)setFieldParameters:(NSDictionary *) fieldParameters{
    
    
    
    [_textField setDelegate:self];
    
    NSString *field=[fieldParameters objectForKey:@"field"];
    if(field){
        fieldName=field;
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
        [self.textField setText:value];
        [self.delegate.details setObject:value forKey:fieldName];
    }
    
}

- (void)textViewDidChange:(UITextView *)textView{
    if([textView.text characterAtIndex:textView.text.length-1] =='\n'){
        [textView.inputView resignFirstResponder];
        [textView resignFirstResponder];
      
     
    }
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{

}

@end
