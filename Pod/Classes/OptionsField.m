//
//  OptionsField.m
//  Pods
//
//  Created by Nick on 2016-08-11.
//
//

#import "OptionsField.h"

@interface OptionsField ()


@property NSArray *values;



@end

@implementation OptionsField

@synthesize delegate, tableView, fieldName;




-(void)setFieldParameters:(NSDictionary *) fieldParameters{
    
    
    
    NSString *field=[fieldParameters objectForKey:@"field"];
    if(field){
        fieldName=field;
    }
    
    
    NSNumber *value=nil; //use NSNumber so it can be nil.
    NSDictionary *details=self.delegate.details;
    
    
    NSString *values=[fieldParameters objectForKey:@"values"];
    if(values){
        _values=values;
    }else{
        _values=@[@"one", @"two"];
    }
    [self.optionField removeAllSegments];
    for (int i=0;i<_values.count;i++) {
       
        [self.optionField insertSegmentWithTitle:[_values objectAtIndex:i] atIndex:i animated:false];
    }
    
    if(details!=nil){
        NSString *strValue=[details objectForKey:fieldName];
        if(strValue){
            int index=[_values indexOfObject:strValue];
            if(index>=0&&index!=NSNotFound){
                value=[NSNumber numberWithInteger:index];
            }
        }
    }
    
    if(value==nil){
        value=[fieldParameters objectForKey:@"value"];
    }
    
    if(value){
        [self.optionField setSelectedSegmentIndex:[value integerValue]];
        [self.delegate.details setObject:[_values objectAtIndex:[value integerValue]] forKey:fieldName];
    }
    
}
- (IBAction)onChange:(id)sender {
    
    
    [self.delegate.details setObject:[_values objectAtIndex:[self.optionField selectedSegmentIndex]] forKey:fieldName];
    
    
}
@end
