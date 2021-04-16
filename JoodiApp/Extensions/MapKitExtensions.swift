//
//  MapKitExtensions.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/16/21.
//

import MapKit

extension CLLocationCoordinate2D: Equatable {
	static public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
		return (lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude)
	}
}

extension CLLocationCoordinate2D	{
	internal init(location:	Location)	{
		self.init(latitude:	location.latitude,	longitude:	location.longitude)
	}
}
