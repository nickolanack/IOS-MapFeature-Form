//
//  ContactInfoViewController.h
//  Pods
//
//  Created by Nick on 2016-09-16.
//
//

#import <UIKit/UIKit.h>
#import "FeatureFormDatasource.h"

@interface ContactInfoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;

@end
