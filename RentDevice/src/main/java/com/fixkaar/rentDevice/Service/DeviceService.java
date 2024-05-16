package com.fixkaar.rentDevice.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fixkaar.rentDevice.Models.Device;
import com.fixkaar.rentDevice.Repository.DeviceRepository;

@Service
public class DeviceService {

	@Autowired
	DeviceRepository deviceRepo;

	public List<Device> getDeviceByCategory(String category) {
		return deviceRepo.findAllByCategory(category);
	}

	public List<Device> getAllDevices() {
		
		return deviceRepo.findAll();
	}
	
	
	
}
