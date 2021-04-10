//
//  Location.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import Foundation

struct Location:	Codable	{
	var type:	Int
	var value:	Coordinate
	
	struct Coordinate:	Codable {
		var latitude:	Double
		var longitude:	Double
	}
}
