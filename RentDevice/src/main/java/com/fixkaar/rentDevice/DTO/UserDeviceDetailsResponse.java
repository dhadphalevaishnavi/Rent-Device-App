package com.fixkaar.rentDevice.DTO;

import java.util.Date;
import java.util.Optional;

import com.fixkaar.rentDevice.Models.User;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDeviceDetailsResponse {
	
	Optional<User> user;
	Date rentFrom;
	Date rentTill;
	boolean returnStatus;
	

}
