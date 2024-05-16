package com.fixkaar.deviceRepairApplication.DTO;

import java.util.List;

import com.fixkaar.deviceRepairApplication.models.ContactDetails;
import com.fixkaar.deviceRepairApplication.models.DeviceServiceRequest;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO {

	String firstName;
	String lastName;
	ContactDetails emailDetails;
	ContactDetails mobileDetails;
	List<DeviceServiceRequest> repair_service_requests;

}
