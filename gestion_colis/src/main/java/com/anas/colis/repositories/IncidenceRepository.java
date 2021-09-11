package com.anas.colis.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.anas.colis.entities.Incidence;
@Repository
public interface IncidenceRepository extends JpaRepository<Incidence, Long> {

}
