package com.fixkaar.rentDevice.Models;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.annotation.Collation;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Collation("device")
public class Device {
	@Id
	String id;
	String category;
	String name;
	String imageUrl[];
	boolean isAvailable;
}
