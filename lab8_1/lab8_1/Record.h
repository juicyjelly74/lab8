//
//  Record.h
//  lab8_1
//
//  Created by Admin on 14.05.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Record : NSManagedObject
@property (nonatomic, retain) NSString * cityfrom;
@property (nonatomic, retain) NSString * cityto;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSNumber * price;
@end

NS_ASSUME_NONNULL_END

#import "Record+CoreDataProperties.h"
