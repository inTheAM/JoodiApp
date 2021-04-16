//
//  OrderSumary.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/11/21.
//

import SwiftUI

struct OrderSummary: View {
	@ObservedObject	var orderDetailsVM:	OrderDetailsViewModel
	
	init(order:	Order)	{
		orderDetailsVM	=	OrderDetailsViewModel(order:	order)
	}
	
    var body: some View {
		VStack(alignment:	.leading) {
			HStack {
				Text("Order number \(orderDetailsVM.id): \(orderDetailsVM.items.count) items")
					.font(.subheadline)
					.bold()
				Spacer()
				Text(orderDetailsVM.timeToDeliver)
					.font(.headline)
			}.overlay(Divider(), alignment:	.bottom)
			HStack(alignment:	.bottom) {
				VStack(alignment:	.leading) {
					ForEach(orderDetailsVM.items)	{ item in
						Text("\(item.count)x \(item.name)")
							.font(.caption)
							.bold()
					}
				}
				Spacer()
				Text("Delivered by: \(orderDetailsVM.shopper)")
					.font(.caption)
				
			}
			
		}.padding()
		.foregroundColor(.primary)
		.cardify()
    }
}

struct OrderSummary_Previews: PreviewProvider {
    static var previews: some View {
		OrderSummary(order: .blank)
    }
}
