//
//  PlaceOrder.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import SwiftUI

struct PlaceOrder: View {
	@EnvironmentObject	var user:	User
	@StateObject	var placeOrderViewModel	=	PlaceOrderViewModel()
	
    var body: some View {
		VStack {
			
			ForEach(placeOrderViewModel.items)	{	item in
				HStack {
					Text("\(item.count)")
					Text(item.name)
				}
			}.padding()
			
			DatePicker("Time to deliver", selection: $placeOrderViewModel.timeToDeliver,	in:	Date()...)
				.padding()
			Text("Items")
				.padding()
			HStack {
				TextField("Item name",	text:	$placeOrderViewModel.newItem.name)
					.padding()
				Stepper(value: $placeOrderViewModel.newItem.count)	{
					Text("\(placeOrderViewModel.newItem.count)")
						.font(.title)
						.bold()
				}
				.frame(width:	150)
			}
			Button("Add item")	{
				placeOrderViewModel.addNewItem()
			}.disabled(placeOrderViewModel.newItemEmpty)
			
			
			
			
			
			Button("Place order")	{
				placeOrderViewModel.placeOrder(for:	user)
			}.disabled(!placeOrderViewModel.inputsValid)
			.padding()
		}
    }
}

struct PlaceOrder_Previews: PreviewProvider {
    static var previews: some View {
        PlaceOrder()
    }
}
