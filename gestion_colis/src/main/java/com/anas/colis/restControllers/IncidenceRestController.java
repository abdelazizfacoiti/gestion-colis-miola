package com.anas.colis.restControllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.anas.colis.entities.Conteneur;
import com.anas.colis.entities.Incidence;
import com.anas.colis.services.IncidenceService;

@RestController
@CrossOrigin
@RequestMapping("api/incidences")
public class IncidenceRestController {
	
	@Autowired
	IncidenceService incidenceService;
	
	@GetMapping("GetIncidences")
	public List<Incidence> getAllIncidences(){	
	return incidenceService.getAllIncidence();
	}
	

}
