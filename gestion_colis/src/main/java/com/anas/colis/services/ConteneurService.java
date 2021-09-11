package com.anas.colis.services;

import java.util.List;

import com.anas.colis.entities.ClientEntity;
import com.anas.colis.entities.Conteneur;

public interface ConteneurService {
	public List<Conteneur> getAllConteneurs();
	public Conteneur saveConteneur(Conteneur conteneur);
	public boolean existsById(Long id);
	public boolean existsByReference(String reference);
	public Conteneur updateConteneur(Conteneur conteneur);
	public void removeConteneur(Long id);

}
