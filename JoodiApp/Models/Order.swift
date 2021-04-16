//
//  Order.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import Foundation

struct Order:	Identifiable,	Codable,	Hashable	{
	static func == (lhs: Order, rhs: Order) -> Bool {
		lhs.id	==	rhs.id
	}
	
	var id:	Int
	var name:	String
	var phoneNumber:	String
	var timeToDeliver:	String
	var shopper:	String?
	var location:	Location?
	var items:	[Item]
	
	var review:	Review?
	
	static let blank	=	Order(id: 0, name: "", phoneNumber: "", timeToDeliver: "", shopper: "", location: .example, items: [Item]())
}
