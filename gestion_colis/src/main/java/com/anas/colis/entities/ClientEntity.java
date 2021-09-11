package com.anas.colis.entities;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.sun.istack.NotNull;

import lombok.Data;
@Data
@Entity
public class ClientEntity {
	
	@Id
	@NotNull
	private String cin;
	@NotNull
	private String nom;
	@NotNull
	private String prenom;
	private String addresse;
	private String ville;
	private String tel;
	@OneToMany(mappedBy = "client")
	@JsonIgnore
	private List<Colis> colis;
	
	
	
	
	
	
	
	
	
	
	
	

}
