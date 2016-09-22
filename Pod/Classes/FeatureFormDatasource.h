//
//  UserInputFeatureField.h
//  GeoFormsMappit
//
//  Created by Nick Blackwell on 2014-08-08.
//  Copyright (c) 2014 Nick Blackwell. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol FeatureFormDatasource <NSObject>


-(id) getFormDataForKey:(NSString *)key;
-(void) setFormData:(id) object forKey:(NSString *)key;
-(void) setActiveView:(UIView *)view;

-(UINavigationController *) getNavigationController;


@end
