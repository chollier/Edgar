@import <CappuccinoResource/CRBase.j>

@implementation Circuit : CappuccinoResource
{
	CPString nom @accessors;
	CPText adresse @accessors;
	CPNumber codepostal @accessors;
	CPString ville @accessors;
	CPText notes @accessors;
	
	CPDate created_at;
	CPDate updated_at;
}

-(JSObject)attributes
{
	return {
		"circuit": {
			"nom":nom,
			"adresse":adresse,
			"codepostal":codepostal,
			"ville":ville,
			"notes":notes,
			"created_at":[created_at toDateString],
			"updated_at":[updated_at toDateString]
		}
	}
}

@end