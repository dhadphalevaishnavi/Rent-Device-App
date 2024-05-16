package com.fixkaar.deviceRepairApplication.repositories;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import com.fixkaar.deviceRepairApplication.models.Device;


@Repository
public interface DeviceRepository extends MongoRepository<Device, String>{


	@Query(value = "{'deviceType': {$in: [?0, ?1]}}", fields="{'brand.brandName':1, 'brand.brandImage':1}")
//	@Aggregation(pipeline = {"{'$group': {'_id':'$brand.brand_name'}"})
	List<Device> findBrandDetailsByDeviceType(String deviceType1, String deviceType2);
	
	@Query(value = "{'brand.brandName': ?2, 'deviceType':{$in:[?0, ?1]}}" , fields= "{'brand.model':1}")
	List<Device> findModelsByBrandNameAndDeviceType(String deviceType1, String deviceType2, String brandName);
	
	@Query("{'deviceType': {$in: [?0,?1]}, 'brand.brandName': ?2, 'brand.model.modelName': ?3 }")
	Device findByDeviceTypeBrandNameModel(String deviceType1, String deviceType2, String brandName, String modelName);
	
}

