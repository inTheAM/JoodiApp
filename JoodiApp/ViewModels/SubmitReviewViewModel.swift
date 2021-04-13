//
//  SubmitReviewViewModel.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/13/21.
//

import Foundation
import Combine

class SubmitReviewViewModel:	ObservableObject	{
	private var didChange	=	PassthroughSubject<Void,	SubmitStatus>()
	
	private(set)	var submitStatus:	SubmitStatus	=	.standby	{
		didSet	{
			switch submitStatus {
				case	.success	:
					didChange.send(completion: .finished)
				default	:	didChange.send(completion: .failure(submitStatus))
					
			}
		}
	}
	
	var order:	Order
	@Published	var rating:	Int
	@Published	var message:	String
	
	var reviewValid:	Bool	{
		rating	>	0
	}
	var isComplete:	Bool	{
		let formatter	=	DateFormatter()
		formatter.dateFormat	=	"yyyy-MM-dd HH:mm a"
		guard let date	=	formatter.date(from: order.timeToDeliver) else { return false }
		
		return Date()	>	date
	}
	
	
	
	
	init(for order:	Order)	{
		rating	=	0
		message	=	""
		self.order	=	order
	}
	
	
	func submitReview()	{
		guard let url	=	URL(string: ApiURLs.reviewsURL)	else	{
			submitStatus	=	.invalidURL
			return
		}
		
		let review	=	Review(rating: rating, message: message)
		
		guard let encoded	=	try?	JSONEncoder().encode(review)	else	{
			submitStatus	=	.failedToEncodeData
			return
		}
		var request	=	URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod	=	"POST"
		request.httpBody	=	encoded
		
		URLSession.shared.dataTask(with: request)	{	data,	response,	error	in
			guard let response	=	response	as?	HTTPURLResponse	else	{
				self.submitStatus	=	.noResponseFromServer
				return
			}
			self.submitStatus	=	.success
		}.resume()
	}
}
