//
//  Subheading.m
//  Pods
//
//  Created by Nick on 2016-07-19.
//
//

#import "Subheading.h"

@implementation Subheading
-(void)setFieldParameters:(NSDictionary *) fieldParameters{
    
    
    
  
    
    
    NSString *value=[fieldParameters objectForKey:@"value"];
    if(value){
        [_subheading setText:value];
    }
    
   
    
}
@end
