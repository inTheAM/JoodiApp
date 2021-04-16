//
//  CustomizeOrder.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/16/21.
//

import SwiftUI

struct CustomizeOrder: View {
	@ObservedObject	var placeOrderViewModel:	PlaceOrderViewModel
	@State private var tabSelection	=	0
	@Environment(\.presentationMode)	private var presentationMode
	
	init()	{
		placeOrderViewModel	=	PlaceOrderViewModel()
	}
	
	var body: some View {
		VStack	{
			TabView(selection:	$tabSelection) {
				UserDetailsInput(viewModel:	placeOrderViewModel)
					.tag(0)
				ItemsInput(viewModel:	placeOrderViewModel)
					.tag(1)
				LocationInput(viewModel:	placeOrderViewModel)
					.tag(2)
				
				TimeToDeliverInput(viewModel:	placeOrderViewModel)
					.tag(3)
				ShoppersList(viewModel: placeOrderViewModel)
					.tag(4)
				
				PlaceOrder(viewModel:	placeOrderViewModel)
					.tag(5)
				
				
				
			}.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
			.navigationTitle("New order")
			.onDisappear	{
				presentationMode.wrappedValue.dismiss()
			}
			
			Divider()
			
			HStack	{
				if tabSelection	!=	0	{
					Button("Previous")	{
						if tabSelection	>	0	{
							tabSelection	-=	1
						}
						UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
					}.font(.headline)
					.foregroundColor(.white)
					.padding(10)
					.background(Color.blue.cornerRadius(20))
				}
				Spacer()
				
				if	tabSelection	!=	5	{
					Button("Next")	{
						if tabSelection	<	5	{
							tabSelection	+=	1
						}
						UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
					}.font(.headline)
					.foregroundColor(.white)
					.padding(10)
					.background(Color.blue.cornerRadius(20))
				}
			}.padding()
			
		}
	}
}

struct CustomizeOrder_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeOrder()
    }
}
