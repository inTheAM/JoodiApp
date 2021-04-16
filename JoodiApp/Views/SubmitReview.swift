//
//  SubmitReview.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/13/21.
//

import SwiftUI

struct SubmitReview: View {
	@ObservedObject	var submitReviewVM:	SubmitReviewViewModel
	@Environment(\.presentationMode)	var presentationMode
	
	init(order:	Order)	{
		submitReviewVM	=	SubmitReviewViewModel(for: order)
	}
    var body: some View {
		VStack	{
			Text("Rate this order")
				.bold()
			HStack {
				ForEach(1..<6)	{	rating	in
					Button(action:	{submitReviewVM.rating	=	rating})	{
						Image(systemName: "star.fill")
							.resizable()
							.frame(width:	40,	height:	40)
							.foregroundColor(rating	<=	submitReviewVM.rating	?	.yellow	:	.gray)
						
					}
				}
			}
			
			TextField("An optional message",	text:	$submitReviewVM.message)
				.padding()
				.background(RoundedRectangle(cornerRadius: 10).opacity(0.1))
				
			Button("Submit",	action:	submit)
				.buttonStyle(JoodiButtonStyle(disabled: !submitReviewVM.reviewValid))
		}.padding()
		.cardify()
    }
	
	private func submit()	{
		submitReviewVM.submitReview()
		if submitReviewVM.submitStatus	==	.success	{
			presentationMode.wrappedValue.dismiss()
		}
	}
}

struct SubmitReview_Previews: PreviewProvider {
    static var previews: some View {
		SubmitReview(order: .blank)
    }
}
