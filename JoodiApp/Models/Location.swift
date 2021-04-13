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
	
	struct Coordinate:	Codable,	Hashable {
		var latitude:	Double
		var longitude:	Double
	}
	
	static let	blank	=	Location(type: 9999, value: Coordinate(latitude: 0, longitude: 30))
}
