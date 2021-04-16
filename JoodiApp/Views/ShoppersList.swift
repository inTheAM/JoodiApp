//
//  ContentView.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import SwiftUI

struct ShoppersList: View {
	@StateObject	var shoppersVM	=	ShoppersViewModel()
	@ObservedObject	var placeOrderVM:	PlaceOrderViewModel
	
	init(viewModel:	PlaceOrderViewModel)	{
		placeOrderVM	=	viewModel
	}
	
    var body: some View {
		VStack	{
			Text("Choose a shopper you would like to handle your order.")
				.bold()
			Text("(You can leave this blank)")
				.font(.caption)
				.opacity(0.5)
			Divider()
			ForEach(shoppersVM.shoppers)	{	shopper in
				
				Button(action:	{
					placeOrderVM.shopper	=	shopper
				})	{
					HStack	{
						Label(shopper.name, systemImage: "person.circle.fill")
						Spacer()
						if placeOrderVM.shopper	==	shopper	{
							Image(systemName: "checkmark.circle.fill")
						}
					}
				}.padding(10)
			}
			Spacer()
		}.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppersList(viewModel: PlaceOrderViewModel())
    }
}
