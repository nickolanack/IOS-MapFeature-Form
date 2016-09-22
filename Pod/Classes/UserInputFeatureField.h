//
//  UserInputFeatureField.h
//  GeoFormsMappit
//
//  Created by Nick Blackwell on 2014-08-08.
//  Copyright (c) 2014 Nick Blackwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeatureFormDatasource.h"
#import "FeatureField.h"

@protocol UserInputFeatureField <FeatureField>

@property id<FeatureFormDatasource> delegate;
@property UITableView *tableView;

@end
