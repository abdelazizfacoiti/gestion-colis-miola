package com.anas.colis.restControllers;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.anas.colis.domaine.GenerateTokenRequest;
import com.anas.colis.domaine.GenerateTokenResponse;
import com.anas.colis.domaine.RequestValidator;
import com.anas.colis.entities.UserEntity;
import com.anas.colis.outils.Status;
import com.anas.colis.restControllers.common.HTTPResponseHandler;
import com.anas.colis.restControllers.common.RequestMappings;
import com.anas.colis.services.AuthService;
import com.anas.colis.services.UserService;

@RestController
@RequestMapping(RequestMappings.AUTH)
@CrossOrigin
public class AuthenticationRestController extends HTTPResponseHandler {

	final static Logger logger = Logger.getLogger(AuthenticationRestController.class);

	@Autowired
	private AuthService authService;
	@Autowired
	private UserService userService;

	/**
	 * Generate new JWS token.
	 *
	 */
	@RequestMapping(value = RequestMappings.GENERATE_JWS_TOKEN, method = RequestMethod.POST)
	public @ResponseBody GenerateTokenResponse generateToken(@RequestBody GenerateTokenRequest request) {

		RequestValidator.validateGenerateTokenRequest(request);

		logger.info("Inside > Generate JWS token endpoint ");

		GenerateTokenResponse response = null;

		try {
			UserEntity userEntity =userService.loginIn(request.getUsername(),request.getPassword());
			
			if(userEntity!=null) {
				System.out.println(userEntity);
				userEntity.setLoggedIn(true);
				userEntity.setPassword("");
			response = authService.generateJWSToken(request);
			response.setUserEntity(userEntity);
			
			}
			

		} catch (Exception e) {
			logger.error("Erorr occured while generating JWS token");
		}
		return response;

	}

}
