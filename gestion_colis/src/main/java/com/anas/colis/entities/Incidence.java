package com.anas.colis.entities;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Entity
@Data
public class Incidence {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private Date  dateIncidence;
	private String informations;
	@ManyToOne
	@JsonIgnore
	private Conteneur conteneur;
	@ManyToOne
	@JsonIgnore
	private Colis colis; 
	

}
