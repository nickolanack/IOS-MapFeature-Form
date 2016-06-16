//
//  FeatureDetailViewController.m
//  GeoFormsMappit
//
//  Created by Nick Blackwell on 2015-12-04.
//  Copyright © 2015 Nick Blackwell. All rights reserved.
//

#import "FeatureDetailViewController.h"
#import "ImageUtilities.h"
#import "HTMLParser.h"
#import "MapFormDelegate.h"

@interface FeatureDetailViewController ()

@property id<MapFormDelegate> delegate;



@end

@implementation FeatureDetailViewController

@synthesize metadata;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if([[UIApplication sharedApplication].delegate conformsToProtocol:@protocol(MapFormDelegate)]){
        _delegate=[UIApplication sharedApplication].delegate;
    }
        
    
    
    
    
    if([_delegate respondsToSelector:@selector(itemShouldBeDeletable:)]){
        if(!([_delegate itemShouldBeDeletable:metadata])){
            [self.deleteButton setAlpha:0.2];
        }
    }else{
        [self.deleteButton setAlpha:0.2];
    }
    
    
    if([_delegate respondsToSelector:@selector(itemShouldBeEditable::)]){
        if(!([_delegate itemShouldBeEditable:metadata])){
            [self.editButton setAlpha:0.2];
        }
    }else{
        [self.editButton setAlpha:0.2];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onDeleteButtonTap:(id)sender {
    
    if([_delegate respondsToSelector:@selector(itemShouldBeDeletable:)]){
        if((![_delegate itemShouldBeDeletable:metadata])){
            return;
        }
    }
    
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Delete this report"
                                                                   message:@"Are you sure you want to delete this marker permanently."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          
                                                              if(![_delegate respondsToSelector:@selector(itemWasDeleted:)]){
                                                                  @throw [[NSException alloc] initWithName:@"Expected Delegate Method: itemWasDeleted" reason:@"Delegate must implement: itemWasDeleted, becuase it implemented and returned true at least once for: itemShouldBeDeletable" userInfo:nil];
                                                              }
                                                              
                                                              [_delegate itemWasDeleted:metadata];
                                                              
                                                          
                                                          }];
    [alert addAction:deleteAction];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {}];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


@end
