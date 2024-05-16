package com.fixkaar.rentDevice.Repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import com.fixkaar.rentDevice.Models.Device;

@Repository
public interface DeviceRepository extends MongoRepository<Device,String>{
	

	List<Device> findAllByCategory(String category);

	@Query(value="{'id': ?0}")
	Device findByDeviceId(String id);
	
}
