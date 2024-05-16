package com.fixkaar.rentDevice.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fixkaar.rentDevice.DTO.UserDeviceDetailsResponse;
import com.fixkaar.rentDevice.DTO.UserDeviceResponse;
import com.fixkaar.rentDevice.Service.UserDeviceService;

@RestController
@RequestMapping("/userDevice")
public class UserDeviceController {

	@Autowired
	UserDeviceService userDeviceService;
	
	
	@PostMapping("/rentDevice/{userId}/{deviceId}")
	public boolean rentDevice(@PathVariable String userId, @PathVariable String deviceId) {
		return userDeviceService.rentDevice(userId,deviceId);
	}
	
	@PutMapping("/returnDevice/{userId}/{deviceId}")
	public boolean returnDevice(@PathVariable String userId, @PathVariable String deviceId) {
		return userDeviceService.returnDevice(userId,deviceId);
	}
	
	
	@GetMapping("/getDevicesOfUser/{userId}")
	public List<UserDeviceResponse> getDevicesOfUser(@PathVariable String userId){
		return userDeviceService.getDevicesOfUser(userId);
	}
	
	@GetMapping("/getDeviceByDeviceId/{deviceId}")
	public UserDeviceDetailsResponse getDeviceByDeviceId(@PathVariable String deviceId){
		return userDeviceService.getDeviceByDeviceId(deviceId);
	}
	
}
