package com.fixkaar.deviceRepairApplication.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ModelDTO {
	
	String modelName;
	String modelImage;
	String processor;
	String os;
	String ram;

}
