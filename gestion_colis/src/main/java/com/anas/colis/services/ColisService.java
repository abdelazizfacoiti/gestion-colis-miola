package com.anas.colis.services;

import java.util.List;

import com.anas.colis.entities.Colis;
import com.anas.colis.entities.Conteneur;

public interface ColisService {
	
	public List<Colis> getAllColis();
	public Colis saveColis(Colis colis);
	public boolean existsById(Long id);
	public Colis updateColis(Colis colis);
	public void removeColis(Long id);

}
