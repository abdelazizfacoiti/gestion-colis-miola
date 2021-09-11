package com.anas.colis.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.anas.colis.entities.ClientEntity;


public interface ClientService {
	
	public List<ClientEntity> getAllClient();
	public ClientEntity saveClient(ClientEntity clientEntity);
	public boolean existsById(String cin);
	public ClientEntity updateClient(ClientEntity clientEntity);
	public void removeClient(String cin);

}
