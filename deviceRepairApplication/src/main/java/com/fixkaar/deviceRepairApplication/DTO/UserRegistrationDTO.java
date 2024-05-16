package com.fixkaar.deviceRepairApplication.DTO;

import com.fixkaar.deviceRepairApplication.models.LoginDetails;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserRegistrationDTO {
	
	String firstName;
	String lastName;
	LoginDetails loginDetails;
	

}
