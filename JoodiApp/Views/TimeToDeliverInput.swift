//
//  TimeToDeliverInput.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/16/21.
//

import SwiftUI

struct TimeToDeliverInput: View {
	@ObservedObject	var placeOrderViewModel:	PlaceOrderViewModel
	
	init(viewModel:	PlaceOrderViewModel)	{
		placeOrderViewModel	=	viewModel
	}
	
    var body: some View {
		VStack	{
			Text("What time would you like this order delivered?")
			.bold()
			Divider()
			
			DatePicker("Time to deliver", selection: $placeOrderViewModel.timeToDeliver,	in:	Date()...)
				.datePickerStyle(GraphicalDatePickerStyle())
				.padding()
				.cardify()
			Spacer()
			
		}.padding()
    }
}

struct TimeToDeliverInput_Previews: PreviewProvider {
    static var previews: some View {
        TimeToDeliverInput(viewModel: PlaceOrderViewModel())
    }
}
