@import <CappuccinoResource/CRBase.j>

@implementation Code_session : CappuccinoResource
{
	CPNumber agence_id @accessors;
	CPDate start_date @accessors;
	
	CPDate created_at;
	CPDate updated_at;
}

-(JSObject)attributes
{
	return {
		"code_session": {
			"agence_id":agence_id,
			"start_date":[start_date toDateString],
			"created_at":[created_at toDateString],
			"updated_at":[updated_at toDateString]
		}
	}
}

@end