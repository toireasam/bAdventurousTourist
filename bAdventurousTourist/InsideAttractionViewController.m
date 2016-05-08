//  InsideAttractionViewController.m

#import "InsideAttractionViewController.h"
#import <EstimoteSDK/EstimoteSDK.h>
#import "FurtherInfoViewController.h"
#import "SettingsViewController.h"
#import "TouristLocationArtefact.h"
#import "NearablesParseController.h"

@interface ESTTableViewCell : UITableViewCell

@end

@implementation ESTTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

@end

@interface InsideAttractionViewController () <UITableViewDelegate, UITableViewDataSource, ESTNearableManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *nearablesArray;
@property (nonatomic, strong) ESTNearableManager *nearableManager;

@end

@implementation InsideAttractionViewController

@synthesize touristLocationName;
NSString *museumsOn;
TouristLocationArtefact *locationPainting;
NearablesParseController *nearablesParseManager;
TouristLocation *insideTouristLocation;

-(void)viewWillAppear:(BOOL)animated
{
    [insideTouristAttractionBeacons removeAllObjects];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationPainting = [[TouristLocationArtefact alloc]init];
    nearablesParseManager = [[NearablesParseController alloc]init];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ESTTableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    
    [self.view addSubview:self.tableView];
    
    self.nearableManager = [ESTNearableManager new];
    self.nearableManager.delegate = self;
    [self.nearableManager startRangingForType:ESTNearableTypeAll];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)getUserDefaults
{
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([[standardDefaults stringForKey:@"museumSwitchKey"] isEqual: @"On"])
    {
        museumsOn = @"true";
    }
    else
    {
        museumsOn = @"false";
    }
}

-(void)getRelevantNearables
{
    insideTouristAttractionBeacons = [[NSMutableArray alloc] init];
    int i;
    for (i = 0; i < [self.nearablesArray count]; i++) {
        
        ESTNearable *nearable = [self.nearablesArray objectAtIndex:i];
        locationPainting.touristLocationCategory = [nearablesParseManager getArtefactCategory:nearable.identifier];
        insideTouristLocation = [[TouristLocation alloc]init];
        insideTouristLocation.touristLocationName = touristLocationName;
        if([locationPainting.touristLocationCategory  isEqual:@"museum" ] && [touristLocationName isEqual:@"Ulster Museum"])
        {
            [insideTouristAttractionBeacons addObject:nearable];
            
        }
        else if([locationPainting.touristLocationCategory  isEqual:@"cityhall" ] && [touristLocationName isEqual:@"Belfast City Hall"])
        {
            
            [insideTouristAttractionBeacons addObject:nearable];
            
        }
        else
        {
            
        }
    }
    
    [self.tableView reloadData];
}

NSMutableArray *insideTouristAttractionBeacons;
- (void)nearableManager:(ESTNearableManager *)manager
      didRangeNearables:(NSArray *)nearables
               withType:(ESTNearableType)type
{
    self.nearablesArray = nearables;
    
    [self getRelevantNearables];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [insideTouristAttractionBeacons count];
}

- (UIImage *)getArtefactImage:(NSString *)identifier
{
    if([identifier  isEqual: @"6e3972e4eacf21c7"])
    {
        return [UIImage imageNamed:@"museum"];
    }
    else if([identifier  isEqual: @"71fe18a348f33406"])
    {
        return [UIImage imageNamed:@"museum"];
    }
    else if([identifier  isEqual: @"5d80738722997275"])
    {
        return [UIImage imageNamed:@"museum"];
    }
    else if([identifier  isEqual: @"c2aab0fa802b664b"])
    {
        return [UIImage imageNamed:@"museum"];
    }
    else if([identifier  isEqual: @"5583e7200f965302"])
    {
        return [UIImage imageNamed:@"citycouncil"];
    }
    else
    {
        return @"unknown";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESTNearable *nearable = [insideTouristAttractionBeacons objectAtIndex:indexPath.row];
    ESTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    locationPainting.artefactName = [nearablesParseManager getArtefactName:nearable.identifier];
    
    cell.textLabel.text = locationPainting.artefactName;
    
    cell.imageView.image = [[UIImage alloc] init];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 100, 25, 30, 30)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setImage:[self getArtefactImage:nearable.identifier]];
    [cell.contentView addSubview:imageView];
    
    if (indexPath.row == 0) // Top row
    {
        cell.textLabel.text = locationPainting.artefactName;
        [cell.textLabel setTextColor:[UIColor redColor]];
    }
    else
    {
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    locationPainting.artefactName = cell.textLabel.text;
    
    [self performSegueWithIdentifier:@"furtherInfoScreen" sender:tableView];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"furtherInfoScreen"]) {
        FurtherInfoViewController *nextVC = (FurtherInfoViewController *)[segue destinationViewController];
        nextVC.artefactNameTxt = locationPainting.artefactName;
    }
}

@end
