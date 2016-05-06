//  LoginViewController.m

#import "LoginViewController.h"
#import "SignupViewController.h"
#import "Parse/Parse.h"
#import "User.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize promptLblGeneral;
@synthesize passwordTxt;
@synthesize usernameTxt;
@synthesize loginBtn;
User *currentUser;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.promptLblGeneral.hidden = YES;
    
    UITapGestureRecognizer *tapViewGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnView)];
    [self.view addGestureRecognizer:tapViewGR];
    
    loginBtn.userInteractionEnabled = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)didTapOnView {
    [self.usernameTxt resignFirstResponder];
    [self.passwordTxt resignFirstResponder];
}

- (IBAction)signup:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignupViewController *viewController = (SignupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"signupScreen"];
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:viewController animated:NO completion:nil];
}

- (IBAction)login:(id)sender {
    
    [self checkCredentials: self.usernameTxt.text andPassword:self.passwordTxt.text];
}

-(void)checkCredentials:(NSString *)username andPassword:(NSString*)password
{
    __weak typeof(self) weakSelf = self;
    [PFUser logInWithUsernameInBackground:username
                                 password:password
                                    block:^(PFUser *pfUser, NSError *error)
     {
         if (pfUser && !error) {
             
             // Proceed to next screen after successful login.
             NSString *userType = [[PFUser currentUser] objectForKey:@"UserType"];
             
             if([userType isEqual: @"Admin"])
             {
                 // The login failed. Show error.
                 weakSelf.promptLblGeneral.textColor = [UIColor redColor];
                 weakSelf.promptLblGeneral.text = NSLocalizedString(@"invalid login parameters", nil);
                 weakSelf.promptLblGeneral.hidden = NO;
             }
             else
             {
                 weakSelf.promptLblGeneral.hidden = YES;
                 
                 currentUser = [[User alloc]init];
                 currentUser.username = [[PFUser currentUser] objectForKey:@"username"];
                 [self setUsername:currentUser.username];
                 

                 [self setUserLogin:@"in" andUser:currentUser];
                 
                 // Send notification
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccessful" object:self];
                 
                 // Dismiss login screen
                 [self dismissViewControllerAnimated:YES completion:nil];
                 
             }
         }
         else
         {
             // The login failed. Show error.
             weakSelf.promptLblGeneral.textColor = [UIColor redColor];
             weakSelf.promptLblGeneral.text = NSLocalizedString(@"invalid login parameters", nil);
             weakSelf.promptLblGeneral.hidden = NO;
         }
     }];
}

- (IBAction)forgotPassword:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Email Address", nil)
                                                        message:NSLocalizedString(@"Enter the email for your account:", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                              otherButtonTitles:NSLocalizedString(@"Ok", nil), nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        
        UITextField *emailAddress = [alertView textFieldAtIndex:0];
        
        [PFUser requestPasswordResetForEmailInBackground: emailAddress.text];
        
        UIAlertView *alertViewSuccess = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success! A reset email was sent to you", nil) message:@""
                                                                  delegate:self
                                                         cancelButtonTitle:NSLocalizedString(@"Ok", nil)
                                                         otherButtonTitles:nil];
        [alertViewSuccess show];
    }
}

-(void)setUserLogin:(NSString *)loggedInStatus andUser:(User*)currentUser
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults setObject:loggedInStatus forKey:@"loggedin"];
    currentUser.isLoggedIn = TRUE;
}

-(void)setUsername:(NSString *)username
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults setObject:username forKey:@"username"];
}

@end
