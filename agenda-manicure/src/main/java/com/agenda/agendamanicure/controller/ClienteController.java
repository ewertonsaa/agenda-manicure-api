package com.agenda.agendamanicure.controller;

import com.agenda.agendamanicure.entity.Cliente;
import com.agenda.agendamanicure.service.ClienteService;
import org.springframework.web.bind.annotation.*;
import com.agenda.agendamanicure.dto.ClienteRequest;

import java.util.List;

@RestController
@RequestMapping("/clientes")
public class ClienteController {

    private final ClienteService clienteService;

    public ClienteController(ClienteService clienteService) {
        this.clienteService = clienteService;

    }

    @PostMapping
    public Cliente cadastrar(@RequestBody ClienteRequest request) {

        Cliente cliente = new Cliente();

        cliente.setNome(request.getNome());
        cliente.setTelefone(request.getTelefone());

        return clienteService.cadastrar(cliente);
    }

    @GetMapping
    public List<Cliente> listar() {
        return clienteService.lista();
    }

    @GetMapping("/{id}")
    public Cliente buscarPorId(@PathVariable Long id) {
        return clienteService.buscarPorId(id);
    }

    @PutMapping("/{id}")
    public Cliente atualizar(
            @PathVariable Long id,
            @RequestBody Cliente cliente) {

        return clienteService.atualizar(id, cliente);
    }

    @DeleteMapping("/{id}")
    public void excluir(@PathVariable Long id) {
        clienteService.excluir(id);
    }
}