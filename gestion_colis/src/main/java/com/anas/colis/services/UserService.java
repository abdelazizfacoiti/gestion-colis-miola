package com.anas.colis.services;

import com.anas.colis.entities.UserEntity;
import com.anas.colis.outils.Status;


public interface UserService {
	
	public UserEntity loginIn(String  username,String password);

}
