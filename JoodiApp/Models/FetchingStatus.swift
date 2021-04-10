//
//  FetchingStatus.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/10/21.
//

import Foundation

enum FetchingStatus:	Error	{
	case	standby, loading,	invalidURL,	noDataFromServer,	failedToDecodeData,	success
}

extension	FetchingStatus:	LocalizedError	{
	var localizedDescription:	String	{
		switch self	{
			case	.standby	:	return ""
			case	.loading	:	return "Loading data"
			case	.invalidURL	:	return	"Invalid URL"
			case	.noDataFromServer	:	return	"No data received from server"
			case	.failedToDecodeData	:	return	"Failed to decode data"
			case	.success	:	return	"Data decoded successfully"
		}
	}
}
