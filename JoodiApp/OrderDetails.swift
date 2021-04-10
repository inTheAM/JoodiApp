//
//  OrderDetails.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import SwiftUI

struct OrderDetails: View {
	@StateObject	var orderDetailsVM	=	OrderDetailsViewModel()
	var orderID:	Int
	
	init(order:	Int)	{
		orderID	=	order
	}
	
    var body: some View {
		VStack	{
			Text(orderDetailsVM.name)
		}.onAppear	{
			orderDetailsVM.fetch(orderID)
		}
    }
}

struct OrderDetails_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetails(order: 1)
    }
}
