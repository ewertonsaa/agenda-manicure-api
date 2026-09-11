package com.agenda.agendamanicure.service;

import com.agenda.agendamanicure.repository.AgendamentoRepository;
import com.agenda.agendamanicure.entity.Cliente;
import com.agenda.agendamanicure.exception.ClienteNotFoundException;
import com.agenda.agendamanicure.repository.ClienteRepository;
import org.springframework.stereotype.Service;
import com.agenda.agendamanicure.exception.ClienteNotFoundException;
import com.agenda.agendamanicure.exception.ClienteComAgendamentoException;

import java.util.List;

@Service
public class ClienteService {

    private final ClienteRepository clienteRepository;
    private final AgendamentoRepository agendamentoRepository;

    public ClienteService(
            ClienteRepository clienteRepository,
            AgendamentoRepository agendamentoRepository) {

        this.clienteRepository = clienteRepository;
        this.agendamentoRepository = agendamentoRepository;
    }

    public Cliente cadastrar(Cliente cliente) {
        return clienteRepository.save(cliente);
    }

    public List<Cliente> lista() {
        return clienteRepository.findAll();
    }

    public Cliente buscarPorId(Long id) {
        return clienteRepository.findById(id)
                .orElseThrow(() -> new ClienteNotFoundException("Cliente não encontrado"));
    }

    public Cliente atualizar(Long id, Cliente cliente) {

        Cliente clienteExistente = clienteRepository.findById(id)
                .orElseThrow(() -> new ClienteNotFoundException("Cliente não encontrado"));

        clienteExistente.setNome(cliente.getNome());
        clienteExistente.setTelefone(cliente.getTelefone());

        return clienteRepository.save(clienteExistente);

    }

    public void excluir(Long id) {

        Cliente cliente = clienteRepository.findById(id)
                .orElseThrow(() -> new ClienteNotFoundException("Cliente não encontrado"));

        if (agendamentoRepository.existsByCliente_Id(id)) {
            throw new ClienteComAgendamentoException(
                    "Não é possível excluir o cliente porque existem agendamentos vinculados."
            );
        }

        clienteRepository.delete(cliente);
    }
}