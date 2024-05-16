package com.fixkaar.rentDevice.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fixkaar.rentDevice.DTO.UserDeviceDetailsResponse;
import com.fixkaar.rentDevice.DTO.UserDeviceResponse;
import com.fixkaar.rentDevice.Models.Device;
import com.fixkaar.rentDevice.Models.User;
import com.fixkaar.rentDevice.Models.UserDeviceDetails;
import com.fixkaar.rentDevice.Repository.DeviceRepository;
import com.fixkaar.rentDevice.Repository.UserDeviceRepository;
import com.fixkaar.rentDevice.Repository.UserRepository;

@Service
public class UserDeviceService {

	@Autowired
	UserDeviceRepository userDeviceRepo;

	@Autowired
	DeviceRepository deviceRepo;

	@Autowired
	UserRepository userRepo;

//	final String returnStatusFalse = "Not Returned";
//	final String returnStatusTrue = "Returned";

	public boolean rentDevice(String userId, String deviceId) {

//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");

		UserDeviceDetails userDevice = new UserDeviceDetails();
		userDevice.setUserId(userId);
		userDevice.setDeviceId(deviceId);
		userDevice.setRentFrom(new Date());
		userDevice.setReturnStatus(false);

		if (userDeviceRepo.save(userDevice) != null) {
			Device deviceFromDB = deviceRepo.findByDeviceId(deviceId);
			deviceFromDB.setAvailable(false);
			if (deviceRepo.save(deviceFromDB) != null) {
				return true;
			}
		}

		return false;
	}

	public boolean returnDevice(String userId, String deviceId) {
		UserDeviceDetails userDevice = userDeviceRepo.findByUserIdDeviceIdReturnStatusFalse(userId, deviceId, false);
		userDevice.setRentTill(new Date());
		userDevice.setReturnStatus(true);
		if (userDeviceRepo.save(userDevice) != null) {
			Device deviceFromDB = deviceRepo.findByDeviceId(deviceId);
			deviceFromDB.setAvailable(true);
			if (deviceRepo.save(deviceFromDB) != null) {
				return true;
			}
		}

		return false;
	}

	public List<UserDeviceResponse> getDevicesOfUser(String userId) {
		List<UserDeviceResponse> UserDeviceResponseList = new ArrayList<>();
		List<UserDeviceDetails> userDeviceList = userDeviceRepo.findByUserId(userId);

		for (UserDeviceDetails userDevice : userDeviceList) {
			Device device = deviceRepo.findByDeviceId(userDevice.getDeviceId());

			UserDeviceResponse userDeviceResponse = new UserDeviceResponse();
			userDeviceResponse.setDevice(device);
			userDeviceResponse.setRentFrom(userDevice.getRentFrom());
			userDeviceResponse.setRentTill(userDevice.getRentTill());
			userDeviceResponse.setReturnStatus(userDevice.isReturnStatus());

			UserDeviceResponseList.add(userDeviceResponse);

		}

		return UserDeviceResponseList;

	}

	public UserDeviceDetailsResponse getDeviceByDeviceId(String deviceId) {

		UserDeviceDetails userDevice = userDeviceRepo.findByDeviceId(deviceId, false);

		return userDeviceDetailsToUserDeviceDetailsResponse(userDevice);
	}

	private UserDeviceDetailsResponse userDeviceDetailsToUserDeviceDetailsResponse(UserDeviceDetails userDevice) {
		UserDeviceDetailsResponse userDeviceResponse = new UserDeviceDetailsResponse();
		Optional<User> user = userRepo.findById(userDevice.getUserId());
		if (user != null) {

			userDeviceResponse.setRentFrom(userDevice.getRentFrom());
			userDeviceResponse.setRentTill(userDevice.getRentTill());
			userDeviceResponse.setReturnStatus(userDevice.isReturnStatus());
			userDeviceResponse.setUser(user);

		}
		return userDeviceResponse;
	}

}
