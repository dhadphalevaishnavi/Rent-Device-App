package com.fixkaar.deviceRepairApplication.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fixkaar.deviceRepairApplication.DTO.LoginResponseDTO;
import com.fixkaar.deviceRepairApplication.DTO.UserRegistrationDTO;
import com.fixkaar.deviceRepairApplication.models.DeviceServiceRequest;
import com.fixkaar.deviceRepairApplication.models.LoginDetails;
import com.fixkaar.deviceRepairApplication.services.UserService;

@RestController
@RequestMapping("/user")
public class UserController {

	@Autowired
	UserService userService;



	@PostMapping("/register")
	public String registerUser(@RequestBody UserRegistrationDTO user) {

		return userService.registerUser(user);
	}

	@PostMapping("/login")
	public LoginResponseDTO loginUser(@RequestBody LoginDetails loginDetails) {
		return userService.loginUser(loginDetails);
	}

	@PutMapping("/request-repaire/{deviceType1}/{deviceType2}/{brandName}/{modelName}/{email}")
	public String addDeviceRepairRequest(@PathVariable String deviceType1, @PathVariable String deviceType2,
			@PathVariable String brandName, @PathVariable String modelName, @PathVariable String email) {

		return userService.addDeviceRepairRequest(deviceType1,deviceType2,brandName,modelName,email);
	}

	@GetMapping("/getDeviceRepairRequestList/{email}")
	public List<DeviceServiceRequest> getDeviceRepairRequestList(@PathVariable String email){
		return userService.getDeviceRepairRequestsForUser(email);
	}
	
}
