package com.anas.colis.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.anas.colis.entities.UserEntity;
import com.anas.colis.outils.Status;
import com.anas.colis.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserRepository userRepository;
	
	

	@Override
	public UserEntity loginIn(String username,String password) {
		List<UserEntity> listAllUser=userRepository.findAll();
		for (UserEntity userEntity2 : listAllUser) {
			if(userEntity2.getUsername().equals(username) && userEntity2.getPassword().equals(password)) { 
				return userEntity2;		
			}
		}		
		return null;
	}
	
	
}
