//
//  FieldDictionaryTableController.m
//  Pods
//
//  Created by Nick on 2016-09-19.
//
//

#import "FieldDictionaryTableController.h"
#import "UserInputFeatureField.h"
#import "FeatureField.h"

@implementation FieldDictionaryTableController



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withFieldMetadata:(NSDictionary *) fieldMetadata andDelegate:(id)delegate{
    
    
    UITableViewCell *cell=nil;
    NSInteger row=[indexPath row];
    
    
    @try{
        cell= [tableView dequeueReusableCellWithIdentifier:[fieldMetadata objectForKey:@"identifier"]];
        
        if(cell==nil){
        
            if (cell == nil) {
                
               

                [tableView registerNib: [UINib nibWithNibName:[fieldMetadata objectForKey:@"identifier"] bundle:nil]forCellReuseIdentifier:[fieldMetadata objectForKey:@"identifier"]];
                 cell= [tableView dequeueReusableCellWithIdentifier:[fieldMetadata objectForKey:@"identifier"]];
                
                
            }
            
        }
        
        
    } @catch(NSException *e){
        
        @throw e;
    }
    
    if([cell conformsToProtocol:@protocol(UserInputFeatureField)]){
        [((id<UserInputFeatureField>)cell) setDelegate:delegate];
        [((id<UserInputFeatureField>)cell) setTableView:tableView];
    }
    
    
    if ([cell conformsToProtocol:@protocol(FeatureField)]) {
        
        id<FeatureField> field=cell;
        [field setFieldParameters:fieldMetadata];
        
    }else{
        
        
       
            
        if(cell.textLabel){
            [cell.textLabel setText:[fieldMetadata objectForKey:@"value"]];
        }
   
    }
    
    
    
    
    return cell;
    
    
    
}


@end
