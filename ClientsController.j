@import <Foundation/CPObject.j>
@import "Client.j"

@implementation ClientsController : CPObject
{
	CPArray clients @accessors;
}

-(id)init
{
	if(self = [super init])
	{
		clients = [CPArray array];
		
		[[CPNotificationCenter defaultCenter] addObserver:self selector:@selector(updateClient:) name:@"ClientResourceDidUpdate" object:nil];
	}
	
	return self;
}

-(void)getClients
{
	clients = [Client all];
}

-(void)addClient
{
	client = [Client create:{"nom":"Vide"}];
	[clients insertObject:client atIndex:0];
	[[CPNotificationCenter defaultCenter] postNotificationName:@"ClientListDidUpdate" object:self];
}

- (void)removeClientAtIndex:(int)anIndex
{
    var client = clients[anIndex];
    [clients removeObjectAtIndex:anIndex];
    [client destroy];
    [[CPNotificationCenter defaultCenter] postNotificationName:@"ClientListDidUpdate"
                                                        object:self];
}

- (void)updateClient:(id)sender
{
    var client  = [sender object],
        newIndex = 0;

    for (var i = 0; i < clients.length; ++i) {
        if ([clients[i] identifier] === [client identifier]) {
            clients[i] = client;
        }
    }

    [clients sortUsingSelector:@selector(sortByName:)];

    for (var i = 0; i < clients.length; ++i) {
        if ([clients[i] identifier] === [client identifier]) {
            newIndex = i;
        }
    }

    [[CPNotificationCenter defaultCenter] postNotificationName:@"ClientListDidUpdate"
                                                        object:self
                                                      userInfo:[CPDictionary dictionaryWithObject:newIndex
                                                                                           forKey:@"index"]];
}


@end