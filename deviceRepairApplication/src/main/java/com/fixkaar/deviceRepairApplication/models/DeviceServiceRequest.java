package com.fixkaar.deviceRepairApplication.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeviceServiceRequest {
	
	Device device;
	String serviceStatus;
	

}
