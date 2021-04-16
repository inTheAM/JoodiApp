//
//  Location.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import Foundation

struct Location:	Codable,	Hashable	{
	static func == (lhs: Location, rhs: Location) -> Bool {
		lhs.value	==	rhs.value
	}
	
	var type:	Int
	var value:	Coordinate
	
	var latitude:	Double	{
		value.latitude
	}
	var longitude:	Double	{
		value.longitude
	}
	
	struct Coordinate:	Codable,	Hashable {
		var latitude:	Double
		var longitude:	Double
		
	}
	init(latitude:	Double,	longitude:	Double) {
		type	=	1
		value	=	.init(latitude: latitude, longitude: longitude)
	}
	
	static let	example	=	Location(latitude: 44.3245235, longitude: 39.3463464)
}
