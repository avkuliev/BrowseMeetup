//
//  MasterViewController.m
//  BrowseMeetup
//
//  Created by Alexander Kuliev on 10/30/14.
//  Copyright (c) 2014 Alexander Kuliev. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailCell.h"
#import "Group.h"
#import "MeetupManager.h"
#import "MeetupCommunicator.h"

@interface MasterViewController () <MeetupManagerDelegate>{
    NSArray *_groups;
    MeetupManager *_manager;
}

@property (nonatomic, weak) CLLocationManager *locationManager;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _manager = [MeetupManager new];
    _manager.communicator = [MeetupCommunicator new];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startFetchingGroups:) name:@"kCLAuthorizationStatusAuthorized" object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startFetchingGroups:(NSNotification *)notifiaction {

    [_manager fetchGroupsAtCoordinate:self.locationManager.location.coordinate];
}

#pragma mark - MeetupManagerDelegate protocol

-(void)didReceiveGroups:(NSArray *)groups {
    
    _groups = groups;
    [self.tableView reloadData];
}

-(void)fetchingGroupsFailedWithError:(NSError *)error {
    
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}


#pragma mark - Accessors

- (CLLocationManager *)locationManager
{
    if (_locationManager) {
        return _locationManager;
    }
    
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(locationManager)]) {
        _locationManager = [appDelegate performSelector:@selector(locationManager)];
    }
    return _locationManager;
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Group *group = _groups[indexPath.row];
    [cell.nameLabel setText:group.name];
    [cell.whoLabel setText:group.who];
    [cell.locationLabel setText:[NSString stringWithFormat:@"%@, %@", group.city, group.country]];
    [cell.descriptionLabel setText:group.description];

    return cell;
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
