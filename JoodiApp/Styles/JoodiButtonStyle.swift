//
//  JoodiButtonStyle.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/16/21.
//

import SwiftUI

struct JoodiButtonStyle:	ButtonStyle	{
	var disabled:	Bool	=	false
	func makeBody(configuration:	Self.Configuration)	->	some View	{
		return configuration.label
			.font(.headline)
			.padding()
			.background(Color.orange)
			.cornerRadius(20)
			.opacity(configuration.isPressed	?	0.2	:	1)
			.saturation(disabled	?	0	:	1)
			.allowsHitTesting(!disabled)
	}
}
