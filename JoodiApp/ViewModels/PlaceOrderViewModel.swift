//
//  User.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import Foundation

class PlaceOrderViewModel:	ObservableObject	{
//	MARK:-	INPUT BINDINGS
	@Published	var name	=	""
	@Published	var phoneNumber	=	""
	@Published	var	timeToDeliver	=	Date()
	@Published	var shopper:	Shopper?	=	nil
	@Published	var location	=	Location.blank
	@Published	var newItem	=	Item(name: "",	count: 1)
	@Published	var items	=	[Item]()
	
//	MARK:-	VALIDATION
	var dataValid:	Bool	{
		!name.isEmpty	&&	!phoneNumber.isEmpty	&&	!items.isEmpty	&&	newItem.name	==	""
	}
	
	var newItemEmpty:	Bool	{
		newItem.name	==	""
	}
	
//	MARK:-	PLACE ORDER
	func placeOrder()	{
		guard	let url	=	URL(string: ApiURLs.ordersURL)	else	{return}
		var orderId	=	0
		URLSession.shared.dataTask(with: URLRequest(url: url))	{	data,	response,	error	in
			guard let data	=	data	else	{return}
			guard let decodedOrders	=	try?	JSONDecoder().decode([Order].self, from: data)	else	{return}
			orderId = decodedOrders.count + 1
		}.resume()
		
		let	order	=	Order(id: orderId, name: name, phoneNumber: phoneNumber, timeToDeliver: "\(timeToDeliver)", shopper: shopper?.name ?? "nil", location: location, items: items)
		
		
		guard let encoded	=	try?	JSONEncoder().encode(order)	else	{
			print("Failed to encode order")
			return
		}
		
		var request	=	URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod	=	"POST"
		request.httpBody	=	encoded
	}
	
	func addNewItem()	{
		guard 	items.first(where: {$0.name	==	newItem.name})	==	nil	else	{return}
		items.append(newItem)
		newItem	=	Item(name:	"",	count: 1)
	}
	
	func validate()	throws	{
		guard !name.isEmpty	else	{throw DataValidity.emptyName}
		guard !phoneNumber.isEmpty	else	{throw	DataValidity.emptyPhoneNumber}
		guard !items.isEmpty	else	{throw	DataValidity.emptyItems}
		
	}
	
	enum DataValidity:	Error	{
		case emptyName,	emptyPhoneNumber,	emptyItems,	emptyItemName,	valid
	}
	
}
