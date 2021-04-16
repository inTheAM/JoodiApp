//
//  OrderDetails.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import SwiftUI

struct OrderDetails: View {
	@ObservedObject	var orderDetailsVM	=	OrderDetailsViewModel()
	
	init(order:	Order)	{
		orderDetailsVM	=	OrderDetailsViewModel(order:	order)
	}
	
    var body: some View {
		VStack(alignment:	.leading)	{
			Section(header:	Text("Order details:").bold())	{
				Text("Name: \(orderDetailsVM.name)")
			}
			Divider()
			
			Section(header:	Text("Items in this order: \(orderDetailsVM.items.count)").bold()) {
				ForEach(orderDetailsVM.items)	{	item in
					HStack {
						Text("\(item.count)x")
						Text(item.name)
					}.navigationTitle("Order number \(orderDetailsVM.id)")
				}
				
			}
			Divider()
			
			Section(header:	Text("Delivery details:").bold()) {
				Text("Delivered on \(orderDetailsVM.timeToDeliver), by \(orderDetailsVM.shopper)")
			}
			Divider()
			Spacer()
			orderRating
		}.padding()
    }
	
	@ViewBuilder	var orderRating:	some View	{
		if orderDetailsVM.review	==	nil	{
			HStack {
				Spacer()
				NavigationLink(destination:	SubmitReview(order:	orderDetailsVM.order))	{
					Text("Review this order")
						.bold()
				}.buttonStyle(JoodiButtonStyle())
				Spacer()
			}
		}	else	{
			HStack {
				ForEach(1..<6)	{	rating	in
					Image(systemName: "star.fill")
						.resizable()
						.frame(width:	40,	height:	40)
						.foregroundColor(rating	<=	orderDetailsVM.review!.rating	?	.yellow	:	.gray)
				}
			}
		}
	}
}

struct OrderDetails_Previews: PreviewProvider {
    static var previews: some View {
		OrderDetails(order: .blank)
    }
}
