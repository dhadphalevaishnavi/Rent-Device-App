package com.fixkaar.deviceRepairApplication.repositories;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import com.fixkaar.deviceRepairApplication.models.User;


@Repository
public interface UserRepository extends MongoRepository<User, String>{

	
	User findByLoginDetailsEmail(String email);
	
	@Query("{'loginDetails.email':?4 , 'repairServiceRequests.device.deviceType': {$in: [?0,?1]}, 'repairServiceRequests.device.brand.brandName': ?2, 'repairServiceRequests.device.brand.model.modelName': ?3 , 'repairServiceRequests.serviceStatus': 'Incomplete'}")
	User findByDeviceTypeBrandNameModelEmail(String deviceType1, String deviceType2, String brandName, String modelName,String email);
	
	@Query(value = "{'loginDetails.email':?0}", fields = "{'repairServiceRequests':1}")
	User findRepairServiceRequest(String email);
	
	
}
