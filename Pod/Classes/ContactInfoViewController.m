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

@synthesize formMetadata;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dictionaryTable=[[FieldDictionaryTableController alloc] init];
    
}

-(NSArray *)getMetadata{
    return formMetadata;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self getMetadata].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    return [_dictionaryTable tableView:tableView cellForRowAtIndexPath:indexPath withFieldMetadata:[[self getMetadata]objectAtIndex:indexPath.row] andDelegate:self];
    
}


-(id) getFormDataForKey:(NSString *)key{
    return nil;
}
-(void) setFormData:(id) object forKey:(NSString *)key{
    
}
-(void) setActiveView:(UIView *)view{

}

@end
