@import <CappuccinoResource/CRBase.j>

@implementation Agence : CappuccinoResource
{
	CPString nom @accessors;
	CPString telephone @accessors;
	CPString email @accessors;
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
		"agence": {
			"nom":nom,
			"telephone":telephone,
			"email":email,
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