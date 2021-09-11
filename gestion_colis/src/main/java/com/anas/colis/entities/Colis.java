package com.anas.colis.entities;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
@Data
@Entity
public class Colis {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String nom;
	private String detail;
	private Date dateReception;
	private boolean flamable;
	private double temperatureIdial;
	private double humiditeIdial;
	private double poids;
	@ManyToOne
	private Conteneur conteneur;
	@ManyToOne
	private ClientEntity client;
	
	@OneToMany(mappedBy = "colis")
	@JsonIgnore
	private List<Incidence> incidence;
	
	
	
	
	
}
