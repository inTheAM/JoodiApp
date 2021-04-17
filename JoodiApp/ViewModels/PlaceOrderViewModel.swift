//
//  User.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import Foundation
import Combine
import MapKit

class PlaceOrderViewModel:	ObservableObject	{
//	MARK:-	INPUT BINDINGS
	@Published	var name	=	""
	@Published	var phoneNumber	=	""
	@Published	var	timeToDeliver	=	Date()
	@Published	var shopper:	Shopper?	=	nil
	@Published	var location:	Location?	=		nil
	@Published	var locationDescription	=	""
	@Published	var newItem	=	Item(name: "",	count: 1)
	@Published	var items	=	[Item]()
	
	var dateString:	String	{
		let formatter	=	DateFormatter()
		formatter.amSymbol	=	"AM"
		formatter.pmSymbol	=	"PM"
		formatter.dateFormat	=	"yyyy-MM-dd HH:mm a"
		return formatter.string(from: timeToDeliver)
	}
	
//	MARK:-	VALIDATION
	var inputsValid:	Bool	{
		!name.isEmpty	&&	!phoneNumber.isEmpty	&&	!items.isEmpty	&&	newItem.name.isEmpty	&&	locationValid
	}
	
	var newItemEmpty:	Bool	{
		newItem.name	==	""
	}
	
	var locationValid:	Bool	{
		location	!=	nil	||	!locationDescription.isEmpty
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
	
	private var didChange	=	PassthroughSubject<Void,	SubmitStatus>()
	
//	MARK:-	PLACE ORDER
	func placeOrder(completion:	@escaping	()	->	()	=	{})	{
		guard	let url	=	URL(string: ApiURLs.ordersURL)	else	{
			submitStatus	=	.invalidURL
			return
		}
		guard inputsValid	else	{
			submitStatus	=	.invalidInputs
			return
		}
		
//		MARK:-	PLACING ORDER WITH VALID ID
		var orderId	=	0	{
			didSet	{
				submitStatus	=	.sending
				
				let	order	=	Order(id: orderId, name: name, phoneNumber: phoneNumber, timeToDeliver: dateString, shopper: shopper?.name, location: location, locationDescription:	locationDescription.isEmpty	?	nil	:	locationDescription,items: items)
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
					DispatchQueue.main.async {
						self.submitStatus	=	.success
						completion()
						self.reset()
					}
					
				}.resume()
				
			}
		}
//		MARK:-	GETTING CURRENT NUMBER OF ORDERS TO SET NEW ORDER ID
		URLSession.shared.dataTask(with: URLRequest(url: url))	{	data,	response,	error	in
			guard let data	=	data	else	{return}
			guard let decodedOrders	=	try?	JSONDecoder().decode([Order].self, from: data)	else	{return}
			orderId	= decodedOrders.count + 1
		}.resume()
		
	}
	
//	MARK:-	ADDING NEW ITEM TO ORDER
	func addNewItem()	{
		guard 	items.first(where: {$0.name	==	newItem.name})	==	nil	else	{return}
		items.append(newItem)
		newItem	=	Item(name:	"",	count: 1)
	}
	
//	MARK:-	UPDATING LOCATION BASED ON MAP INPUT
	func updateLocation(to newLocation:	CLLocationCoordinate2D)	{
		location	=	Location(latitude: newLocation.latitude, longitude: newLocation.longitude)
	}
	func resetLocation()	{
		location	=	nil
	}
	
	func reset()	{
		name	=	""
		phoneNumber	=	""
		timeToDeliver	=	Date()
		shopper	=	nil
		location	=		nil
		locationDescription	=	""
		newItem	=	Item(name: "",	count: 1)
		items	=	[Item]()
		submitStatus	=	.standby
	}
}
