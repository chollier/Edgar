@import <Foundation/CPObject.j>
@import "DatePicker/DatePicker.j"

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
    [addButton setEnabled:NO];
}

-(@action)addButtonPressed:(id)sender 
{
	console.log("add pressed");
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
    if ([anEvent type] === CPKeyUp && [anEvent keyCode] === CPTabKeyCode)
        [self makeFirstResponder:nom];
    else
        [super sendEvent:anEvent];
}

@end
