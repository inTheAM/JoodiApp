//
//  SplashScreen.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/11/21.
//

import SwiftUI

struct SplashScreen: View {
	@State private var showNextView	=	false
    var body: some View {
		NavigationView	{
			ZStack {
				Color.orange
					.edgesIgnoringSafeArea(.all)
					.navigationBarHidden(true)
				NavigationLink(destination:	OrdersList(),	isActive:	$showNextView)	{
					ZStack {
						Text("Joodi")
							.font(.largeTitle)
							.bold()
							.foregroundColor(.white)
							.onAppear	{
								DispatchQueue.main.asyncAfter(deadline: .now()	+	0.8)	{
									showNextView	=	true
								}
							}
					}
				}
					
			}
		}
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
