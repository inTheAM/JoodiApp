//
//  WelcomeView.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/11/21.
//

import SwiftUI

struct WelcomeView: View {
	@StateObject var welcomeVM	=	WelcomeViewModel()
	@State private var showNext	=	false
	@State private var skip	=	false
	
    var body: some View {
		
		VStack {
			TextField("Name",	text:	$welcomeVM.name)
				.padding()
			
			TextField("Phone number",	text:	$welcomeVM.phoneNumber)
				.keyboardType(.numberPad)
				.padding()
			
			Button("Proceed")	{
				showNext	=	true
			}.padding()
			.disabled(welcomeVM.disableProceed)
			
			Button("Skip")	{
				skip	=	true
			}.padding()
			
			NavigationLink("",	destination:	OrdersList().environmentObject(welcomeVM.newUser()),	isActive:	$showNext)
			NavigationLink("",	destination:	OrdersList().environmentObject(welcomeVM.skip()),	isActive:	$skip)
			
		}.navigationBarBackButtonHidden(true)
    }
	
	
	
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
