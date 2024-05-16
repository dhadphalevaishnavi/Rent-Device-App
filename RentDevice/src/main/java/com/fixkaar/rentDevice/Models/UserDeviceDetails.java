package com.fixkaar.rentDevice.Models;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.annotation.Collation;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Collation("userDeviceDetails")
public class UserDeviceDetails {

	@Id
	String id;
	String userId;
	String deviceId;
	Date rentFrom;
	Date rentTill;
	boolean returnStatus;
	
	
}
