//
//  SubmitReview.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/13/21.
//

import SwiftUI

struct SubmitReview: View {
	@ObservedObject	var submitReviewVM:	SubmitReviewViewModel
	
	init(order:	Order)	{
		submitReviewVM	=	SubmitReviewViewModel(for: order)
	}
    var body: some View {
		VStack	{
			Text("Rate your order")
			HStack {
				ForEach(1..<6)	{	rating	in
					Button(action:	{submitReviewVM.rating	=	rating})	{
						Image(systemName: "star.fill")
							.foregroundColor(rating	<=	submitReviewVM.rating	?	.yellow	:	.gray)
						
					}
				}
			}
			
			TextField("Message",	text:	$submitReviewVM.message)
				.padding()
			
			Button("Submit")	{
				submitReviewVM.submitReview()
			}.disabled(!submitReviewVM.reviewValid)
		}
    }
}

struct SubmitReview_Previews: PreviewProvider {
    static var previews: some View {
		SubmitReview(order: .blank)
    }
}
