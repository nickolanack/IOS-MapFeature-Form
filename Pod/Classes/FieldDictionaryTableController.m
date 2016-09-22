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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withFieldMetadata:(NSDictionary *) fieldMetadata andDelegate:(id<FeatureFormDatasource>)delegate{
    
    
    UITableViewCell *cell=nil;
    NSInteger row=[indexPath row];
    
    
    NSString *reuseIdentifier=[fieldMetadata objectForKey:@"identifier"];
    
    @try{
        
        /**
         * Attempt to retrieve a field cell using reuse identifier from json.
         */
        cell= [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        
        
    } @catch(NSException *e){
        
        /**
         * An exception is thrown if reuse identifier is unknown, so register it from json and try again.
         */
        
       
    }
    
    if(cell==nil){
        
        [tableView registerNib: [UINib nibWithNibName:reuseIdentifier bundle:nil]forCellReuseIdentifier:reuseIdentifier];
        cell= [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        
    }
    
    if([cell conformsToProtocol:@protocol(UserInputFeatureField)]){
        
        /**
         * user input field is expected to set and get data from delegate. which is and instance of
         */
        
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
