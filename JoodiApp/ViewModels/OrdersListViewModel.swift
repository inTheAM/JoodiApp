//
//  OrdersViewModel.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import Foundation
import Combine

class OrdersListViewModel: ObservableObject {
	private var didChange	=	PassthroughSubject<[Order],	FetchingStatus>()
	
	@Published	private(set)	var orders:	[Order]	{
		didSet	{
			didChange.send(orders)
		}
	}
	
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
	
	init()	{
		orders	=	[Order]()
		fetchingStatus	=	.standby
	}
	
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
			
			self.fetchingStatus	=	.success
			print("Orders loaded")
			DispatchQueue.main.async {
				self.orders	=	decodedOrders
			}			
		}.resume()
		self.fetchingStatus	=	.standby
	}
}
