package com.anas.colis.restControllers;

import java.util.List;

import javax.validation.Valid;

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

import com.anas.colis.entities.Conteneur;
import com.anas.colis.services.ConteneurService;

@RestController
@RequestMapping("api/conteneurs")
@CrossOrigin
public class ConteneurRestController {
	@Autowired
	ConteneurService conteneurService;
	
	@GetMapping("GetConteneurs")
	public List<Conteneur> getAllConteneurs(){	
	return conteneurService.getAllConteneurs();
	}
	@PostMapping("SaveConteneur")
	public String saveConteneur(@Valid @RequestBody Conteneur conteneur) {
		if(conteneurService.existsByReference(conteneur.getReference()))
			return "conteneur exist deja";
		conteneurService.saveConteneur(conteneur);	
		return "conteneur enregistre avec succes";
	}
	
	@PutMapping("UpdateConteneur")
	public String updateConteneur(@Validated @RequestBody Conteneur conteneur) {
		if(conteneurService.existsById(conteneur.getId())) {
			conteneurService.updateConteneur(conteneur);
		 return "conteneur modifie avec success";	
		}
		return "conteneur n'existe pas";
	}
	
	@DeleteMapping("DeleteConteneur/{id}")
	public String deleteConteneur(@PathVariable Long id) {
		if(conteneurService.existsById(id)) {
			conteneurService.removeConteneur(id);
		 return "conteneur supprime avec success";	
		}
		return "conteneur n'existe pas";
	}

}
