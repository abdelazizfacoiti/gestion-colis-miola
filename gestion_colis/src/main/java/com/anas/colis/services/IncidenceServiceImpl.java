package com.anas.colis.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.anas.colis.entities.Incidence;
import com.anas.colis.repositories.IncidenceRepository;
@Service
public class IncidenceServiceImpl implements IncidenceService {

	@Autowired
	IncidenceRepository incidenceRepository;
	@Override
	public List<Incidence> getAllIncidence() {
		return incidenceRepository.findAll();
	}

}
