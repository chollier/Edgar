@import <CappuccinoResource/CRBase.j>

@implementation Note : CappuccinoResource
{
	CPNumber client_id @accessors;
	CPNumber staff_id @accessors;
	CPNumber note @accessors;
	CPString type @accessors;
	
	CPNumber code_session_id @accessors;
	CPNumber plateau_session_id @accessors;
		
	CPDate created_at;
	CPDate updated_at;
}

-(JSObject)attributes
{
	return {
		"note": {
			"client_id":client_id,
			"staff_id":staff_id,
			"note":note,
			"type":type,
			"code_session_id":code_session_id,
			"plateau_session_id":plateau_session_id,
			"created_at":[created_at toDateString],
			"updated_at":[updated_at toDateString]
		}
	}
}

@end