//
// ViewController.m
// lab08_1
//
// Created by Admin on 13.05.16.
// Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <MapKit/MapKit.h>

@interface ViewController ()
{
    int isCity;
    MKPointAnnotation *annotatiionFrom;
    MKPointAnnotation *annotatiionTo;
    NSArray *results;
}
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) IBOutlet UITableView *infoTable;
@property (strong, nonatomic) IBOutlet UITableView *resultsTable;
@property (strong, nonatomic) IBOutlet UILabel *message;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILongPressGestureRecognizer *longPressGesture =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.map addGestureRecognizer:longPressGesture];
    isCity = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showFlights:(id)sender
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    results = [app getAllFlights];
    results=[app getFlightsFrom:[_cityFrom text] To:[_cityTo text]];
    if([results count] > 0) {
        [_message setText:[NSString stringWithFormat:@"Flights: %lu", [results count]]];
        [_resultsTable reloadData];
    }
    else {
        [_message setText:@"Not found"];
        [_resultsTable reloadData];
    }
    
}

-(void)handleLongPressGesture:(UIGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint point = [sender locationInView:self.map];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        CLLocationCoordinate2D coord = [self.map convertPoint:point
                                         toCoordinateFromView:self.map];
        CLLocation *location = [[CLLocation alloc]
                                initWithLatitude:coord.latitude longitude:coord.longitude];
        [geocoder reverseGeocodeLocation:location
                       completionHandler:^(NSArray *placemarks, NSError *error)
        {
            if (error)
            {
                NSLog(@"Error: %@", error);
                return;
            }
            for (CLPlacemark * placemark in placemarks)
            {
                [self setAnnotationToMap:isCity :placemark.locality:coord];
            }
        }];
        if(isCity == 1)
            isCity = 2;
        else
            isCity = 1;
    }}



-(void)setAnnotationToMap:(int)type :(NSString *)title
                         :(CLLocationCoordinate2D)coordinate
{
    if (type == 1) {
        [_map removeAnnotation:annotatiionFrom];
        annotatiionFrom= [[MKPointAnnotation alloc] init];
        annotatiionFrom.title = title;
        annotatiionFrom.coordinate = coordinate;
        [_map addAnnotation:annotatiionFrom];
        self.cityFrom.text = title;
    } 
    else 
    { 
        [_map removeAnnotation:annotatiionTo]; 
        annotatiionTo= [[MKPointAnnotation alloc] init]; 
        annotatiionTo.title = title; 
        annotatiionTo.coordinate = coordinate; 
        [_map addAnnotation:annotatiionTo]; 
        self.cityTo.text = title; 
    } 
} 

-(void)textFieldDidBeginEditing:(UITextField *)textField 
{ 
    if (textField == self.cityFrom) 
        isCity = 1; 
    else if (textField == self.cityTo) 
        isCity = 2; 
    [textField resignFirstResponder]; 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(results == nil) {
        return 0;
    }
    return [results count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    Record *rec = (Record *)[results objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@", rec.aviaCompany, rec.price];
    
    return cell;
}


@end
