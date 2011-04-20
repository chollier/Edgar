@import <AppKit/CPButtonBar.j>
@import "ClientView.j"
@import "NewClientWindows.j"


@implementation ClientViewController : CPViewController
{
	id controller;

	@outlet CPButtonBar buttonBar;
	@outlet CPSplitView leftSplitView;
	@outlet CPSplitView rightSplitView;
	@outlet CPTableView clientListView;
	@outlet ClientView clientView;
}

-(id)initWithCibName:(CPString)aCibName bundle:(CPBundle)aBundle controller:(id)aController
{
	if(self = [super initWithCibName:aCibName bundle:aBundle])
	{
		controller = aController;
	}
	
	[[CPNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadListView:) name:@"ClientListDidUpdate" object:nil];
	
	return self;
}

- (void) viewDidLoad
{
	console.log("client view did load");
	

	
}

- (void) awakeFromCib
{
	var addButton = [CPButtonBar plusButton];
	[addButton setAction:@selector(promptForNewClient:)];
	[addButton setTarget:self];
	[addButton setEnabled:YES];

	var minusButton = [CPButtonBar minusButton];
	[minusButton setAction:@selector(removeClient:)];
	[minusButton setTarget:self];
	[minusButton setEnabled:YES];
	
/*	var reloadButton = [CPButtonBar minusButton];
	[reloadButton setAction:@selector(reloadListView:)];
	[reloadButton setTarget:self];
	[reloadButton setEnabled:YES];
	*/
/*	[buttonBar setButtons:[addButton, minusButton, reloadButton]];*/
	[buttonBar setButtons:[addButton, minusButton]];
	[buttonBar setHasResizeControl:NO];	
	

	[clientListView setIntercellSpacing:CGSizeMakeZero()];
	[clientListView setHeaderView:nil]
	[clientListView setCornerView:nil]

/*	var column = [[CPTableColumn alloc] initWithIdentifier:"clientlist"];
	[[column headerView] setStringValue:"Clients"];

	[column setWidth:220.0];
	[column setMinWidth:50.0];
/*	 	[column setEditable:YES];*/
	    

/*	[clientListView addTableColumn:column];*/
	
	[clientListView setColumnAutoresizingStyle:CPTableViewLastColumnOnlyAutoresizingStyle];
	[clientListView setRowHeight:26.0];
	
	[clientListView setDelegate:self]
	[clientListView setDataSource:self]
	
	[clientListView setSelectionHighlightStyle:CPTableViewSelectionHighlightStyleSourceList];
/*	[clientListView setVerticalMotionCanBeginDrag:YES];*/
/*	[clientListView setDraggingDestinationFeedbackStyle:CPTableViewDropAbove];*/
/*	[clientListView registerForDraggedTypes:[@"GitHubIssuesRepoSourceListDragType"]];*/

/*	[[[clientListView enclosingScrollView] superview] setBackgroundColor:[CPColor colorWithHexString:@"eef2f8"]];*/


}

-(void)promptForNewClient:(id)sender
{
	//console.log("prout");
	var clientWindow = [NewClientWindow sharedNewClientWindow];
	[clientWindow makeKeyAndOrderFront:self];
}

-(void)addClient:(id)aClient
{
	[self addClient:aClient shouldSelect:YES];
}

-(void)addClient:(id)aClient select:(BOOL)shouldSelect
{
	if(!aClient) return;
	
	[clientListView reloadData];
}

-(void)removeClient:(id)sender
{
	previousSelected = [self selectedClientIndex];
	
	[controller removeClientAtIndex:previousSelected];
	
	[clientListView reloadData];
	
	//TODO : faire en sorte que ça selectionne qqchose ou afficher la noClientView
	//[self setSelectedContactIndex:previousSelected-1];
	
}

-(int)selectedClientIndex
{
	return [[clientListView selectedRowIndexes] firstIndex];
}

-(void)setSelectedContactIndex:(int)anIndex
{
	[clientListView selectedRowIndexed:[CPIndexSet indexSetWithIndex:anIndex] byExtendingSelection:NO];
	[clientListView scrollRowToVisible:anIndex];
}

- (void)setCurrentClient:(id)aClient
{
	if(aClient != [clientView client]) {
		if(aClient) {
			[clientView setClient:aClient];
		} else {
			[clientView clear];
		}
	}
}

-(void)reloadListView:(id)sender
{
	[controller getClients];
	
	[clientListView reloadData];	
}


// Code pour le delegate du tableView
- (int)numberOfRowsInTableView:(CPTableView)aTableView
{
	return [[controller clients] count];
}

- (id)tableView:(CPTableView)aTableView objectValueForTableColumn:(CPTableColumn)aColumn row:(int)aRow
{
	return [[controller clients][aRow] prenom] + ' ' + [[controller clients][aRow] nom];
}

- (void)tableViewSelectionDidChange:(CPEvent)anEvent
{
	var index = [self selectedClientIndex];
	if(index > -1) {
		[self setCurrentClient:[controller clients][index]];
	}
}



@end
