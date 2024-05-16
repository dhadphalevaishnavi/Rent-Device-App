package com.fixkaar.rentDevice.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RegistrationDTO {

	String firstName;
	String lastName;
	String email;
	Long mobile;
	
}
