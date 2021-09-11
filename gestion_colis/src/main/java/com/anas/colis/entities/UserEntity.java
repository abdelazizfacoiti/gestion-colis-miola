package com.anas.colis.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
@Entity
public class UserEntity {

	private @Id @GeneratedValue(strategy = GenerationType.IDENTITY) long id;
	private @NotBlank String nom; 
	private @NotBlank String prenom; 
	private @NotBlank String addresse; 
	private @NotBlank String username;
	private @NotBlank String password;
	private @NotBlank boolean loggedIn;

}
