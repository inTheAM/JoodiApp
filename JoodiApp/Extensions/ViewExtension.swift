//
//  Extensions.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/15/21.
//

import SwiftUI

extension	View	{
	func cardify()	->	some	View	{
		return self.background(RoundedRectangle(cornerRadius: 10)
								.foregroundColor(.init(red: 240/255, green: 240/255, blue: 240/255))
								.opacity(0.1)
								.shadow(color:	.black,	radius:	10,x: 0,	y: 0)
		)
	}
}




