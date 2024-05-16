package com.fixkaar.rentDevice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

import com.fixkaar.rentDevice.Service.EmailService;

@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
public class RentDeviceApplication {


//    @Bean
//    JavaMailSender javaMailSenderBean()
//	{
//		return new JavaMailSenderImpl();
//	}
    
    @Autowired
    EmailService emailService;

	public static void main(String[] args) {
		SpringApplication.run(RentDeviceApplication.class, args);

	}
	
//	@EventListener(ApplicationReadyEvent.class)
//	public void ccc() {
//		emailService.sendEmail("dhadphalevaishnavi@gmail.com", "Fixkaar OTP",
//				"Your OTP for Rent Device App is " + 123456 + " valid for 5 minutes");
//	}


}
