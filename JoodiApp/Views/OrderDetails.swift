//
//  OrderDetails.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import SwiftUI

struct OrderDetails: View {
	@ObservedObject	var orderDetailsVM	=	OrderDetailsViewModel()
	var orderID:	Int
	
	init(order:	Int)	{
		orderID	=	order
	}
	
    var body: some View {
		VStack	{
			Text("Order number \(orderDetailsVM.id)")
			Text(orderDetailsVM.name)
			
			
			NavigationLink(destination: SubmitReview(order: orderDetailsVM.order))	{
				Text("Review this order")
			}
		}.onAppear	{
			print("Showing details for order \(orderID)")
			orderDetailsVM.fetch(orderID)
		}
    }
}

struct OrderDetails_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetails(order: 1)
    }
}
