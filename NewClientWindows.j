@import <Foundation/CPObject.j>

var SharedRepoWindow = nil;

@implementation NewRepoWindow : CPWindow
{
    @outlet CPTextField identifierField @accessors;
    @outlet RepositoriesController repoController;

    @outlet CPButton    defaultButton;
    @outlet CPButton    cancelButton;
}

+ (id)sharedNewRepoWindow
{
    return SharedRepoWindow;
}

- (void)awakeFromCib
{
    SharedRepoWindow = self;
    [super awakeFromCib];
    [identifierField setValue:[CPColor grayColor] forThemeAttribute:"text-color" inState:CPTextFieldStatePlaceholder];
}




- (id)initWithContentRect:(CGRect)aRect styleMask:(unsigned)aMask
{
    if (self = [super initWithContentRect:aRect styleMask:0])
    {
        [self center];
        [self setMovableByWindowBackground:YES];
        [cancelButton setKeyEquivalent:CPEscapeFunctionKey];
    }

    return self;
}

- (@action)orderFront:(id)sender
{
    [super orderFront:sender];
    [errorMessageField setHidden:YES];
    [progressIndicator setHidden:YES];
}

- (void)controlTextDidChange:(CPNotification)aNote
{
    if ([aNote object] !== identifierField)
        return;

    if (![identifierField stringValue])
        [defaultButton setEnabled:NO];
    else
        [defaultButton setEnabled:YES];
}

- (@action)orderFront:(id)sender
{
    [super orderFront:sender];
    [identifierField setStringValue:""];
    [defaultButton setEnabled:NO];
}


- (void)setDefaultButton:(CPButton)aButton
{
    [super setDefaultButton:aButton];
    defaultButton = aButton;
}

- (@action)addRepository:(id)sender
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
}

- (void)sendEvent:(CPEvent)anEvent
{
    if ([anEvent type] === CPKeyUp && [anEvent keyCode] === CPTabKeyCode)
        [self makeFirstResponder:identifierField];
    else
        [super sendEvent:anEvent];
}

@end
