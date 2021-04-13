//
//  Review.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/13/21.
//

import Foundation

struct Review:	Codable {
	var rating:	Int
	var message:	String?
	
	init(rating:	Int,	message:	String)	{
		self.rating	=	rating
		if !message.isEmpty	{
			self.message	=	message
		}
		print(self)
	}
}

