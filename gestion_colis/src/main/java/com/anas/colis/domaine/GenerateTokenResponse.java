package com.anas.colis.domaine;

import com.anas.colis.entities.UserEntity;

import lombok.Data;

@Data
public class GenerateTokenResponse {
	
	private String jwsKey;
	private String username;
	private UserEntity userEntity;

	public String getJwsKey() {
		return jwsKey;
	}

	public void setJwsKey(String jwsKey) {
		this.jwsKey = jwsKey;
	}

}
