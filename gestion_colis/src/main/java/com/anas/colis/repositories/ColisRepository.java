package com.anas.colis.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.anas.colis.entities.Colis;

public interface ColisRepository extends JpaRepository<Colis, Long> {

}
