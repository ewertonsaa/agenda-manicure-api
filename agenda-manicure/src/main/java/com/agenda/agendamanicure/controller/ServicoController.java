package com.agenda.agendamanicure.controller;

import com.agenda.agendamanicure.entity.Servico;
import com.agenda.agendamanicure.service.ServicoService;
import org.springframework.web.bind.annotation.*;
import com.agenda.agendamanicure.dto.ServicoRequest;

import java.util.List;

@RestController
@RequestMapping("/servicos")
public class ServicoController {

    private final ServicoService servicoService;

    public ServicoController(ServicoService servicoService) {
        this.servicoService = servicoService;
    }

    @PostMapping
    public Servico cadastrar(@RequestBody ServicoRequest request) {

        Servico servico = new Servico();

        servico.setNome(request.getNome());
        servico.setPreco(request.getPreco());
        servico.setDuracaoMinutos(request.getDuracaoMinutos());

        return servicoService.cadastrar(servico);
    }

    @GetMapping
    public List<Servico> listar() {
        return servicoService.listar();
    }

    @GetMapping("/{id}")
    public Servico buscarPorId(@PathVariable Long id) {
        return servicoService.buscarPorId(id);
    }

    @PutMapping("/{id}")
    public Servico atualizar(
            @PathVariable Long id,
            @RequestBody Servico servico) {

        return servicoService.atualizar(id, servico);
    }

    @DeleteMapping("/{id}")
    public void excluir(@PathVariable Long id) {
        servicoService.excluir(id);
    }
}