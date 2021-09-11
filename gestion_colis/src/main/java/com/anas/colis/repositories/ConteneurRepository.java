package com.anas.colis.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.anas.colis.entities.ClientEntity;
import com.anas.colis.entities.Conteneur;

public interface ConteneurRepository extends JpaRepository<Conteneur, Long>{
	public boolean existsByReference(String reference);
	public boolean existsById(Long id);
	

}
