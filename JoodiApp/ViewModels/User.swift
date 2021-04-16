//
//  User.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/11/21.
//

import Foundation

class User:	ObservableObject	{
	var name:	String
	var phoneNumber:	String
	var location:	Location?
	
	init(name:	String,	phoneNumber:	String,	location:	Location?	=	.blank)	{
		self.name	=	name
		self.phoneNumber	=	phoneNumber
	}
	
	
	static let example	=	User(name: "Ali", phoneNumber: "0000000",	location:	.init(latitude	:44.3245235,	longitude	:39.3463464))
}
