@import <CappuccinoResource/CRBase.j>

@implementation Clients_code_sessions_join_table : CappuccinoResource
{
	CPNumber client_id @accessors;
	CPNumber code_session_id @accessors;
	
	CPDate created_at;
	CPDate updated_at;
}

-(JSObject)attributes
{
	return {
		"Clients_code_sessions_join_table": {
			"client_id":client_id,
			"code_session_id":code_session_id,
			"created_at":[created_at toDateString],
			"updated_at":[updated_at toDateString]
		}
	}
}

@end