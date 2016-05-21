//
//  AppDelegate.h
//  lab8_1
//
//  Created by Admin on 14.05.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator
*persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSArray*)getAllFlights;
- (NSArray *)getFlightsFrom:(NSString *)cityFrom To:(NSString *)cityTo;


@end

