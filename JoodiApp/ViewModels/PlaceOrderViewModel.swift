//
//  User.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import Foundation
import Combine

class PlaceOrderViewModel:	ObservableObject	{
//	MARK:-	INPUT BINDINGS
	@Published	var	timeToDeliver	=	Date()
	@Published	var shopper:	Shopper?	=	nil
	@Published	var location	=	Location.blank
	@Published	var newItem	=	Item(name: "",	count: 1)
	@Published	var items	=	[Item]()
	
	private var didChange	=	PassthroughSubject<Void,	SubmitStatus>()
	
//	MARK:-	VALIDATION
	var inputsValid:	Bool	{
		!items.isEmpty	&&	newItem.name	==	""
	}
	
	var newItemEmpty:	Bool	{
		newItem.name	==	""
	}
	
//	MARK:-	FETCHING STATUS
	private(set)	var submitStatus:	SubmitStatus	=	.standby	{
		didSet	{
			switch submitStatus {
				case	.success	:
					didChange.send(completion: .finished)
				default	:	didChange.send(completion: .failure(submitStatus))
					
			}
		}
	}
	
//	MARK:-	PLACE ORDER
	func placeOrder(for user:	User)	{
		guard	let url	=	URL(string: ApiURLs.ordersURL)	else	{
			submitStatus	=	.invalidURL
			return
		}
		
		let formatter	=	DateFormatter()
		formatter.amSymbol	=	"AM"
		formatter.pmSymbol	=	"PM"
		formatter.dateFormat	=	"yyyy-MM-dd HH:mm a"
		
//		MARK:-	PLACING ORDER WITH VALID ID
		var orderId	=	0	{
			didSet	{
				submitStatus	=	.sending
				let deliveryTime	=	formatter.string(from: timeToDeliver)
				
				let	order	=	Order(id: orderId, name: user.name, phoneNumber: user.phoneNumber, timeToDeliver: deliveryTime, shopper: shopper?.name ?? "nil", location: location, items: items)
				print(order)
				
				guard let encoded	=	try?	JSONEncoder().encode(order)	else	{
					submitStatus	=	.failedToEncodeData
					return
				}
				print("Encoded order, ready to post")
				var request	=	URLRequest(url: url)
				request.setValue("application/json", forHTTPHeaderField: "Content-Type")
				request.httpMethod	=	"POST"
				request.httpBody	=	encoded
				
				URLSession.shared.dataTask(with: request)	{	data,	response,	error	in
					guard let _	=	response	as?	HTTPURLResponse	else	{
						self.submitStatus	=	.noResponseFromServer
						return						
					}
					self.submitStatus	=	.success
				}.resume()
			}
		}
//		MARK:-	GETTING CURRENT NUMBER OF ORDERS TO SET NEW ORDER ID
		URLSession.shared.dataTask(with: URLRequest(url: url))	{	data,	response,	error	in
			guard let data	=	data	else	{return}
			guard let decodedOrders	=	try?	JSONDecoder().decode([Order].self, from: data)	else	{return}
			orderId = decodedOrders.count + 1
		}.resume()
	}
	
//	MARK:-	ADDING NEW ITEM TO ORDER
	func addNewItem()	{
		guard 	items.first(where: {$0.name	==	newItem.name})	==	nil	else	{return}
		items.append(newItem)
		newItem	=	Item(name:	"",	count: 1)
	}
}
