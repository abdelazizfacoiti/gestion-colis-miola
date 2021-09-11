package com.anas.colis.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.anas.colis.entities.ClientEntity;
@Repository
public interface ClientRepository extends JpaRepository<ClientEntity, String> {
	public boolean existsById(String cin);

}
