//
//  Subheading.m
//  Pods
//
//  Created by Nick on 2016-07-19.
//
//

#import "Subheading.h"

static UIColor *defaultColor = nil;

@implementation Subheading
-(void)setFieldParameters:(NSDictionary *) fieldParameters{
    
    
    if (! defaultColor){
        defaultColor=[_subheading textColor];
    }
  
    
    
    NSString *value=[fieldParameters objectForKey:@"value"];
    if(value){
        [_subheading setText:value];
    }
    
    
    NSString *color=[fieldParameters objectForKey:@"color"];
    if(color){
        [_subheading setTextColor:[Subheading colorFromHexString:color]];
    }else{
       [_subheading setTextColor:defaultColor];
    }
    
   
    
}


+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
