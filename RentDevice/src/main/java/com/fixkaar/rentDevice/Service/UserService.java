package com.fixkaar.rentDevice.Service;

import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fixkaar.rentDevice.DTO.RegistrationDTO;
import com.fixkaar.rentDevice.DTO.VerifyEmailResponseModel;
import com.fixkaar.rentDevice.Models.User;
import com.fixkaar.rentDevice.Repository.UserRepository;

@Service
public class UserService {

	@Autowired
	UserRepository userRepo;

	@Autowired
	EmailService emailService;

	// returns saved user
	public User registerUser(RegistrationDTO userDTO) {
		User user = RegistrationDTOToUser(userDTO);
		return userRepo.save(user);
	}

	public Optional<User> loginUser(String email) {

		return userRepo.findByEmail(email);
	}

	public VerifyEmailResponseModel verifyEmail(String email) {
		VerifyEmailResponseModel verifyEmailResponseModel = new VerifyEmailResponseModel();

		// Generate OTP
		String otp = generateOTP();

		// Send Email
		if (emailService.sendEmail(email, "Fixkaar OTP",
				"Your OTP for Rent Device App is " + otp + " valid for 5 minutes")) {

			verifyEmailResponseModel.setOtp(otp);
			// if email is sent successfully then
			// check if user already present in DB
			Optional<User> user = userRepo.findByEmail(email);
			if (user.isPresent()) {
				verifyEmailResponseModel.setUserAlreadyPresent(true);

			}
		}
		return verifyEmailResponseModel;
	}

	private String generateOTP() {
		String digitString = "1234567890";
		char otp[] = new char[6];

		Random random = new Random();
		for (int i = 0; i < 6; i++) {
			otp[i] = digitString.charAt(random.nextInt(digitString.length()));

		}
		return new String(otp);
	}

	private User RegistrationDTOToUser(RegistrationDTO userDTO) {
		User user = new User();
		user.setEmail(userDTO.getEmail());
		user.setFirstName(userDTO.getFirstName());
		user.setLastName(userDTO.getLastName());
		user.setMobile(userDTO.getMobile());
		return user;
	}

	public User updateUser(RegistrationDTO userDTO, String userId) {

		if (userRepo.existsById(userId)) {
			User tempUser = new User();
			tempUser.setEmail(userDTO.getEmail());
			tempUser.setFirstName(userDTO.getFirstName());
			tempUser.setLastName(userDTO.getLastName());
			tempUser.setMobile(userDTO.getMobile());
			tempUser.setId(userId);

			return userRepo.save(tempUser);
	}
		return null;
	}
}
