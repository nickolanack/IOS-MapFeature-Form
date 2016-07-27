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

@property UIView *activeView;

@end

@implementation FeatureViewController

@synthesize delegate, media, attributes, details;


-(void)setFormParameters:(NSDictionary *)formParameters{
    
    if(_formParameters){
        @throw [[NSException alloc] initWithName:@"Initialize Form Parameters Exception" reason:@"It is too late to initialize form parameters now" userInfo:nil];
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
    
   NSMutableDictionary *formData= [[NSMutableDictionary alloc] initWithDictionary:self.details];
   [formData setValue:_location forKey:@"location"];
    
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
    
    
    [self registerForKeyboardNotifications];
    
}

-(bool)allowLibraryPicker{
    if(_formParameters&&[_formParameters objectForKey:@"allowLibraryPicker"]){
        return [[_formParameters objectForKey:@"allowLibraryPicker"] boolValue];
    }
    return false;
}

-(bool)allowCameraPicker{
    if(_formParameters&&[_formParameters objectForKey:@"allowCameraPicker"]){
        return [[_formParameters objectForKey:@"allowCameraPicker"] boolValue];
    }
    return true;
}

-(bool)preferCameraPicker{
    if(_formParameters&&[_formParameters objectForKey:@"preferCameraPicker"]){
        return [[_formParameters objectForKey:@"preferCameraPicker"] boolValue];
    }
    return true;
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
    
    return [self getFieldMetadataArray].count;
    
}

-(NSArray *)getDefaultFieldMetadataArray{

    return @[
             @{
                 @"identifier":@"Heading",
                 @"value":@"New Placemark",
                 @"rowHeight":[NSNumber numberWithFloat:35]
                 },
             @{
                 @"identifier":@"SubHeading",
                 @"value":@"Image or Video",
                 @"rowHeight":[NSNumber numberWithFloat:35]
                 },
             @{
                 @"identifier":@"MediaField",
                 },
             @{
                 @"identifier":@"SubHeading",
                 @"value":@"Name",
                 @"rowHeight":[NSNumber numberWithFloat:35]
                 },
             @{
                 @"identifier":@"TextField",
                 @"field":@"name",
                 @"placeholder":@"add a name",
                 @"value":@"",
                 @"rowHeight":[NSNumber numberWithFloat:60],
                 },
             @{
                 @"identifier":@"SubHeading",
                 @"value":@"Description",
                 @"rowHeight":[NSNumber numberWithFloat:35]
                 },
             @{
                 @"identifier":@"TextField",
                 @"field":@"description",
                 @"placeholder":@"add a description",
                 @"value":@"",
                 @"rowHeight":[NSNumber numberWithFloat:60],
                 },
             
             @{
                 @"identifier":@"Space",
                 @"rowHeight":[NSNumber numberWithFloat:120],
                 },
             
             ];

}

-(NSArray *)getFieldMetadataArray{
    
    
    if([_formDelegate respondsToSelector:@selector(menuFormFieldMetadata)]){
        return [_formDelegate menuFormFieldMetadata];
    }
    
    NSArray *formParametersFieldMetadataArray=[_formParameters objectForKey:@"fieldMetadata"];
    if(formParametersFieldMetadataArray){
        return formParametersFieldMetadataArray;
    }
    
    return [self getDefaultFieldMetadataArray];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    NSInteger row=[indexPath row];
    
    
    NSDictionary *fieldMetadata=(NSDictionary *)[[self getFieldMetadataArray] objectAtIndex:row];
    
    @try{
        cell= [tableView dequeueReusableCellWithIdentifier:[fieldMetadata objectForKey:@"identifier"]];
    } @catch(NSException *e){
        @throw e;
    }
    
    if([cell conformsToProtocol:@protocol(GFDelegateCell)]){
        [((id<GFDelegateCell>)cell) setDelegate:self];
        [((id<GFDelegateCell>)cell) setTableView:tableView];
    }
    
    
    if ([cell conformsToProtocol:@protocol(FeatureField)]) {
        
        id<FeatureField> field=cell;
        [field setFieldParameters:fieldMetadata];
        
    }else{
        
        
        if([cell isKindOfClass:[MediaItemsTableViewCell class]]){
            
            NSString *imageLabel=@"Take Photo";
            
            if(![self allowCameraPicker]){
                imageLabel=@"Add Photo";
            }
            
            if([self hasImage]){
                [((MediaItemsTableViewCell *) cell).mediaImage setImage:[self getImage]];
                imageLabel=@"Retake";
                
                if(![self allowCameraPicker]){
                    imageLabel=@"Change Photo";
                }

            }
            
            [((MediaItemsTableViewCell *) cell).takePhotoButton setTitle:imageLabel forState:UIControlStateNormal];
            
        }else{
        
            if(cell.textLabel){
               [cell.textLabel setText:[fieldMetadata objectForKey:@"value"]]; 
            }
            
        }
    }
    
    return cell;
    
}


- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"Active Cell");

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    
    
    NSDictionary *fieldMetadata=(NSDictionary *)[[self getFieldMetadataArray] objectAtIndex:row];
    NSNumber *height=[fieldMetadata objectForKey:@"rowHeight"];
    if(height){
        return [height floatValue];
    }
    
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
    
    if(!_picker){
   
            
        _picker = [[UIImagePickerController alloc] init];
        
        //picker.wantsFullScreenLayout = YES;
        _picker.navigationBarHidden = YES;
        _picker.toolbarHidden = YES;
        
        
        
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //picker.showsCameraControls=YES;
        
        if([self allowLibraryPicker]&&((![self allowCameraPicker])||(![self preferCameraPicker]))){
            _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        _picker.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        _picker.delegate = self;
 
    
    }
    
    [self presentViewController:_picker animated:false completion:^{
        
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:info];
    self.media=dict;
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.tableView reloadData];
    }];
    
    picker.delegate=nil;
    picker=nil;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    if([[self.navigationController topViewController] isKindOfClass:[FeatureViewController class]]){
        [self.navigationController popViewControllerAnimated:true];
    }
    
    picker.delegate=nil;
    picker=nil;
    
}


#pragma mark Keyboard Helper
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void) setActiveView:(UIView *)view{
    _activeView=view;
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _tableView.contentInset = contentInsets;
    _tableView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
    CGPoint offset=[self.view convertPoint:_activeView.frame.origin fromView:_activeView];
    CGPoint origin=[self.tableView convertPoint:_activeView.frame.origin fromView:_activeView];
    
    if (!CGRectContainsPoint(aRect, origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, origin.y-kbSize.height);
        [_tableView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _tableView.contentInset = contentInsets;
    _tableView.scrollIndicatorInsets = contentInsets;
}


@end
