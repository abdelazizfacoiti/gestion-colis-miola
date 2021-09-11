package com.anas.colis.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.anas.colis.entities.Conteneur;
import com.anas.colis.repositories.ClientRepository;
import com.anas.colis.repositories.ConteneurRepository;


@Service
public class ConteneurServiceImpl implements ConteneurService {
	@Autowired
	ConteneurRepository conteneurRepository;

	@Override
	public List<Conteneur> getAllConteneurs() {
		return conteneurRepository.findAll();
	}

	@Override
	public Conteneur saveConteneur(Conteneur conteneur) {
		return conteneurRepository.save(conteneur);
	}

	@Override
	public Conteneur updateConteneur(Conteneur conteneur) {
		return conteneurRepository.save(conteneur);
	}

	@Override
	public void removeConteneur(Long id) {
		conteneurRepository.deleteById(id);

	}

	@Override
	public boolean existsById(Long id) {
		return conteneurRepository.existsById(id);
		
	}

	@Override
	public boolean existsByReference(String reference) {
		return conteneurRepository.existsByReference(reference);
	}

}
