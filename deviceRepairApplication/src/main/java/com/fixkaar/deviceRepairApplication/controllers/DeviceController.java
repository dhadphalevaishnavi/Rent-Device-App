package com.fixkaar.deviceRepairApplication.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fixkaar.deviceRepairApplication.DTO.BrandDTO;
import com.fixkaar.deviceRepairApplication.DTO.ModelDTO;
import com.fixkaar.deviceRepairApplication.services.DeviceService;

@RestController
@RequestMapping("/device")
public class DeviceController {

	@Autowired
	DeviceService deviceService;

//	@GetMapping
//	public List<Device> getDevice() {
//		return deviceService.getAllDevices();
//	}
//
//	@GetMapping("/{deviceType1}/{deviceType2}")
//	public List<Device> getDeviceOfType(@PathVariable String deviceType1, @PathVariable String deviceType2) {
//		return deviceService.findDevicesOfType(deviceType1, deviceType2);
//	}
	
	
	// get brand info by device type
	@GetMapping("/{deviceType1}/{deviceType2}")
	public List<BrandDTO> getBrandDetailsByDeviceType(@PathVariable String deviceType1,
			@PathVariable String deviceType2) {
		return deviceService.findBrandNamesByDeviceType(deviceType1, deviceType2);
	}

	//get device model information by device type and brand name
	@GetMapping("/{deviceType1}/{deviceType2}/{brandName}")
	public List<ModelDTO> getModelByDeviceTypeAndBrandName(@PathVariable String deviceType1,
			@PathVariable String deviceType2, @PathVariable String brandName) {

		return deviceService.findModelByDeviceTypeAndBrandName(deviceType1, deviceType2, brandName);
	}

}
