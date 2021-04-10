//
//  Order.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import Foundation

struct Order:	Identifiable,	Codable	{
	var id:	Int
	var name:	String
	var phoneNumber:	Int
	var timeToDeliver:	Date
	var shopper:	String
	var location:	Location
	var items:	[Item]
}
