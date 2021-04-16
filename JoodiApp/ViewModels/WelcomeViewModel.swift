//
//  WelcomeViewModel.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/11/21.
//

import Foundation

class WelcomeViewModel:	ObservableObject	{
	@Published	var name	=	""
	@Published	var phoneNumber	=	""
	
	var disableProceed:	Bool	{
		name.isEmpty	||	phoneNumber.isEmpty
	}
	
	func newUser()	->	User	{
		User(name: name, phoneNumber: phoneNumber)
	}
	
	func skip()	->	User	{
		User.example
	}
	
}
