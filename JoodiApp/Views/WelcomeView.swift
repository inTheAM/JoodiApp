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
	
    var body: some View {
		
		VStack {
			TextField("Name",	text:	$welcomeVM.name)
				.padding()
			
			TextField("Phone number",	text:	$welcomeVM.phoneNumber)
				.keyboardType(.numberPad)
				.padding()
			
			Button("Proceed")	{
				showNext	=	true
			}
			.disabled(welcomeVM.disableProceed)
			
			NavigationLink("",	destination:	OrdersList().environmentObject(welcomeVM.newUser()),	isActive:	$showNext)
			
		}.navigationBarBackButtonHidden(true)
    }
	
	
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
