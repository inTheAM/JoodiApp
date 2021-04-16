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
		ZStack {
			if ordersVM.fetchingStatus	!=	.success	{
				ProgressView()
			}
			VStack(alignment:	.leading) {
				NavigationLink(destination:	CustomizeOrder())	{
					HStack {
						Image(systemName: "plus.app")
							.resizable()
							.foregroundColor(.white)
							.opacity(0.5)
							.background(Color.orange.opacity(0.6).cornerRadius(10))
							.frame(width: 50, height: 50)
						Text("New order")
							.font(.title)
							.bold()
						Spacer()
					}.padding()
				}.onAppear	{
					
				}
				
				Text("Previous orders")
					.font(.largeTitle)
					.bold()
					.navigationTitle("Orders")
					.navigationBarTitleDisplayMode(.inline)
					.navigationBarBackButtonHidden(true)
					.padding(.horizontal)
				
				ScrollView	{
					ForEach(ordersVM.orders)	{	order in
						NavigationLink(destination:	OrderDetails(order:	order))	{
							OrderSummary(order:	order)
						}
					}.padding()
				}
			}
		}
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
		OrdersList()
    }
}
