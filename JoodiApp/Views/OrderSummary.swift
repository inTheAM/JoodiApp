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
			ForEach(orderDetailsVM.items)	{ item in
				Text("\(item.count)x \(item.name)")
					.font(.caption)
					.bold()
			}
			
		}.padding()
		.foregroundColor(.primary)
		.background(RoundedRectangle(cornerRadius: 10)
						.foregroundColor(.init(red: 240/255, green: 240/255, blue: 240/255))
						.opacity(0.1)
						.shadow(color:	.black,	radius:	10,x: 0,	y: 0)
		)
    }
}

struct OrderSummary_Previews: PreviewProvider {
    static var previews: some View {
		OrderSummary(order: .blank)
    }
}
