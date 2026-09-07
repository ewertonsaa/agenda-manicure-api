package com.agenda.agendamanicure.controller;

import com.agenda.agendamanicure.entity.Profissional;
import com.agenda.agendamanicure.repository.ProfissionalRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/profissionais")
public class ProfissionalController {

    private final ProfissionalRepository profissionalRepository;

    public ProfissionalController(ProfissionalRepository profissionalRepository) {
        this.profissionalRepository = profissionalRepository;
    }

    @PostMapping
    public Profissional cadastrar(@RequestBody Profissional profissional) {
        return profissionalRepository.save(profissional);
    }

    @GetMapping
    public List<Profissional> listar() {
        return profissionalRepository.findAll();
    }
}