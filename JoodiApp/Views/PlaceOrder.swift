//
//  PlaceOrder.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import SwiftUI
import MapKit

struct PlaceOrder: View {
	@ObservedObject	var placeOrderViewModel:	PlaceOrderViewModel
	@Environment(\.presentationMode)	private var presentationMode
	
	init(viewModel:	PlaceOrderViewModel)	{
		placeOrderViewModel	=	viewModel
	}
	
	var body: some View	{
		
		VStack(alignment:	.leading)	{
			Section(header:	Text("Order details:").bold())	{
				Text("Name: \(placeOrderViewModel.name)")
			}
			Divider()
			
			Section(header:	Text("Items in this order: \(placeOrderViewModel.items.count)").bold()) {
				ForEach(placeOrderViewModel.items)	{	item in
					HStack {
						Text("\(item.count)x")
						Text(item.name)
					}.navigationTitle("Your order")
				}
				
			}
			Divider()
			
			Section(header:	Text("Delivery details:").bold()) {
				Text("To be delivered on \(placeOrderViewModel.dateString)")
				Text("Your shopper: \(placeOrderViewModel.shopper?.name	??	"None selected")")
				Text("Location:")
				if placeOrderViewModel.location	!=	nil	{
				ZStack	{
					Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(location: placeOrderViewModel.location!), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))))
						.cornerRadius(10)
						.disabled(true)
					Circle()
						.foregroundColor(.blue)
						.opacity(0.3)
						.frame(width:	20,	height:	20)
				}
				}	else	{
					Text(placeOrderViewModel.locationDescription)
				}
			}
			Divider()
			
			Spacer()
			HStack	{
				Spacer()
				Button("Place order",	action:	placeOrder)
					.buttonStyle(JoodiButtonStyle(disabled: !placeOrderViewModel.inputsValid))
				Spacer()
			}
		}.padding()
		
	}
	
	private func placeOrder()	{
		placeOrderViewModel.placeOrder()
		if placeOrderViewModel.submitStatus	==	.success	{
			presentationMode.wrappedValue.dismiss()
		}
	}
}


struct PlaceOrder_Previews: PreviewProvider {
    static var previews: some View {
		PlaceOrder(viewModel:	PlaceOrderViewModel())
    }
}
