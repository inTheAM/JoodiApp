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
	
	init(name:	String,	phoneNumber:	String)	{
		self.name	=	name
		self.phoneNumber	=	phoneNumber
	}
	
	
	static let example	=	User(name: "Example", phoneNumber: "0000000")
}
