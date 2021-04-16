//
//  UserDetailsInput.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/16/21.
//

import SwiftUI

struct UserDetailsInput: View {
	@ObservedObject	var placeOrderViewModel:	PlaceOrderViewModel
	
	init(viewModel:	PlaceOrderViewModel)	{
		placeOrderViewModel	=	viewModel
	}
    var body: some View {
		VStack	{
			Text("Your details")
				.bold()
			Divider()
			VStack	{
				TextField("Name",	text:	$placeOrderViewModel.name)
					.padding()
					.background(RoundedRectangle(cornerRadius: 10).opacity(0.1))
				TextField("Phone number",	text:	$placeOrderViewModel.phoneNumber)
					.keyboardType(.numberPad)
					.padding()
					.background(RoundedRectangle(cornerRadius: 10).opacity(0.1))
			}.padding()
			.cardify()
			Spacer()
		}
		.padding()
    }
}

struct UserDetailsInput_Previews: PreviewProvider {
    static var previews: some View {
		UserDetailsInput(viewModel: PlaceOrderViewModel())
    }
}
