//  FurtherInformationControllerViewController.m

#import "FurtherInfoViewController.h"
#import "TouristLocationArtefact.h"
#import "LanguageController.h"
#import "iCarousel.h"
#import "TouristLocationArtefact.h"

@interface FurtherInfoViewController ()

@end

@implementation FurtherInfoViewController

@synthesize artefactNameTxt;
@synthesize artefactNameLbl;
@synthesize artefactInfoLbl;
NSMutableArray *imagesOfAttraction;
NSString *currentLanguage;
TouristLocationArtefact *locationArtefact;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationArtefact = [[TouristLocationArtefact alloc]init];
    locationArtefact.artefactName = artefactNameTxt;
    
    LanguageController *languageManager = [[LanguageController alloc]init];
    currentLanguage = [languageManager getCurrentLanguage];
    
    [self getArtefactInfo];
    [self getArtefactImages];
    
    // Configure carousel
    _carousel.type = iCarouselTypeCoverFlow2;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _pinchRecog = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(changeFontSize:)];
    [_pinchText addGestureRecognizer:_pinchRecog];
    
}

-(void)getArtefactImages
{
    imagesOfAttraction = [NSMutableArray array];
    
    PFQuery *query = [PFQuery queryWithClassName:@"InsideTouristLocation"];
    [query whereKey:@"InsideTouristLocationArtefact" equalTo:locationArtefact.artefactName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            // The find succeeded. The first 100 objects are available in objects
            [imagesOfAttraction addObjectsFromArray:objects];
            [_carousel reloadData];
            
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)changeFontSize:(UIPinchGestureRecognizer *)gestureRecognizer {
    
    _pinchText = (UITextView *)gestureRecognizer.view;
    float yourFontSize = gestureRecognizer.scale * 18;
    _pinchText.font = [UIFont systemFontOfSize:yourFontSize];
    
}

-(void)getArtefactInfo
{
    PFQuery *query = [PFQuery queryWithClassName:currentLanguage];
    [query whereKey:@"InsideTouristLocationArtefact" equalTo:locationArtefact.artefactName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            // The find succeeded.
            if(objects.count == 0)
            {
                // No beacons were found
                
            }
            for (PFObject *object in objects)
            {
                artefactNameLbl.text = object[@"InsideTouristLocationArtefact"];
                _pinchText.text = object[@"Information"];
                _pinchText.textColor = [UIColor darkGrayColor];
            }
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [imagesOfAttraction removeAllObjects];
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [imagesOfAttraction count];
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
    
    // Create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 300.0f)];
        
    }
    
    PFObject *eachObject = [imagesOfAttraction objectAtIndex:index];
    PFFile *theImage = [eachObject objectForKey:@"ArtefactImage"];
    NSData *imageData = [theImage getData];
    UIImage *image = [UIImage imageWithData:imageData];
    
    ((UIImageView *)view).image = image;
    view.contentMode = UIViewContentModeCenter;
    
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
