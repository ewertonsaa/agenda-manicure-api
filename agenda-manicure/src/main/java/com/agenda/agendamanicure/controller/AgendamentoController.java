package com.agenda.agendamanicure.controller;

import com.agenda.agendamanicure.dto.AgendamentoRequest;
import com.agenda.agendamanicure.entity.Agendamento;
import com.agenda.agendamanicure.service.AgendamentoService;
import org.springframework.web.bind.annotation.*;
import com.agenda.agendamanicure.dto.AgendamentoResponse;

import java.util.List;

@RestController
@RequestMapping("/agendamentos")
public class AgendamentoController {

    private final AgendamentoService agendamentoService;

    public AgendamentoController(AgendamentoService agendamentoService) {
        this.agendamentoService = agendamentoService;
    }

    @GetMapping
    public List<Agendamento> listar() {
        return agendamentoService.listar();
    }

    @PostMapping
    public AgendamentoResponse criar(@RequestBody AgendamentoRequest request) {
        return agendamentoService.criar(request);
    }

    @GetMapping("/{id}")
    public Agendamento buscarPorId(@PathVariable Long id) {
        return agendamentoService.buscarPorId(id);
    }

    @PutMapping("/{id}/cancelar")
    public Agendamento cancelar(@PathVariable Long id) {
        return agendamentoService.cancelar(id);
    }

    @DeleteMapping("/{id}")
    public void excluir(@PathVariable Long id) {
        agendamentoService.excluir(id);
    }

    @PutMapping("/{id}")
    public Agendamento atualizar(
            @PathVariable Long id,
            @RequestBody Agendamento agendamento) {

        return agendamentoService.atualizar(id, agendamento);
    }
}