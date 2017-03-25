#import "TembooTask.h"

@implementation TembooTask

-(id)initWithLabel:(UILabel*) label {
	if(self = [super init]){
		self.label = label;
	}
	return self;
}

-(void)runTask {
	self.label.text = @"Triggered! Calling Choreo...";
	
	// Create a Temboo session 
	TMBTembooSession *session = [[TMBTembooSession alloc] initWithAccount:@"accountName" appKeyName:@"myFirstApp" andAppKeyValue:@"abc123xxxxxxxxxxxxxx"];
	
	// Create the Choreo object using your Temboo session
	TMBGoogle_Gmail_SendEmail *sendEmailChoreo = [[TMBGoogle_Gmail_SendEmail alloc] initWithSession:session];	
	
	// Get Inputs object for the Choreo
	TMBGoogle_Gmail_SendEmail_Inputs *sendEmailInputs = [sendEmailChoreo newInputSet];

	// Set inputs
	[sendEmailInputs setFromAddress:@"yourValueHere"];
	[sendEmailInputs setUsername:@"yourValueHere"];
	[sendEmailInputs setToAddress:@"yourValueHere"];
	[sendEmailInputs setSubject:@"yourValueHere"];
	[sendEmailInputs setMessageBody:@"yourValueHere"];
	[sendEmailInputs setPassword:@"yourValueHere"];

	// Execute Choreo specifying this class as the Choreo delegate
	[sendEmailChoreo executeWithInputs:sendEmailInputs delegate:self];
}

// TMBChoreographyDelegate method implementation - handle Choreo errors
-(void)choreographyDidFailWithError:(NSError*)error {
	self.label.text = @"A Choreo error occurred. Check logs for details.\nhttp://temboo.com/activity/logs";
	// Log error to the console
	NSLog(@"Error - %@", [error userInfo]);
}

// TMBChoreographyDelegate method implementation - Choreo executed successfully
-(void)choreographyDidFinishExecuting:(TMBGoogle_Gmail_SendEmail_ResultSet*)result {
	self.label.text = @"Done!";
	// Do something with result...
}

@end