package com.fixkaar.rentDevice.DTO;

import java.util.Date;

import com.fixkaar.rentDevice.Models.Device;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDeviceResponse {
	
	Device device;
	Date rentFrom;
	Date rentTill;
	boolean returnStatus;

}
