package com.anas.colis.entities;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
@Data
@Entity
public class Conteneur {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String reference;
	private String titre;
	private String description;
	private String temperature;
	private String humidite;
	private String coordonne_Gps;
	@OneToMany(mappedBy = "conteneur")
	@JsonIgnore
	private List<Colis> colis;
	
	@OneToMany(mappedBy = "conteneur")
	@JsonIgnore
	private List<Incidence> incidence;
	
	
	
	
	

}
