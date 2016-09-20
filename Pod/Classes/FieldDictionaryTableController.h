//
//  FieldDictionaryTableController.h
//  Pods
//
//  Created by Nick on 2016-09-19.
//
//

#import <Foundation/Foundation.h>

@interface FieldDictionaryTableController : NSObject


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withFieldMetadata:(NSDictionary *) fieldMetadata andDelegate:(id)delegate;

@end
