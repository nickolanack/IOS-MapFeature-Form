//
//  OptionsListField.m
//  Pods
//
//  Created by Nick Blackwell on 2016-07-16.
//
//

#import "OptionsListField.h"

@interface OptionsListField ()


@property NSArray *values;



@end

@implementation OptionsListField

@synthesize delegate, tableView, fieldName;




-(void)setFieldParameters:(NSDictionary *) fieldParameters{
    
    
    
    NSString *field=[fieldParameters objectForKey:@"field"];
    if(field){
        fieldName=field;
    }
    
    NSString *values=[fieldParameters objectForKey:@"values"];
    if(values){
        _values=values;
    }else{
        _values=@[@"one", @"two"];
    }
    

    
    
    NSNumber *value=nil;
    NSDictionary *details=self.delegate.details;
    
    if(details!=nil){
        value=[details objectForKey:fieldName];
    }
    
    if(value){
        [self.optionsField selectRow:[value integerValue] inComponent:0 animated:true];
        [self.delegate.details setObject:[_values objectAtIndex:[value integerValue]] forKey:fieldName];
    }
    
    
    
    
    
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _values.count;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.delegate.details setObject:[_values objectAtIndex:row] forKey:fieldName];
}

//- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    return [_values objectAtIndex:row];
//}


- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = [_values objectAtIndex:row];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor blueColor]}];
    
    return attString;
    
}
@end
