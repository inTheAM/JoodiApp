//
//  ShoppersViewModel.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import Foundation
import Combine


class ShoppersViewModel: ObservableObject {
//	MARK:-	MODEL
	private var didChange	=		PassthroughSubject<[Shopper],	FetchingStatus>()
	
	@Published	private(set)	var	shoppers:	[Shopper]	{
		didSet	{
			didChange.send(shoppers)
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
		shoppers	=	[Shopper]()
		fetchingStatus	=	.standby
		fetch()
	}
	
//	MARK:-	FETCH SHOPPERS
	func	fetch()	{
		guard	let url	=	URL(string: ApiURLs.shoppersURL)	else	{
			self.fetchingStatus	=	.invalidURL
			return
		}
		self.fetchingStatus	=	.loading
		URLSession.shared.dataTask(with: URLRequest(url: url))	{	data,	response,	error	in
			guard let data	=	data	else	{
				self.fetchingStatus	=	.noDataFromServer
				return
			}
			
			guard let decodedShoppers	=	try?	JSONDecoder().decode([Shopper].self, from: data)	else	{
				self.fetchingStatus	=	.failedToDecodeData
				return
			}
			
			self.fetchingStatus	=	.success
			DispatchQueue.main.async {
				self.shoppers	=	decodedShoppers
			}
		}.resume()
		self.fetchingStatus	=	.standby
	}
}
