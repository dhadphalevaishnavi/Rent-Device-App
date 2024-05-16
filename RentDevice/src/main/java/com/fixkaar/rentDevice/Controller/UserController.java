package com.fixkaar.rentDevice.Controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fixkaar.rentDevice.DTO.RegistrationDTO;
import com.fixkaar.rentDevice.DTO.VerifyEmailResponseModel;
import com.fixkaar.rentDevice.Models.User;
import com.fixkaar.rentDevice.Service.UserService;

@RestController
@RequestMapping("/user")
public class UserController {

	@Autowired
	UserService userService;
	
	@PostMapping("/register")
	public User registerUser(@RequestBody RegistrationDTO user) {

		return userService.registerUser(user);
	}

	@GetMapping("/verifyEmail/{email}")
	public VerifyEmailResponseModel verifyEmail(@PathVariable String email) {
		return userService.verifyEmail(email);
	}
	
	@GetMapping("/login/{email}")
	public Optional<User> login(@PathVariable String email) {
		return userService.loginUser(email);
	}
	
	@PutMapping("/updateUser/{userId}")
	public User updateUser(@RequestBody RegistrationDTO user, @PathVariable String userId) {
		return userService.updateUser(user,userId);
	}
	
	
}
