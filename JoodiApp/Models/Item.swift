//
//  Item.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import Foundation

struct Item:	Identifiable,	Codable	{
	var name:	String
	var count:	Int
	
	var id:	String	{
		name
	}
}
