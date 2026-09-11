package com.agenda.agendamanicure.service;

import com.agenda.agendamanicure.entity.Servico;
import com.agenda.agendamanicure.repository.ServicoRepository;
import org.springframework.stereotype.Service;
import com.agenda.agendamanicure.exception.ServicoNotFoundException;
import com.agenda.agendamanicure.exception.ServicoComAgendamentoException;
import com.agenda.agendamanicure.repository.AgendamentoRepository;

import java.util.List;

@Service
public class ServicoService {

    private final ServicoRepository servicoRepository;
    private final AgendamentoRepository agendamentoRepository;

    public ServicoService(
            ServicoRepository servicoRepository,
            AgendamentoRepository agendamentoRepository) {

        this.servicoRepository = servicoRepository;
        this.agendamentoRepository = agendamentoRepository;
    }

    public Servico cadastrar(Servico servico) {
        return servicoRepository.save(servico);
    }

    public List<Servico> listar() {
        return servicoRepository.findAll();
    }

    public Servico buscarPorId(Long id) {
        return servicoRepository.findById(id)
                .orElseThrow(() -> new ServicoNotFoundException("Serviço não encontrado"));
    }

    public Servico atualizar(Long id, Servico servico) {

        Servico servicoExistente = servicoRepository.findById(id)
                .orElseThrow(() -> new ServicoNotFoundException("Serviço não encontrado"));

        servicoExistente.setNome(servico.getNome());
        servicoExistente.setPreco(servico.getPreco());
        servicoExistente.setDuracaoMinutos(servico.getDuracaoMinutos());

        return servicoRepository.save(servicoExistente);
    }

    public void excluir(Long id) {

        Servico servico = servicoRepository.findById(id)
                .orElseThrow(() -> new ServicoNotFoundException("Serviço não encontrado"));

        if (agendamentoRepository.existsByServico_Id(id)) {
            throw new ServicoComAgendamentoException(
                    "Não é possível excluir o serviço porque existem agendamentos vinculados."
            );
        }

        servicoRepository.delete(servico);
    }
}