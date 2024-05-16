package com.fixkaar.rentDevice.Repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import com.fixkaar.rentDevice.Models.UserDeviceDetails;

@Repository
public interface UserDeviceRepository extends MongoRepository<UserDeviceDetails, String> {
	
	@Query(value = "{'userId': ?0 , 'deviceId': ?1 , 'returnStatus': ?2}")
	UserDeviceDetails findByUserIdDeviceIdReturnStatusFalse(String userId, String deviceId, boolean returnStatus);
	
	List<UserDeviceDetails> findByUserId(String userId);
	
	@Query(value = "{'deviceId' : ?0 , 'returnStatus' : ?1}")
	UserDeviceDetails findByDeviceId(String deviceId,boolean returnStatus);
	

}
