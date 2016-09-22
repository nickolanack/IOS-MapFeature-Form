//
//  KeywordTagsField.h
//  Pods
//
//  Created by Nick on 2016-08-30.
//
//

#import <UIKit/UIKit.h>
#import "UserInputFeatureField.h"
#import "FeatureField.h"

@interface KeywordTagsField : UITableViewCell<UserInputFeatureField, FeatureField, UICollectionViewDelegate, UICollectionViewDataSource>

@property NSString *fieldName;

@end
