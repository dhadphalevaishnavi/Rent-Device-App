package com.fixkaar.deviceRepairApplication.models;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Document(collection = "user")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
	
	@Id
	String id;
	String firstName;
	String lastName;
	LoginDetails loginDetails;
	ContactDetails emailDetails;
	ContactDetails mobileDetails;
	List<DeviceServiceRequest> repairServiceRequests;
	

}
