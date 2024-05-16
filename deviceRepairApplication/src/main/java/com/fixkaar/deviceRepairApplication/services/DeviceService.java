package com.fixkaar.deviceRepairApplication.services;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fixkaar.deviceRepairApplication.DTO.BrandDTO;
import com.fixkaar.deviceRepairApplication.DTO.ModelDTO;
import com.fixkaar.deviceRepairApplication.models.Brand;
import com.fixkaar.deviceRepairApplication.models.Device;
import com.fixkaar.deviceRepairApplication.models.Model;
import com.fixkaar.deviceRepairApplication.repositories.DeviceRepository;

@Service
public class DeviceService {

	@Autowired
	DeviceRepository deviceRepo;



	public List<BrandDTO> findBrandNamesByDeviceType(String deviceType1, String deviceType2) {

		List<BrandDTO> brandDTOList = new ArrayList<>();
		List<Device> deviceList = deviceRepo.findBrandDetailsByDeviceType(deviceType1, deviceType2);
			
		for (Device device : deviceList) {
			brandDTOList.add(deviceToBrandDTO(device.getBrand()));
		}
		
		brandDTOList = brandDTOList.stream().distinct().collect(Collectors.toList());
		return brandDTOList;
	}
	
	
	
	public List<ModelDTO> findModelByDeviceTypeAndBrandName(String deviceType1, String deviceType2, String brandName){
		
		List<ModelDTO> modelDTOList = new ArrayList<>();
		List<Device> deviceList = deviceRepo.findModelsByBrandNameAndDeviceType(deviceType1, deviceType2, brandName);
		
		for(Device device: deviceList) {
			modelDTOList.add(deviceToModelDTO(device.getBrand().getModel()));
		}
		
		return modelDTOList;
	}
	

	// repository only returns Device object
	// so, we need to Convert Brand to BrandDTO to only Extract brand_name and
	// brand_image
	BrandDTO deviceToBrandDTO(Brand brand) {

		return new BrandDTO(brand.getBrandName(), brand.getBrandImage());

	}

	ModelDTO deviceToModelDTO(Model model) {

		return new ModelDTO(model.getModelName(), model.getModelImage(), model.getProcessor(), model.getOs(),
				model.getRam());
	}

}
