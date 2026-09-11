package com.agenda.agendamanicure.controller;

import com.agenda.agendamanicure.entity.Profissional;
import com.agenda.agendamanicure.service.ProfissionalService;
import org.springframework.web.bind.annotation.*;
import com.agenda.agendamanicure.dto.ProfissionalRequest;

import java.util.List;

@RestController
@RequestMapping("/profissionais")
public class ProfissionalController {

    private final ProfissionalService profissionalService;

    public ProfissionalController(ProfissionalService profissionalService) {
        this.profissionalService = profissionalService;
    }

    @PostMapping
    public Profissional cadastrar(@RequestBody ProfissionalRequest request) {

        Profissional profissional = new Profissional();

        profissional.setNome(request.getNome());
        profissional.setTelefone(request.getTelefone());

        return profissionalService.cadastrar(profissional);
    }

    @GetMapping
    public List<Profissional> listar() {
        return profissionalService.listar();
    }

    @GetMapping("/{id}")
    public Profissional buscarPorId(@PathVariable Long id) {
        return profissionalService.buscarPorId(id);
    }

    @PutMapping("/{id}")
    public Profissional atualizar(
            @PathVariable Long id,
            @RequestBody Profissional profissional) {

        return profissionalService.atualizar(id, profissional);
    }

    @DeleteMapping("/{id}")
    public void excluir(@PathVariable Long id) {
        profissionalService.excluir(id);
    }
}