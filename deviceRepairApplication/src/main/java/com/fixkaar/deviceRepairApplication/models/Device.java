package com.fixkaar.deviceRepairApplication.models;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Data;

@Data
@Document(collection ="device")
public class Device {
	
	@Id
	String id;
	String deviceType;
	Brand brand;
}

