package com.anas.colis.restControllers;

import java.util.Date;
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

import com.anas.colis.entities.Colis;
import com.anas.colis.entities.Conteneur;
import com.anas.colis.services.ColisService;
import com.anas.colis.services.ConteneurService;

@RestController
@RequestMapping("api/colis")
@CrossOrigin
public class ColisRestController {
	@Autowired
	ColisService colisService;
	
	@GetMapping("GetColis")
	public List<Colis> getAllColis(){	
	return colisService.getAllColis();
	}
	@PostMapping("SaveColis")
	public String saveColis(@Valid @RequestBody Colis colis) {
		colis.setDateReception(new Date());
		colisService.saveColis(colis);	
		return "colis enregistre avec succes";
	}
	
	@PutMapping("UpdateColis")
	public String updateColis(@Validated @RequestBody Colis colis) {
		if(colisService.existsById(colis.getId())) {
			colisService.updateColis(colis);
		 return "colis modifie avec success";	
		}
		return "colis n'existe pas";
	}
	
	@DeleteMapping("DeleteColis/{id}")
	public String deleteColis(@PathVariable Long id) {
		if(colisService.existsById(id)) {
			colisService.removeColis(id);
		 return "colis supprime avec success";	
		}
		return "colis n'existe pas";
	}

}
