package com.fixkaar.deviceRepairApplication.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.fixkaar.deviceRepairApplication.DTO.LoginResponseDTO;
import com.fixkaar.deviceRepairApplication.DTO.UserRegistrationDTO;
import com.fixkaar.deviceRepairApplication.models.Device;
import com.fixkaar.deviceRepairApplication.models.DeviceServiceRequest;
import com.fixkaar.deviceRepairApplication.models.LoginDetails;
import com.fixkaar.deviceRepairApplication.models.User;
import com.fixkaar.deviceRepairApplication.repositories.DeviceRepository;
import com.fixkaar.deviceRepairApplication.repositories.UserRepository;

@Service
public class UserService {

	@Autowired
	UserRepository userRepo;

	@Autowired
	DeviceRepository deviceRepo;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;



	public UserRegistrationDTO getUserinfo() {

		User user = userRepo.findByLoginDetailsEmail("rekhaKulkarno99@gmail.com");
		return new UserRegistrationDTO(user.getFirstName(), user.getLastName(), user.getLoginDetails());

	}

	public String registerUser(UserRegistrationDTO userDTO) {

		// find if user already exists
		if (userRepo.findByLoginDetailsEmail(userDTO.getLoginDetails().getEmail()) == null) {

			// encode password before saving
			String encodedPassword = passwordEncoder.encode(userDTO.getLoginDetails().getPassword());
			userDTO.getLoginDetails().setPassword(encodedPassword);

			User user = UserRegistrationDTOToUser(userDTO);

			if (userRepo.save(user) != null)
				return "User registered successfully!";

			return "User registration failed";
		}
		return "Account already exists with this email...";
	}

	public LoginResponseDTO loginUser(LoginDetails loginDetails) {
		User user = userRepo.findByLoginDetailsEmail(loginDetails.getEmail());
		if (user != null) {
			// validate password
			if (passwordEncoder.matches(loginDetails.getPassword(), user.getLoginDetails().getPassword())) {
				return UserToLoginResponseDTO(user);

			} else
				return null;
		}
		return null;
	}

	public String addDeviceRepairRequest(String deviceType1, String deviceType2, String brandName, String modelName,
			String email) {

		// first check if same request already don't exists or has serviceStatus as Incomplete
		if (userRepo.findByDeviceTypeBrandNameModelEmail(deviceType1, deviceType2, brandName, modelName,
				email) == null) {
			Device device = deviceRepo.findByDeviceTypeBrandNameModel(deviceType1, deviceType2, brandName, modelName);
			User user = userRepo.findByLoginDetailsEmail(email);

			if (user != null && device != null) {
				DeviceServiceRequest deviceServiceRequest = new DeviceServiceRequest();
				deviceServiceRequest.setServiceStatus("Incomplete");
				deviceServiceRequest.setDevice(device);

				if (user.getRepairServiceRequests() == null) {
					List<DeviceServiceRequest> deviceServiceRequestList = new ArrayList<>();
					user.setRepairServiceRequests(deviceServiceRequestList);
				}

				user.getRepairServiceRequests().add(deviceServiceRequest);

				if(userRepo.save(user) != null)

				return "Repair service request submitted!";
			}
		}

		return "Repair Service Request already exists for this Device!";
	}

	
	public List<DeviceServiceRequest> getDeviceRepairRequestsForUser(String email) {
		
		User user = userRepo.findRepairServiceRequest(email);
		List<DeviceServiceRequest> deviceList = new ArrayList<>();
		deviceList = user.getRepairServiceRequests();
		return deviceList;
	}
	
	
	private LoginResponseDTO UserToLoginResponseDTO(User user) {
		return new LoginResponseDTO(user.getFirstName(), user.getLastName());
	}

//	private UserDTO UsertoUserDTO(User user) {
//
//		return new UserDTO(user.getFirstName(), user.getLastName(), user.getEmailDetails(), user.getMobileDetails(),
//				user.getRepairServiceRequests());
//	}

	private User UserRegistrationDTOToUser(UserRegistrationDTO user) {
		return new User(null, user.getFirstName(), user.getLastName(), user.getLoginDetails(), null, null, null);
	}

}
