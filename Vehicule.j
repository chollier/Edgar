@import <CappuccinoResource/CRBase.j>

@implementation Vehicule : CappuccinoResource
{
	CPString type @accessors;
	CPString modele @accessors;
	CPString marque @accessors;
	CPDate date_achat @accessors;
	BOOL disponible @accessors;
	
	CPNumber circuit_id @accessors;
	
	CPDate created_at;
	CPDate updated_at;
}

-(JSObject)attributes
{
	return {
		"vehicule": {
			"type":type,
			"modele":modele,
			"marque":marque,
			"date_achat":[date_achat toDateString],
			"disponible":disponible,
			"circuit_id":circuit_id,
			"created_at":[created_at toDateString],
			"updated_at":[updated_at toDateString]
		}
	}
}

@end