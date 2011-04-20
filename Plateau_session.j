@import <CappuccinoResource/CRBase.j>

@implementation Plateau_session : CappuccinoResource
{
	CPNumber circuit_id @accessors;
	CPNumber client_session_id @accessors;
	CPNumber staff_id @accessors;
	CPNumber vehicule_id @accessors;
	
	CPDate created_at;
	CPDate updated_at;
}

-(JSObject)attributes
{
	return {
		"Plateau_session": {
			"circuit_id":circuit_id,
			"client_id":client_id,
			"staff_id":staff_id,
			"vehicule_id":vehicule_id,
			"created_at":[created_at toDateString],
			"updated_at":[updated_at toDateString]
		}
	}
}

@end