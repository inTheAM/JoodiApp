//
//  OrdersView.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import SwiftUI

struct OrdersList: View {
	@StateObject	var ordersVM	=	OrdersListViewModel()
	
    var body: some View {
		NavigationView {
			List(ordersVM.orders)	{	order in
				NavigationLink(destination:	OrderDetails(order: order.id)) {
					Text(order.name)
				}
			}.onAppear	{
				ordersVM.fetch()
			}
		}
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersList()
    }
}
