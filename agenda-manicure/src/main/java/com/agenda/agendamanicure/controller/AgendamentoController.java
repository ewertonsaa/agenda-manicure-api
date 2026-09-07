package com.agenda.agendamanicure.controller;

import com.agenda.agendamanicure.entity.Agendamento;
import com.agenda.agendamanicure.repository.AgendamentoRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/agendamentos")
public class AgendamentoController {

    private final AgendamentoRepository agendamentoRepository;

    public AgendamentoController(AgendamentoRepository agendamentoRepository) {
        this.agendamentoRepository = agendamentoRepository;
    }

    @GetMapping
    public List<Agendamento> listar() {
        return agendamentoRepository.findAll();
    }

    @PostMapping
    public Agendamento criar(@RequestBody Agendamento agendamento) {
        boolean horarioOcupado =
                agendamentoRepository.existsByProfissional_IdAndDataAndHorarioAndStatusNot(
                        agendamento.getProfissional().getId(),
                        agendamento.getData(),
                        agendamento.getHorario(),
                        "CANCELADO"
                );

        if (horarioOcupado) {
            throw new RuntimeException("Horário já está ocupado para esta profissional.");
        }
        return agendamentoRepository.save(agendamento);
    }

    @GetMapping("/{id}")
    public Agendamento buscarPorId(@PathVariable Long id) {
        return agendamentoRepository.findById(id).orElse(null);
    }

    @PutMapping("/{id}/cancelar")
    public Agendamento cancelar(@PathVariable Long id) {

        Agendamento agendamento = agendamentoRepository.findById(id)
                .orElse(null);

        if (agendamento == null) {
            return null;
        }

        agendamento.setStatus("CANCELADO");

        return agendamentoRepository.save(agendamento);
    }

    @DeleteMapping("/{id}")
    public void excluir(@PathVariable Long id) {
        agendamentoRepository.deleteById(id);
    }

    @PutMapping("/{id}")
    public Agendamento atualizar(
            @PathVariable Long id,
            @RequestBody Agendamento agendamento) {

        agendamento.setId(id);

        return agendamentoRepository.save(agendamento);
    }
}