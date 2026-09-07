package com.agenda.agendamanicure.controller;

import com.agenda.agendamanicure.entity.Servico;
import com.agenda.agendamanicure.repository.ServicoRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/servicos")
public class ServicoController {

    private final ServicoRepository servicoRepository;

    public ServicoController(ServicoRepository servicoRepository) {
        this.servicoRepository = servicoRepository;
    }

    @PostMapping
    public Servico cadastrar(@RequestBody Servico servico) {
        return servicoRepository.save(servico);
    }

    @GetMapping
    public List<Servico> listar() {
        return servicoRepository.findAll();
    }
}