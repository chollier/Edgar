@import <AppKit/CPView.j>

@implementation ClientView : CPView
{
	Client client @accessors;
	@outlet CPTextField clientName;
}

-(void)setClient:(id)aClient
{
	client = aClient;
	[clientName setStringValue:[aClient nom]];
}

-(void)clear
{
	[clientName setStringValue:@""];
}

@end