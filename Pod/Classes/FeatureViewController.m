//
//  PlacemarkViewController.m
//  GeoFormsMappit
//
//  Created by Nick Blackwell on 2014-08-07.
//  Copyright (c) 2014 Nick Blackwell. All rights reserved.
//

#import "FeatureViewController.h"
#import "GFDelegateCell.h"
#import "GFKeywordCell.h"
#import "GFTitleCell.h"
#import "MapFormDelegate.h"
#import "MediaItemsTableViewCell.h"



@interface FeatureViewController ()

@property id<MapFormDelegate> formDelegate;

@property UIImagePickerController *picker;
@property CLLocationManager *locMan;
@property CLLocation *location;

@property NSDictionary *formParameters;

@end

@implementation FeatureViewController

@synthesize delegate, media, attributes, details;


-(void)setFormParameters:(NSDictionary *)formParameters{
    
    if(_formParameters){
        @throw [[NSException alloc] initWithName:@"Initialize Form Parameters Exception" reason:@"It is too late initialize form parameters now" userInfo:nil];
    }
    _formParameters=[self checkFormParameters:formParameters];
}

-(void)setFormData:(NSDictionary *)formData{
    
    if([formData objectForKey:@"location"]){
        _location=[formData objectForKey:@"location"];
    }

}

- (IBAction)onTakePhotoCellButtonTap:(id)sender {
    
    [self takePhoto];
    
}

-(NSDictionary *)getFormData{

    NSDictionary *formData=@{
                             @"name":[self.details objectForKey:@"name"]?[self.details objectForKey:@"name"]:@"",
                             @"description":[self.details objectForKey:@"description"]?[self.details objectForKey:@"description"]:@"",
                             @"attributes":self.attributes?self.attributes:@{},
                             @"location":_location
                             };
    return formData;
    

}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton=true;
    self.tableView.editing=true;
    
    
    
    if([[UIApplication sharedApplication].delegate conformsToProtocol:@protocol(MapFormDelegate)]){
        _formDelegate=[UIApplication sharedApplication].delegate;
    }
    
    
    if((!_formParameters)&&_formDelegate&&[_formDelegate respondsToSelector:@selector(menuFormParamtersForForm)]){
        NSDictionary *params=[_formDelegate menuFormParamtersForForm];
        _formParameters=[self checkFormParameters:params];
        
    }
    
    if(!_formParameters){
        //default form paramters
        _formParameters=@{
                          @"startWithImagePicker":[NSNumber numberWithBool:true]
                          };
    }
    
    
    if(!self.picker){
        
        _picker = [[UIImagePickerController alloc] init];
        
        //picker.wantsFullScreenLayout = YES;
        _picker.navigationBarHidden = YES;
        _picker.toolbarHidden = YES;
        
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //picker.showsCameraControls=YES;
        
        _picker.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        _picker.delegate = self;
        
    }
    
    if(!_location){
        
        _locMan =[[CLLocationManager alloc] init];
        
        if([CLLocationManager locationServicesEnabled] &&
           [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
        {
            
            if([ CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
                [_locMan requestWhenInUseAuthorization];
            }
            
            [_locMan startUpdatingLocation];
            _location= [_locMan location];
            
            
        }else{
            
            NSLog(@"Denied Access to user location");
        }
    }else{
        NSLog(@"Using supplied location");
    }
    
    self.attributes=[[NSMutableDictionary alloc] initWithDictionary:@{@"keywords":@[]}];
    self.details=[[NSMutableDictionary alloc] initWithDictionary:@{@"name":@""}];
    
    if((!self.media)&&[self startWithImagePicker]){
        [self takePhoto];
    }
    
}

-(bool)startWithImagePicker{
    
    if(_formParameters&&[_formParameters objectForKey:@"startWithImagePicker"]){
        return [[_formParameters objectForKey:@"startWithImagePicker"] boolValue];
    }
    return true;
    
}

-(NSDictionary *)checkFormParameters:(NSDictionary *)params{
    return params;
}

#pragma Mark Buttons

- (IBAction)onSaveFormButtonTap:(id)sender {
    
    

    [self displayUploadStatus];
    
    FeatureViewController * __block me=self;
    
    void (^progressHandler)(float) = ^(float percentFinished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [me.progressView setProgress:percentFinished];
        });
        
    };
    void (^completion)(NSDictionary *) = ^(NSDictionary *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [me hideUploadStatus];
            [me.progressView setProgress:0.0];
            
            if([[me.navigationController topViewController] isKindOfClass:[FeatureViewController class]]){
                [me.navigationController popViewControllerAnimated:true];
            }
        });
    };
    
    
    /**
     * TODO provide support for uploading in the background.
     */
    
    NSLog(@"%s: %@",__PRETTY_FUNCTION__,self.media);
    
    if([self hasImage]){
        
        /*
         * Upload Image Files
         */
        
        [_formDelegate saveForm:[self getFormData] withImage:[self getImage] withProgressHandler:progressHandler andCompletion:completion];
            

    }else if([self hasVideo]){
        
        /*
         * Upload Video Files
         */
        [_formDelegate  saveForm:[self getFormData] withVideo:[self getVideoUrl] withProgressHandler:progressHandler andCompletion:completion];

        
    }else{
    
        /*
         *Upload no media
         */
        
        [_formDelegate  saveForm:[self getFormData] withCompletion:completion];
        
    }
    
    
    
    
}

-(bool)hasImage{
    if(self.media&&[[self.media objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]){
        return true;
    }
    return false;
}
-(bool)hasVideo{
    if(self.media&&[[self.media objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.movie"]){
        return true;
    }
    return false;
}

-(UIImage *)getImage{
    return [self.media objectForKey:UIImagePickerControllerOriginalImage];
}
-(NSURL *)getVideoUrl{
    return [self.media objectForKey:UIImagePickerControllerMediaURL];
}



-(void)displayUploadStatus{
    [self.label setHidden:false];
    [self.progressView setHidden:false];
}

-(void)hideUploadStatus{
    [self.label setHidden:true];
    [self.progressView setHidden:true];
}

- (IBAction)onCancelFormButtonTap:(id)sender {
    
    if([[self.navigationController topViewController] isKindOfClass:[FeatureViewController class]]){
        [self.navigationController popViewControllerAnimated:true];
    }
    
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [self.tableView setDelegate:nil];
    
}


#pragma mark UITableViewDataSource

-(int)indexOfFirstAttribute{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int num=[self indexOfFirstAttribute]; //label, media, title, description
    
    for (NSString *attribute in [self attributeNames]) {
        num+=[self numberOfCellsForAttribute:attribute];
    }
    
    return num;
    
}



-(int)numberOfCellsForAttribute:(NSString *)attribute{
    
    NSArray *values=[attributes objectForKey:attribute];
    if(values){
        return 1+values.count;
    }
    return 1;
    
}

-(NSArray *)attributeNames{
    return @[];// @[@"keywords"];
}

-(NSString *)cellIdentifierForAttribute:(NSString *)attribute{
    return @"keywordCell";
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    NSInteger row=[indexPath row];
    
    if(row==0){
        /**
         * Display a title sections. this section is not editable.
         * TODO get label from delegate!
         */
        cell= [tableView dequeueReusableCellWithIdentifier:@"labelCell"];
        [cell.textLabel setText:@"BCWF Violation Report"];
        
    }
    
    if(row==1){
        
        /**
         * Media items cell, display selected media items.
         */
        
        cell= [tableView dequeueReusableCellWithIdentifier:@"mediaCell"];
        
        if([cell isKindOfClass:[MediaItemsTableViewCell class]]){
            if([self hasImage]){
                [((MediaItemsTableViewCell *) cell).mediaImage setImage:[self getImage]];
                [((MediaItemsTableViewCell *) cell).takePhotoButton setTitle:@"Retake" forState:UIControlStateNormal];
            }else{
            
            }
            
            
        }
        
    }
    
    if(row==2){
        
        /**
         * title/name field cell
         */
        
        cell= [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        
        if([cell isKindOfClass:[GFTitleCell class]]){
            
            [((GFTitleCell *) cell).titleField setPlaceholder:@"violation type"];
            [((GFTitleCell *) cell) setFieldName:@"name"];
            NSString *name=nil;
            if(details!=nil){
                name=[details objectForKey:@"name"];
            }
            
            if(name==nil){
                name=@"";
                [((GFTitleCell *) cell).titleField becomeFirstResponder];
            }
            [((GFTitleCell *) cell).titleField setText:name];
        }
        
    }
    
    if(row==3){
        
        /**
         * description field cell
         */
        
        cell= [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        
        if([cell isKindOfClass:[GFTitleCell class]]){
            
            [((GFTitleCell *) cell).titleField setPlaceholder:@"violation description"];
            [((GFTitleCell *) cell) setFieldName:@"description"];
            
            NSString *name=nil;
            if(details!=nil){
                name=[details objectForKey:@"description"];
            }
            
            if(name==nil){
                name=@"";
                //[((GFTitleCell *) cell).titleField becomeFirstResponder];
            }
            [((GFTitleCell *) cell).titleField setText:name];
        }
        
    }
    
    
    /**
     * Attributes
     * TODO: currently attributes take multiple cells. 
     * I would like to replace this with single cells, but with multiple fields inside the cell.
     * that would simplify this class. calculating indexes is now a bit to tricky
     */
    
    
    int firstAttributeIndex=[self indexOfFirstAttribute];
    
    if(row>=firstAttributeIndex){
        NSArray *keywords=[attributes objectForKey:@"keywords"];
        if(keywords!=nil&&[keywords count]){
            
            if(row<(firstAttributeIndex+[keywords count])){
                
                cell= [tableView dequeueReusableCellWithIdentifier:@"keywordLabelCell"];
                if([cell isKindOfClass:[GFKeywordCell class]]){
                    ((GFKeywordCell *) cell).value.text=[keywords objectAtIndex:[indexPath item]-firstAttributeIndex];
                }
                
            }
            
            if(row==(firstAttributeIndex+[keywords count])){
                cell= [tableView dequeueReusableCellWithIdentifier:@"keywordCell"];
            }
            
        }else{
            
            if(row==firstAttributeIndex){
                cell= [tableView dequeueReusableCellWithIdentifier:@"keywordCell"];
            }
            
        }
    }
    
    
    
    if([cell conformsToProtocol:@protocol(GFDelegateCell)]){
        [((id<GFDelegateCell>)cell) setDelegate:self];
        [((id<GFDelegateCell>)cell) setTableView:tableView];
    }
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    
    int firstAttributeIndex=[self indexOfFirstAttribute];
    
    if(row==0)return 35;
    if(row>=firstAttributeIndex){
        NSArray *keywords=[attributes objectForKey:@"keywords"];
        if(keywords!=nil&&[keywords count]){
            
            if(row<(firstAttributeIndex+[keywords count])){
                return 35;
            }
            
        }
    }
    return tableView.rowHeight;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=indexPath.row;
    
    int firstAttributeIndex=[self indexOfFirstAttribute];

    
    if(row>1){
        NSArray *keywords=[attributes objectForKey:@"keywords"];
        if(keywords!=nil&&[keywords count]){
            
            if(row<(firstAttributeIndex+[keywords count])){
                return YES;
            }
            
        }
    }
    return NO;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(editingStyle==UITableViewCellEditingStyleDelete){
        
        int firstAttributeIndex=[self indexOfFirstAttribute];
        
        NSInteger index=indexPath.row-firstAttributeIndex;
        NSMutableArray *a=[[NSMutableArray alloc] initWithArray:[attributes objectForKey:@"keywords"]];
        [a removeObjectAtIndex:index];
        [attributes setObject:[[NSArray alloc] initWithArray:a] forKey:@"keywords"];
        [self.tableView reloadData];
    }
    
}



-(void)takePhoto{
    
    [self presentViewController:_picker animated:false completion:^{
        
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:info];
    self.media=dict;
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.tableView reloadData];
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    if([[self.navigationController topViewController] isKindOfClass:[FeatureViewController class]]){
        [self.navigationController popViewControllerAnimated:true];
    }
    
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
    
}

@end
