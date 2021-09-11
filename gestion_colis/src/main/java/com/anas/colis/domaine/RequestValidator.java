package com.anas.colis.domaine;

import com.anas.colis.entities.ClientEntity;

import io.jsonwebtoken.lang.Assert;

/**
 * @author chanaka.k
 *
 */
public class RequestValidator {

	public static void validateCreateEmployeeRequest(ClientEntity request) {
		Assert.notNull(request, "Create Employee Request cannot be null");
		Assert.hasText(request.getNom(), "Nom est obligatoire");
		Assert.notNull(request.getPrenom(), "Prenom est obligatoire");
	}

	public static void validateGenerateTokenRequest(GenerateTokenRequest request) {
		
		Assert.notNull(request, "Generate JWS token Request cannot be null");
		Assert.hasText(request.getApiKey(), "API key is required");
		Assert.notNull(request.getAppId(), "Application id required");
		Assert.notNull(request.getCustomerId(), "Customer id required");
		
	}

}
