//
//  PlaceOrder.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import SwiftUI

struct PlaceOrder: View {
	@StateObject	var placeOrderViewModel	=	PlaceOrderViewModel()
	
    var body: some View {
		VStack {
			TextField("Name",	text:	$placeOrderViewModel.name)
				.padding()
			TextField("Phone number",	text:	$placeOrderViewModel.phoneNumber)
				.keyboardType(.numberPad)
				.padding()
			Text("Items")
				.padding()
			VStack {
				ForEach(placeOrderViewModel.items)	{	item in
					HStack {
						Text("\(item.count)")
						Text(item.name)
					}
				}
				
				HStack {
					TextField("Item name",	text:	$placeOrderViewModel.newItem.name)
						.padding()
					Stepper(value: $placeOrderViewModel.newItem.count)	{
						Text("\(placeOrderViewModel.newItem.count)")
							.font(.title)
							.bold()
					}
						.frame(width:	130)
				}
				Button("New item")	{
					placeOrderViewModel.addNewItem()
				}.disabled(placeOrderViewModel.newItemEmpty)
			}
			DatePicker("Time to deliver", selection: $placeOrderViewModel.timeToDeliver,	in:	Date()...)
				
			Button("Place order")	{
				placeOrderViewModel.placeOrder()
			}.disabled(!placeOrderViewModel.dataValid)
		}
    }
}

struct PlaceOrder_Previews: PreviewProvider {
    static var previews: some View {
        PlaceOrder()
    }
}
