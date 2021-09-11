package com.anas.colis.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.anas.colis.entities.Colis;
import com.anas.colis.repositories.ColisRepository;

@Service
public class ColisServiceImpl implements ColisService {
	@Autowired
	ColisRepository colisRepository;

	@Override
	public List<Colis> getAllColis() {
		return  colisRepository.findAll();
	}

	@Override
	public Colis saveColis(Colis colis) {
		return colisRepository.save(colis);
	}

	@Override
	public boolean existsById(Long id) {
		return colisRepository.existsById(id);
	}

	@Override
	public Colis updateColis(Colis colis) {
		return colisRepository.save(colis);
	}

	@Override
	public void removeColis(Long id) {
		colisRepository.deleteById(id);

	}

}
