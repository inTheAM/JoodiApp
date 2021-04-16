//
//  OrderDetailsViewModel.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import Foundation
import Combine

class OrderDetailsViewModel: ObservableObject {
//	MARK:-	MODEL ACCESS
	private var didChange	=	PassthroughSubject<Order,	FetchingStatus>()
	
	@Published	private(set)	var order:	Order	{
		didSet	{
			didChange.send(order)
		}
	}
	
//	MARK:-	FETCHING STATUS
	private(set)	var fetchingStatus:	FetchingStatus	{
		didSet	{
			switch fetchingStatus {
				case	.success	:
					didChange.send(completion: .finished)
				default	:	didChange.send(completion: .failure(fetchingStatus))
					
			}
		}
	}
	
//	MARK:-	INITIALIZERS
	init()	{
		order	=	.blank
		fetchingStatus	=	.standby
	}
	
	init(order:	Order)	{
		self.order	=	order
		fetchingStatus	=	.success
	}
	
//	MARK:-	ORDER PROPERTIES
	var id:	Int	{
		order.id
	}
	var name:	String	{
		order.name
	}
	var phoneNumber:	String	{
		order.phoneNumber
	}
	var timeToDeliver:	String	{
		let formatter	=	DateFormatter()
		formatter.dateFormat	=	"yyyy-MM-dd HH:mm a"
		guard let date	=	formatter.date(from: order.timeToDeliver) else { return order.timeToDeliver }
		formatter.dateStyle	=	.short
		
		return formatter.string(from: date)
	}
	var review:	Review?	{
		order.review
	}
//	MARK:-	IF SHOPPER IS NOT SELECTED, SERVER CAN ALLOCATE RANDOM SHOPPER. THIS INSTANCE MAY ALWAYS HAVE A VALUE FROM THE SERVER.
	var shopper:	String	{
		order.shopper	??	"You did not select a shopper"
	}
	var	location:	Location?	{
		order.location
	}
	var items:	[Item]	{
		order.items
	}
	
	var isComplete:	Bool	{
		let formatter	=	DateFormatter()
		formatter.dateFormat	=	"yyyy-MM-dd HH:mm a"
		guard let date	=	formatter.date(from: order.timeToDeliver) else { return false }
		
		return Date()	>	date
	}
	
//	MARK:-	FETCH ORDER DETAILS; CAN BE USED IN CASE ORDERS LIST IS MISSING DATA REQUIRED FOR DETAIL VIEWS
	func	fetch(_	id:	Int,	completion:	@escaping	()->()	=	{})	{
		guard	let url	=	URL(string: ApiURLs.orderDetailsURL(id: id))	else	{
			self.fetchingStatus	=	.invalidURL
			return
		}
		
		self.fetchingStatus	=	.loading
		print("Fetching order number: \(id) from \(ApiURLs.orderDetailsURL(id: id))")
		URLSession.shared.dataTask(with: URLRequest(url: url))	{	data,	response,	error	in
			guard let data	=	data	else	{
				self.fetchingStatus	=	.noDataFromServer
				return
			}
			guard let decodedOrder	=	try?	JSONDecoder().decode(Order.self, from: data)	else	{
				self.fetchingStatus	=	.failedToDecodeData
				return
			}
			
			self.fetchingStatus	=	.success
			print("Order details loaded")
			DispatchQueue.main.async {
				self.order	=	decodedOrder
			}
			completion()
		}.resume()
	}
	
	func addReview()	{
		
	}
}
