//
//  ContactInfoViewController.m
//  Pods
//
//  Created by Nick on 2016-09-16.
//
//

#import "ContactInfoViewController.h"
#import "FieldDictionaryTableController.h"

@interface ContactInfoViewController ()


@property FieldDictionaryTableController *dictionaryTable;

@end

@implementation ContactInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dictionaryTable=[[FieldDictionaryTableController alloc] init];
    
    
//    [self.tableView registerNib: [[NSBundle mainBundle] loadNibNamed:@"Subheading" owner:self options:nil] forCellReuseIdentifier:@"Subheading"];
//    
//    [self.tableView registerNib: [[NSBundle mainBundle] loadNibNamed:@"TextField" owner:self options:nil] forCellReuseIdentifier:@"TextField"];
//    
//    [self.tableView registerNib: [[NSBundle mainBundle] loadNibNamed:@"Space" owner:self options:nil] forCellReuseIdentifier:@"Space"];
   
    
    
}

-(NSArray *)getMetadata{
    return @[
             @{
                 @"identifier":@"Subheading",
                 @"value":@"Other Witnesses",
                 @"rowHeight":[NSNumber numberWithFloat:35]
                 },
             @{
                 @"identifier":@"TextField",
                 @"field":@"rappAttributes.otherWitnesses",
                 @"placeholder":@"add description",
                 @"value":@"",
                 @"rowHeight":[NSNumber numberWithFloat:60],
                 },
             
             @{
                 @"identifier":@"Subheading",
                 @"value":@"Additional Comments",
                 @"rowHeight":[NSNumber numberWithFloat:35]
                 },
             @{
                 @"identifier":@"TextField",
                 @"field":@"rappAttributes.comments",
                 @"placeholder":@"add description",
                 @"value":@"",
                 @"rowHeight":[NSNumber numberWithFloat:60],
                 },
             
             @{
                 @"identifier":@"Space",
                 @"rowHeight":[NSNumber numberWithFloat:120],
                 }
             
             ];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self getMetadata].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    return [_dictionaryTable tableView:tableView cellForRowAtIndexPath:indexPath withFieldMetadata:[[self getMetadata]objectAtIndex:indexPath.row] andDelegate:self];
    
}


-(id) getFormDataForKey:(NSString *)key{

}
-(id) setFormData:(id) object forKey:(NSString *)key{

}
-(void) setActiveView:(UIView *)view{

}

@end
