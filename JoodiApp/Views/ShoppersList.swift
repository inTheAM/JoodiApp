//
//  ContentView.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import SwiftUI

struct ShoppersList: View {
	@StateObject	var shoppersVM	=	ShoppersViewModel()
	
    var body: some View {
		List(shoppersVM.shoppers)	{	shopper in
			Text(shopper.name)
		}
		.onAppear	{
			shoppersVM.fetch()
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppersList()
    }
}
