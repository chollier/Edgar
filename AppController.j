/*
 * AppController.j
 * Edgard
 *
 * Created by You on April 7, 2011.
 * Copyright 2011, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>

/*@import <AppKit/CPToolbar.j>
@import <AppKit/CPToolbarItem.j>*/
@import <CappuccinoResource/CRBase.j>
@import "ClientViewController.j"
@import "AgenceViewController.j"
@import "ClientsController.j"


@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
	//CPViewController mainViewController;
	ClientViewController theClientViewController;
	ClientsController theClientController;
	AgenceViewController theAgenceViewController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
	contentView = [theWindow contentView];
	
//	[contentView setBackgroundColor:[CPColor redColor]];
	
	theClientController = [[ClientsController alloc] init];
	[theClientController getClients];
	
	theClientViewController =  [[ClientViewController alloc] initWithCibName:@"Clients" bundle:nil controller:theClientController];
	[[theClientViewController view] setFrame:[contentView bounds]];
	
	theAgenceViewController =  [[AgenceViewController alloc] initWithCibName:@"Agences" bundle:nil];
	[[theAgenceViewController view] setFrame:[contentView bounds]];
}

- (void)awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things. 
    
    // In this case, we want the window from Cib to become our full browser window
    [theWindow setFullBridge:YES];
}

- (@action) toolbarButtonClicked:(id)sender {
	//alert("Hello "+ [sender label]);
	if([[contentView subviews] count] > 0) {
		[[contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	}
	
	switch([sender label])
	{
		case @"Agences":
			[contentView addSubview:[theAgenceViewController view]];
			break;
		case @"Clients":
			[contentView addSubview:[theClientViewController view]];
			break;
	}
	
	
	
	
	console.log('-- nb subviews : ' + [[contentView subviews] count]);
    
	
}

@end
