package com.agenda.agendamanicure.service;

import com.agenda.agendamanicure.entity.Profissional;
import com.agenda.agendamanicure.repository.ProfissionalRepository;
import org.springframework.stereotype.Service;
import com.agenda.agendamanicure.exception.ProfissionalComAgendamentoException;
import com.agenda.agendamanicure.repository.AgendamentoRepository;
import com.agenda.agendamanicure.exception.ProfissionalNotFoundException;

import java.util.List;

@Service
public class ProfissionalService {

    private final ProfissionalRepository profissionalRepository;
    private final AgendamentoRepository agendamentoRepository;

    public ProfissionalService(
            ProfissionalRepository profissionalRepository,
            AgendamentoRepository agendamentoRepository) {

        this.profissionalRepository = profissionalRepository;
        this.agendamentoRepository = agendamentoRepository;
    }

    public Profissional cadastrar(Profissional profissional) {
        return profissionalRepository.save(profissional);
    }

    public List<Profissional> listar() {
        return profissionalRepository.findAll();
    }

    public Profissional buscarPorId(Long id) {
        return profissionalRepository.findById(id)
                .orElseThrow(() -> new ProfissionalNotFoundException("Profissional não encontrado"));
    }

    public Profissional atualizar(Long id, Profissional profissional) {

        Profissional profissionalExistente = profissionalRepository.findById(id)
                .orElseThrow(() -> new ProfissionalNotFoundException("Profissional não encontrado"));

        profissionalExistente.setNome(profissional.getNome());
        profissionalExistente.setTelefone(profissional.getTelefone());

        return profissionalRepository.save(profissionalExistente);
    }

    public void excluir(Long id) {

        Profissional profissional = profissionalRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Profissional não encontrado"));

        if (agendamentoRepository.existsByProfissional_Id(id)) {
            throw new ProfissionalComAgendamentoException(
                    "Não é possível excluir a profissional porque existem agendamentos vinculados."
            );
        }

        profissionalRepository.delete(profissional);
    }
}