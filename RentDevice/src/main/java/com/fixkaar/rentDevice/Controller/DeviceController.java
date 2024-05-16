package com.fixkaar.rentDevice.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fixkaar.rentDevice.Models.Device;
import com.fixkaar.rentDevice.Service.DeviceService;

@RestController
@RequestMapping("/device")
public class DeviceController {
	
	@Autowired
	DeviceService deviceService;
	
	
	@GetMapping("/")
	public List<Device> getAllDevices()
	{
		return deviceService.getAllDevices();
	}
	
	
	@GetMapping("/{category}")
	public List<Device> getDeviceByCategory(@PathVariable String category)
	{
		return deviceService.getDeviceByCategory(category);
	}
	
	
}
