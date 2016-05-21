//
// AppDelegate.m
// lab08_1
//
// Created by Admin on 13.05.16.
// Copyright © 2016 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "Record.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    if (![[NSUserDefaults standardUserDefaults]
          boolForKey:@"HasLaunchedOnce"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        Record * firstFlight =
        [NSEntityDescription
         insertNewObjectForEntityForName:@"Record"
         inManagedObjectContext:self.managedObjectContext];
        firstFlight.cityFrom = @"Челябинск";
        firstFlight.cityTo = @"Москва";
        firstFlight.aviaCompany
        = @"Аэрофлот";
        firstFlight.price = [NSNumber numberWithInt:1000.0];
        Record * secondFlight =
        [NSEntityDescription
         insertNewObjectForEntityForName:@"Record"
         inManagedObjectContext:self.managedObjectContext];
        secondFlight.cityFrom = @"Челябинск";
        secondFlight.cityTo = @"Москва";
        secondFlight.aviaCompany = @"ЧелАвиа";
        secondFlight.price = [NSNumber numberWithInt:2000.0];
        Record * thirdFlight = [NSEntityDescription insertNewObjectForEntityForName:@"Record"
                                                             inManagedObjectContext:self.managedObjectContext];
        thirdFlight.cityFrom = @"Екатеринбург";
        thirdFlight.cityTo = @"Уфа"; thirdFlight.aviaCompany =
        @"Аэрофлот";
        thirdFlight.price = [NSNumber
                             numberWithInt:500.0];
        Record * fourthFlight =
        [NSEntityDescription
         insertNewObjectForEntityForName:@"Record"
         inManagedObjectContext:self.managedObjectContext];
        fourthFlight.cityFrom = @"Челябинск";
        fourthFlight.cityTo = @"Уфа"; fourthFlight.aviaCompany =
        @"РусЛайн"; fourthFlight.price = [NSNumber
                                          numberWithInt:1500.0];
        Record * fivthFlight =
        [NSEntityDescription
         insertNewObjectForEntityForName:@"Record"
         inManagedObjectContext:self.managedObjectContext];
        fivthFlight.cityFrom = @"Екатеринбург";
        fivthFlight.cityTo = @"Москва";
        fivthFlight.aviaCompany = @"Аэрофлот";
        fivthFlight.price = [NSNumber numberWithInt:800.0];
        
        Record * sixthFlight =
        [NSEntityDescription
         insertNewObjectForEntityForName:@"Record"
         inManagedObjectContext:self.managedObjectContext];
        sixthFlight.cityFrom = @"Minsk";
        sixthFlight.cityTo = @"Smolensk";
        sixthFlight.aviaCompany = @"BelAvia";
        sixthFlight.price = [NSNumber numberWithInt:800.0];
        
        Record * seventhFlight =
        [NSEntityDescription
         insertNewObjectForEntityForName:@"Record"
         inManagedObjectContext:self.managedObjectContext];
        seventhFlight.cityFrom = @"Smolensk";
        seventhFlight.cityTo = @"Minsk";
        seventhFlight.aviaCompany = @"BelAvia";
        seventhFlight.price = [NSNumber numberWithInt:800.0];
        [self saveContext];
    }
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

// 1
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}
//2
- (NSManagedObjectModel *)managedObjectModel {  if (_managedObjectModel != nil) {
    return _managedObjectModel;
}
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"flight" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel; }
//3
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator { if
    (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator; }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"flight.sqlite"];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil URL:storeURL options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    return _persistentStoreCoordinator;
} 

-(void)saveContext 
{{ 
    NSError *error = nil; NSManagedObjectContext *managedObjectCont =
    self.managedObjectContext; if(nil != managedObjectCont) { 
        if([managedObjectCont hasChanges] && ![managedObjectCont save:&error]){ 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]); 
            abort(); } 
    } 
} 
}

- (NSArray *)getFlightsFrom:(NSString *)cityFrom To:(NSString *)cityTo
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"cityFrom == %@ and cityTo == %@", cityFrom, cityTo]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Record" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return [fetchedRecords sortedArrayUsingComparator: ^NSComparisonResult(id obj1, id obj2) {
        if(((Record *)obj1).price < ((Record *)obj2).price) {
            return NSOrderedAscending;
        }
        if(((Record *)obj1).price > ((Record *)obj2).price) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    
}

-(NSArray*)getAllFlights
{ 
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init]; NSEntityDescription *entity = [NSEntityDescription entityForName:@"Record" inManagedObjectContext:self.managedObjectContext]; 
    [fetchRequest setEntity:entity]; 
    NSError* error; NSArray *fetchedRecords = 
    [self.managedObjectContext 
     executeFetchRequest:fetchRequest error:&error]; 
    return fetchedRecords; 
} 

@end