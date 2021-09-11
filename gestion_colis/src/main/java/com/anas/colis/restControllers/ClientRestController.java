package com.anas.colis.restControllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.anas.colis.entities.ClientEntity;
import com.anas.colis.services.ClientService;

@RestController
@RequestMapping("api/clients")
@CrossOrigin
public class ClientRestController {
	@Autowired
	ClientService clientService;
	
	@GetMapping("GetClients")
	public List<ClientEntity> getAllClient(){	
	return clientService.getAllClient();	
	}
	@PostMapping("SaveClient")
	public String saveClient(@Validated @RequestBody ClientEntity clientEntity) {
		if(clientService.existsById(clientEntity.getCin()))
			return "client exist dèja";
		clientService.saveClient(clientEntity);	
		return "client enregistrer avec succés";
	}
	
	@PutMapping("UpdateClient")
	public String updateClient(@Validated @RequestBody ClientEntity clientEntity) {
		if(clientService.existsById(clientEntity.getCin())) {
		 clientService.updateClient(clientEntity);
		 return "client modifié avec success";	
		}
		return "client n'existe pas";
	}
	
	@DeleteMapping("DeleteClient/{cin}")
	public String deleteClient(@PathVariable String cin) {
		if(clientService.existsById(cin)) {
		 clientService.removeClient(cin);
		 return "client supprimé avec success";	
		}
		return "client n'existe pas";
	}
	
	
	
	

}
