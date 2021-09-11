package com.anas.colis.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.anas.colis.entities.ClientEntity;
import com.anas.colis.repositories.ClientRepository;
@Service
public class ClientServiceImpl implements ClientService {
	@Autowired
	ClientRepository clientRepository;

	@Override
	public List<ClientEntity> getAllClient() {
	return clientRepository.findAll();
	}

	@Override
	public ClientEntity saveClient(ClientEntity clientEntity) {
		return clientRepository.save(clientEntity);
	}

	@Override
	public boolean existsById(String cin) {
		return clientRepository.existsById(cin);
	}

	@Override
	public ClientEntity updateClient(ClientEntity clientEntity) {
		return clientRepository.save(clientEntity);
	}

	@Override
	public void removeClient(String cin) {
		 clientRepository.deleteById(cin);
	}

}
