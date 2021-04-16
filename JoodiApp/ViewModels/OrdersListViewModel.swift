//
//  OrdersViewModel.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import Foundation
import Combine

class OrdersListViewModel: ObservableObject {
//	MARK:-	MODEL
	private var didChange	=	PassthroughSubject<[Order],	FetchingStatus>()
	
	@Published	private(set)	var orders:	[Order]	{
		didSet	{
			didChange.send(orders)
		}
	}
	
//	MARK:-	FETCHING STATUS
	private(set)	var fetchingStatus:	FetchingStatus	{
		didSet	{
			print(fetchingStatus.localizedDescription)
			switch fetchingStatus {
				case	.success	:
					didChange.send(completion: .finished)
				default	:	didChange.send(completion: .failure(fetchingStatus))
					
			}
		}
	}
	
//	MARK:-	INITIALIZER
	init()	{
		orders	=	[Order]()
		fetchingStatus	=	.standby
		fetch()
	}
	
//	MARK:-	FETCH ORDERS
	func	fetch()	{
		guard	let url	=	URL(string: ApiURLs.ordersURL)	else	{
			self.fetchingStatus	=	.invalidURL
			return
		}
		
		self.fetchingStatus	=	.loading
		
		URLSession.shared.dataTask(with: URLRequest(url: url))	{	data,	response,	error	in
			guard let data	=	data	else	{
				self.fetchingStatus	=	.noDataFromServer
				return
			}
			guard let decodedOrders	=	try?	JSONDecoder().decode([Order].self, from: data)	else	{
				self.fetchingStatus	=	.failedToDecodeData
				return
			}
			DispatchQueue.main.async {
				self.orders	=	decodedOrders
			}
			
			self.fetchingStatus	=	.success
		}.resume()
		
		self.fetchingStatus	=	.standby
	}
	
	deinit {
		print("Order list destroyed")
	}
}
