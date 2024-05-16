package com.fixkaar.rentDevice.Models;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.annotation.Collation;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Collation("user")
public class User {

	@Id
	String id;
	String firstName;
	String lastName;
	String email;
	Long mobile;
	
}
