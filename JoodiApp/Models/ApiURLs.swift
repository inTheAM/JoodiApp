//
//  ApiURLs.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import Foundation

struct ApiURLs {
	static let shoppersURL	=	"https://60719d9350aaea0017284d61.mockapi.io/api/Shoppers/"
	static let ordersURL	=	"https://60719d9350aaea0017284d61.mockapi.io/api/Orders/"
	static let reviewsURL	=	"https://60719d9350aaea0017284d61.mockapi.io/api/Reviews/"
	
	static func orderDetailsURL(id:	Int)	->	String	{
		"https://60719d9350aaea0017284d61.mockapi.io/api/Orders/\(id)"
	}
}
