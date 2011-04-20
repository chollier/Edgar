@import <Foundation/CPObject.j>
@import "DatePicker/DatePicker.j"
@import "ClientsController.j"

var SharedClientWindow = nil;

@implementation NewClientWindow : CPWindow
{
    @outlet CPTextField nom @accessors;
    @outlet CPTextField prenom @accessors;
    @outlet DatePicker datedenaissance @accessors;
    @outlet CPTextField telephone @accessors;
    @outlet CPTextField email @accessors;
    @outlet CPTextField adresse @accessors;
    @outlet CPTextField codepostal @accessors;
    @outlet CPTextField ville @accessors;


    @outlet ClientsController clientsController;

    @outlet CPButton    addButton;
    @outlet CPButton    cancelButton;

	//@outlet ClientController clientController;
}

+ (id)sharedNewClientWindow
{
   return SharedClientWindow;
}

- (void)awakeFromCib
{
	console.log("new client window woke up");
   	SharedClientWindow = self;
    [super awakeFromCib];

	[datedenaissance displayPreset:1];
	[datedenaissance setDelegate:self];
//    [identifierField setValue:[CPColor grayColor] forThemeAttribute:"text-color" inState:CPTextFieldStatePlaceholder];
}

- (id)initWithContentRect:(CGRect)aRect styleMask:(unsigned)aMask
{
	
    if (self = [super initWithContentRect:aRect styleMask:aMask])
    {
		//console.log("new client window init");
	
        [self center];
        //[self setMovableByWindowBackground:YES];
        [cancelButton setKeyEquivalent:CPEscapeFunctionKey];
    }

    return self;
}

- (@action)orderFront:(id)sender
{
    [super orderFront:sender];
    [nom setStringValue:""];
    //[addButton setEnabled:NO];
}

-(@action)addButtonPressed:(id)sender 
{
	console.log("add pressed");
	
	if ([[nom stringValue] length] != 0 && [[prenom stringValue] length] != 0 && [datedenaissance date] != nil && [[telephone stringValue] length] != 0 && [[email stringValue] length] != 0 && [[adresse stringValue] length] != 0 && [[codepostal stringValue] length] != 0 && [[ville stringValue] length] != 0)
	{
		console.log([[datedenaissance date] toDateString]);
		//sale
		clientController = [[ClientsController alloc] init];
		
		client = [clientController addClient:{"nom":[nom stringValue], "prenom":[prenom stringValue], "anniversaire":[[datedenaissance date] toDateString], "telephone":[telephone stringValue], "email":[email stringValue], "adresse":[adresse stringValue], "codepostal":[codepostal intValue], "ville":[ville stringValue], "notes_memo":@"blah", "alias":[[nom stringValue] stringByAppendingString:[prenom stringValue]], "password":@"lol"}];

		[[CPNotificationCenter defaultCenter] postNotificationName:@"ClientAdded" object:nil];
		
		
		[self orderOut:self]
	} else
	{
		console.log("we're not ok");
	}
}

/*- (@action)addRepository:(id)sender
{
    var repoIdentifier = [identifierField stringValue];
    if (!repoIdentifier)
        return;

    var existingRepo = [[GithubAPIController sharedController] repositoryForIdentifier:repoIdentifier];
    if (existingRepo)
    {
        [repoController addRepository:existingRepo];
        [self orderOut:self];
        return;
    }

    [[GithubAPIController sharedController] loadRepositoryWithIdentifier:repoIdentifier callback:function(repo)
    {
        [progressIndicator setHidden:YES];
        [errorMessageField setHidden:!!repo];
        [defaultButton setEnabled:YES];
        [cancelButton setEnabled:YES];

        if (repo)
        {
            [repoController addRepository:repo];
            [self orderOut:self];
        }
    }];    

    [errorMessageField setHidden:YES];
    [progressIndicator setHidden:NO];
    [defaultButton setEnabled:NO];
    [cancelButton setEnabled:NO];
}*/

- (void)sendEvent:(CPEvent)anEvent
{
/*    if ([anEvent type] === CPKeyUp && [anEvent keyCode] === CPTabKeyCode)
      //  [self makeFirstResponder:nom];
    else*/
        [super sendEvent:anEvent];
}

-(void)datePickerValue:(id)sender
{
	//[theDatePicker setDate:[CPDate dateWithTimeIntervalSinceNow:9000000]];
	//console.log([datedenaissance date]);
}

-(void)datePickerDidChange:(id)sender
{
	/*if([sender object] === theDatePicker){
		[theDatePicker2 setMinDate: [theDatePicker date]];
	}*/
	//[self datePickerValue:sender];
}

@end
