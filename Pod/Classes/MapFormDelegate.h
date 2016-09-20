
//
//  Created by Nick Blackwell on 2013-07-25.
//
//

#import <Foundation/Foundation.h>
#import "FeatureCell.h"
#import "UsersItemListViewController.h"
//#import <UIKit/UIKit.h>


@protocol MapFormDelegate <NSObject>

-(void)saveForm:(NSDictionary *) data withCompletion:(void (^)(NSDictionary * response)) completion;

-(void)saveForm:(NSDictionary *) data withImage:(UIImage *) image withProgressHandler:(void (^)(float percentFinished)) progress andCompletion:(void (^)(NSDictionary * response)) completion;
-(void)saveForm:(NSDictionary *) data withVideo:(NSURL *) video withProgressHandler:(void (^)(float percentFinished)) progress andCompletion:(void (^)(NSDictionary * response)) completion;



//-(void)uploadImage:(UIImage *) image withProgressHandler:(void (^)(float percentFinished)) progress andCompletion:(void (^)(NSDictionary * response)) completion;
//-(void)uploadVideo:(NSURL *) video withProgressHandler:(void (^)(float percentFinished)) progress andCompletion:(void (^)(NSDictionary * response)) completion;



-(void)listUsersMenuItemsWithCompletion:(void (^)(NSArray * results)) completion;
-(void)formatMenuItemsCell:(FeatureCell *)cell withData:(NSDictionary *)data;

-(int)menuFormNumberOfButtons;
-(void)menuForm:(UsersItemListViewController *) view BottomBarButtonWasTappedAtIndex:(int)index;






-(void)menuFormHelpButtonWasTapped:(UsersItemListViewController *) view;

@optional

-(void)menuForm:(UsersItemListViewController *) view TopBarButtonWasTappedAtIndex:(int)index;

-(bool)menuForm:(UsersItemListViewController *) view NamedButtonWasTapped:(NSString *)string;

-(bool)menuForm:(UsersItemListViewController *) view ItemWasTapped:(NSDictionary *)item;


-(NSDictionary *)menuFormParamtersForForm;

-(NSString *)applicationUrl;

-(bool)itemShouldBeEditable:(NSDictionary *) item;
-(bool)itemShouldBeDeletable:(NSDictionary *) item;
-(void)itemWasDeleted:(NSDictionary *) item;


-(UIImage *)imageForItem:(NSDictionary *) item;
-(NSDictionary *)menuFormFieldMetadata;

-(bool)menuFormWasDeniedAccessToLocation:(UsersItemListViewController *) view;

@end
