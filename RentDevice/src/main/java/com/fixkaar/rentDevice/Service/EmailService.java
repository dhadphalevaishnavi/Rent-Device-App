package com.fixkaar.rentDevice.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

	@Autowired
	JavaMailSender javaMailSender;

	@Value("${spring.mail.username}")
	String sendFromEmail;

	public boolean sendEmail(String sendToEmail, String subject, String body) {

		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom(sendFromEmail);
		message.setTo(sendToEmail);
		message.setSubject(subject);
		message.setText(body);

		try {
			javaMailSender.send(message);
			System.out.println("Mail sent..............................");
			return true;

		} catch (Exception e) {
			System.out.println("Error while sending email...");
			e.printStackTrace();
		}
		return false;

	}

}
