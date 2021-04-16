//
//  LocationInput.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/16/21.
//

import SwiftUI
import MapKit

struct LocationInput: View {
	@ObservedObject	var placeOrderViewModel:	PlaceOrderViewModel
	@State private var pickerSelection	=	0
	@State private var useCoordinates	=	false
	@State private var mapRegion	=	MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Location.example.latitude, longitude: Location.example.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
	@State private var textFieldLabel	=	"Describe your location"
	
	init(viewModel:	PlaceOrderViewModel)	{
		placeOrderViewModel	=	viewModel
	}
	var body:	some	View	{
		VStack	{
			Text("Tell us where to deliver your order")
				.bold()
			Divider()
			
			VStack {
				Toggle("Use map", isOn: $useCoordinates)
				
				TextField(textFieldLabel,	text:	$placeOrderViewModel.locationDescription)
					.padding()
					.background(RoundedRectangle(cornerRadius: 10).opacity(0.1))
				
				if useCoordinates	{
					ZStack {
						Map(coordinateRegion: $mapRegion)
							.cornerRadius(10)
						Circle()
							.foregroundColor(.blue)
							.opacity(0.3)
							.frame(width:	20,	height:	20)
					}
				}
			}
			.padding()
			.cardify()
			if !useCoordinates	{
				Spacer()
			}
		}.padding()
		.onChange(of: useCoordinates)	{	usingMap	in
			if usingMap	{
				placeOrderViewModel.updateLocation(to: mapRegion.center)
				textFieldLabel	=	"Describe your location (Optional)"
			}	else	{
				placeOrderViewModel.resetLocation()
				textFieldLabel	=	"Describe your location"
			}
		}
		.onChange(of: mapRegion.center)	{	newLocation in
			placeOrderViewModel.updateLocation(to:	newLocation)
		}
	}
}



struct LocationInput_Previews: PreviewProvider {
    static var previews: some View {
        LocationInput(viewModel: PlaceOrderViewModel())
    }
}
