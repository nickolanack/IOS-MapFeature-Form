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
    NSString *strValue=[self.delegate getFormDataForKey:fieldName];

   
        if(strValue){
            int index=[_values indexOfObject:strValue];
            if(index!=NSNotFound){
                value=[NSNumber numberWithInteger:index];
            }
        }
 
    
    if(value==nil){
        value=[fieldParameters objectForKey:@"value"];
    }
    
    if(value){
        [self.optionsField selectRow:[value integerValue] inComponent:0 animated:true];
        
        [self.delegate setFormData:[_values objectAtIndex:[value integerValue]] forKey:fieldName];
    }
    
    
    self.optionsField.layer.cornerRadius = 5.0f;
    
    
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
    [self.delegate setFormData:[_values objectAtIndex:row] forKey:fieldName];
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_values objectAtIndex:row];
}


//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *title = [_values objectAtIndex:row];
//    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:122/255.0 blue:1.0 alpha:1.0]}];
//    
//    return attString;
//    
//}
@end
