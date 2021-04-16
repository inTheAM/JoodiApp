//
//  ItemsInput.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/16/21.
//

import SwiftUI

struct ItemsInput:	View	{
	@ObservedObject	var placeOrderViewModel:	PlaceOrderViewModel
	
	init(viewModel:	PlaceOrderViewModel)	{
		placeOrderViewModel	=	viewModel
	}
	var body: some View	{
		VStack	{
			Text("Items in your current order: \(placeOrderViewModel.items.count)")
				.bold()
			
			Divider()
			VStack	{
				ForEach(placeOrderViewModel.items)	{	item in
					HStack {
						Text("\(item.count)x")
						Text(item.name)
					}
				}
			}.padding()
			.cardify()
			
			Spacer()
			
			VStack {
				TextField("Item name",	text:	$placeOrderViewModel.newItem.name)
					.padding()
					.background(RoundedRectangle(cornerRadius: 10).opacity(0.1))
				
				Divider()
				
				HStack {
					Stepper(value: $placeOrderViewModel.newItem.count)	{
						Text("\(placeOrderViewModel.newItem.count)")
							.font(.title)
							.bold()
					}.padding(10)
					.frame(width:	140)
					
					Spacer()
					
					Button("Add item")	{
						placeOrderViewModel.addNewItem()
						UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
					}
					.buttonStyle(JoodiButtonStyle(disabled:	placeOrderViewModel.newItemEmpty))
				}
			}.padding()
			.cardify()
			Spacer()
		}.padding()
	}
}

struct ItemsInput_Previews: PreviewProvider {
    static var previews: some View {
		ItemsInput(viewModel: PlaceOrderViewModel())
    }
}
