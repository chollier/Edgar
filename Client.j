@import <CappuccinoResource/CRBase.j>

@implementation Client : CappuccinoResource
{
	CPString nom @accessors;
	CPString prenom @accessors;
	CPDate anniversaire @accessors;
	CPString telephone @accessors;
	CPString email @accessors;
	CPText adresse @accessors;
	CPNumber codepostal @accessors;
	CPString ville @accessors;
	CPText notes_memo @accessors;
	CPString alias @accessors;
	CPString password @accessors;
	
	CPDate created_at;
	CPDate updated_at;
}

-(JSObject)attributes
{
	return {
		"client": {
			"nom":nom,
			"prenom":prenom,
			"anniversaire":[anniversaire toDateString],
			"telephone":telephone,
			"email":email,
			"adresse":adresse,
			"codepostal":codepostal,
			"ville":ville,
			"notes_memo":notes_memo,
			"alias":alias,
			"password":password,
			"created_at":[created_at toDateString],
			"updated_at":[updated_at toDateString]
		}
	}
}

@end