//
//  PlacemarkViewController.h
//  GeoFormsMappit
//
//  Created by Nick Blackwell on 2014-08-07.
//  Copyright (c) 2014 Nick Blackwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsersItemListViewController.h"

@interface FeatureViewController : UIViewController<UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property UsersItemListViewController *delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableDictionary *media;
@property NSMutableDictionary *attributes;
@property NSMutableDictionary *details;


- (IBAction)onSaveFormButtonTap:(id)sender;
- (IBAction)onCancelFormButtonTap:(id)sender;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *label;


-(void)setFormParameters:(NSDictionary *)formParameters;
-(void)setFormData:(NSDictionary *)formData;
- (IBAction)onTakePhotoCellButtonTap:(id)sender;


-(void) setActiveView:(UIView *)view;
@property (unsafe_unretained, nonatomic) IBOutlet UIToolbar *spinningView;

@end
