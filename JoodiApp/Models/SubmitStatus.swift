//
//  SubmitStatus.swift
//  JoodiApp
//
//  Created by Ahmed Mgua on 4/13/21.
//

import Foundation

enum SubmitStatus:	Error	{
	case	standby, sending,	invalidURL,	noResponseFromServer,	failedToEncodeData,	success
}

extension	SubmitStatus:	LocalizedError	{
	var localizedDescription:	String	{
		switch self	{
			case	.standby	:	return ""
			case	.sending	:	return "Loading data"
			case	.invalidURL	:	return	"Invalid URL"
			case	.noResponseFromServer	:	return	"No response received from server"
			case	.failedToEncodeData	:	return	"Failed to encode data"
			case	.success	:	return	"Data decoded successfully"
		}
	}
}
