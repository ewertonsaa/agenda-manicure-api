package com.agenda.agendamanicure.service;

import com.agenda.agendamanicure.StatusAgendamento;
import com.agenda.agendamanicure.dto.AgendamentoRequest;
import com.agenda.agendamanicure.entity.Agendamento;
import com.agenda.agendamanicure.entity.Cliente;
import com.agenda.agendamanicure.entity.Profissional;
import com.agenda.agendamanicure.entity.Servico;
import com.agenda.agendamanicure.exception.AgendamentoNotFoundException;
import com.agenda.agendamanicure.exception.ClienteNotFoundException;
import com.agenda.agendamanicure.exception.DataAgendamentoInvalidaException;
import com.agenda.agendamanicure.exception.HorarioAgendamentoInvalidoException;
import com.agenda.agendamanicure.exception.HorarioForaDoFuncionamentoException;
import com.agenda.agendamanicure.exception.HorarioOcupadoException;
import com.agenda.agendamanicure.exception.ProfissionalNotFoundException;
import com.agenda.agendamanicure.exception.ServicoNotFoundException;
import com.agenda.agendamanicure.exception.StatusAgendamentoInvalidoException;
import com.agenda.agendamanicure.repository.AgendamentoRepository;
import com.agenda.agendamanicure.repository.ClienteRepository;
import com.agenda.agendamanicure.repository.ProfissionalRepository;
import com.agenda.agendamanicure.repository.ServicoRepository;
import com.agenda.agendamanicure.dto.AgendamentoResponse;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Service
public class AgendamentoService {

    private final AgendamentoRepository agendamentoRepository;
    private final ClienteRepository clienteRepository;
    private final ProfissionalRepository profissionalRepository;
    private final ServicoRepository servicoRepository;

    public AgendamentoService(
            AgendamentoRepository agendamentoRepository,
            ClienteRepository clienteRepository,
            ProfissionalRepository profissionalRepository,
            ServicoRepository servicoRepository) {

        this.agendamentoRepository = agendamentoRepository;
        this.clienteRepository = clienteRepository;
        this.profissionalRepository = profissionalRepository;
        this.servicoRepository = servicoRepository;
    }

    // =========================
    // LISTAR
    // =========================

    public List<Agendamento> listar() {
        return agendamentoRepository.findAll();
    }

    // =========================
    // CRIAR
    // =========================

    public AgendamentoResponse criar(AgendamentoRequest request) {

        if (request.getData() == null) {
            throw new DataAgendamentoInvalidaException(
                    "A data do agendamento é obrigatória."
            );
        }

        if (request.getHorario() == null) {
            throw new HorarioAgendamentoInvalidoException(
                    "O horário do agendamento é obrigatório."
            );
        }

        LocalTime inicioFuncionamento = LocalTime.of(8, 0);
        LocalTime fimFuncionamento = LocalTime.of(19, 0);

        if (request.getHorario().isBefore(inicioFuncionamento)
                || request.getHorario().isAfter(fimFuncionamento)) {

            throw new HorarioForaDoFuncionamentoException(
                    "O horário deve estar entre 08:00 e 19:00."
            );
        }

        if (request.getData().isBefore(LocalDate.now())) {
            throw new DataAgendamentoInvalidaException(
                    "Não é possível criar um agendamento com data passada."
            );
        }

        if (request.getData().isEqual(LocalDate.now())
                && request.getHorario().isBefore(LocalTime.now())) {

            throw new DataAgendamentoInvalidaException(
                    "Não é possível criar um agendamento para um horário que já passou."
            );
        }

        StatusAgendamento status = request.getStatus();

        if (status == null) {
            status = StatusAgendamento.AGENDADO;
        }

        if (status != StatusAgendamento.AGENDADO) {
            throw new StatusAgendamentoInvalidoException(
                    "Um novo agendamento deve ter o status AGENDADO."
            );
        }

        if (request.getClienteId() == null) {
            throw new ClienteNotFoundException(
                    "Cliente é obrigatório."
            );
        }

        if (request.getProfissionalId() == null) {
            throw new ProfissionalNotFoundException(
                    "Profissional é obrigatório."
            );
        }

        if (request.getServicoId() == null) {
            throw new ServicoNotFoundException(
                    "Serviço é obrigatório."
            );
        }

        Cliente cliente = clienteRepository.findById(request.getClienteId())
                .orElseThrow(() ->
                        new ClienteNotFoundException("Cliente não encontrado"));

        Profissional profissional = profissionalRepository.findById(request.getProfissionalId())
                .orElseThrow(() ->
                        new ProfissionalNotFoundException("Profissional não encontrado"));

        Servico servico = servicoRepository.findById(request.getServicoId())
                .orElseThrow(() ->
                        new ServicoNotFoundException("Serviço não encontrado"));

        boolean horarioOcupado =
                agendamentoRepository.existsByProfissional_IdAndDataAndHorarioAndStatusNot(
                        profissional.getId(),
                        request.getData(),
                        request.getHorario(),
                        StatusAgendamento.CANCELADO
                );

        if (horarioOcupado) {
            throw new HorarioOcupadoException(
                    "Horário já está ocupado para esta profissional."
            );
        }

        Agendamento agendamento = new Agendamento();

        agendamento.setData(request.getData());
        agendamento.setHorario(request.getHorario());
        agendamento.setStatus(status);
        agendamento.setCliente(cliente);
        agendamento.setProfissional(profissional);
        agendamento.setServico(servico);

        return converterParaResponse(
                agendamentoRepository.save(agendamento)
        );
    }

    // =========================
    // BUSCAR POR ID
    // =========================

    public Agendamento buscarPorId(Long id) {

        return agendamentoRepository.findById(id)
                .orElseThrow(() ->
                        new AgendamentoNotFoundException(
                                "Agendamento não encontrado"
                        ));
    }

    // =========================
    // CANCELAR
    // =========================

    public Agendamento cancelar(Long id) {

        Agendamento agendamento = agendamentoRepository.findById(id)
                .orElseThrow(() ->
                        new AgendamentoNotFoundException(
                                "Agendamento não encontrado"
                        ));

        if (agendamento.getStatus() == StatusAgendamento.CANCELADO) {
            throw new StatusAgendamentoInvalidoException(
                    "O agendamento já está CANCELADO."
            );
        }

        if (agendamento.getStatus() == StatusAgendamento.CONCLUIDO) {
            throw new StatusAgendamentoInvalidoException(
                    "Um agendamento CONCLUIDO não pode ser cancelado."
            );
        }

        agendamento.setStatus(StatusAgendamento.CANCELADO);

        return agendamentoRepository.save(agendamento);
    }

    // =========================
    // EXCLUIR
    // =========================

    public void excluir(Long id) {

        Agendamento agendamento = agendamentoRepository.findById(id)
                .orElseThrow(() ->
                        new AgendamentoNotFoundException(
                                "Agendamento não encontrado"
                        ));

        agendamentoRepository.delete(agendamento);
    }

    // =========================
    // ATUALIZAR
    // =========================

    public Agendamento atualizar(Long id, Agendamento agendamento) {

        if (agendamento.getData() == null) {
            throw new DataAgendamentoInvalidaException(
                    "A data do agendamento é obrigatória."
            );
        }

        if (agendamento.getHorario() == null) {
            throw new HorarioAgendamentoInvalidoException(
                    "O horário do agendamento é obrigatório."
            );
        }

        LocalTime inicioFuncionamento = LocalTime.of(8, 0);
        LocalTime fimFuncionamento = LocalTime.of(19, 0);

        if (agendamento.getHorario().isBefore(inicioFuncionamento)
                || agendamento.getHorario().isAfter(fimFuncionamento)) {

            throw new HorarioForaDoFuncionamentoException(
                    "O horário deve estar entre 08:00 e 19:00."
            );
        }

        if (agendamento.getData().isBefore(LocalDate.now())) {
            throw new DataAgendamentoInvalidaException(
                    "Não é possível atualizar um agendamento para uma data passada."
            );
        }

        if (agendamento.getData().isEqual(LocalDate.now())
                && agendamento.getHorario().isBefore(LocalTime.now())) {

            throw new DataAgendamentoInvalidaException(
                    "Não é possível atualizar um agendamento para um horário que já passou."
            );
        }

        Agendamento agendamentoExistente = agendamentoRepository.findById(id)
                .orElseThrow(() ->
                        new AgendamentoNotFoundException(
                                "Agendamento não encontrado"
                        ));

        if (agendamento.getStatus() == null) {
            agendamento.setStatus(agendamentoExistente.getStatus());
        }

        if (agendamentoExistente.getStatus() == StatusAgendamento.CANCELADO
                && agendamento.getStatus() != StatusAgendamento.CANCELADO) {

            throw new StatusAgendamentoInvalidoException(
                    "Um agendamento CANCELADO não pode voltar para AGENDADO."
            );
        }

        if (agendamentoExistente.getStatus() == StatusAgendamento.CONCLUIDO
                && agendamento.getStatus() != StatusAgendamento.CONCLUIDO) {

            throw new StatusAgendamentoInvalidoException(
                    "Um agendamento CONCLUIDO não pode voltar para AGENDADO."
            );
        }

        if (agendamento.getCliente() == null
                || agendamento.getCliente().getId() == null) {

            throw new ClienteNotFoundException(
                    "Cliente é obrigatório."
            );
        }

        if (agendamento.getProfissional() == null
                || agendamento.getProfissional().getId() == null) {

            throw new ProfissionalNotFoundException(
                    "Profissional é obrigatório."
            );
        }

        if (agendamento.getServico() == null
                || agendamento.getServico().getId() == null) {

            throw new ServicoNotFoundException(
                    "Serviço é obrigatório."
            );
        }

        Cliente cliente = clienteRepository.findById(
                agendamento.getCliente().getId()
        ).orElseThrow(() ->
                new ClienteNotFoundException("Cliente não encontrado"));

        Profissional profissional = profissionalRepository.findById(
                agendamento.getProfissional().getId()
        ).orElseThrow(() ->
                new ProfissionalNotFoundException("Profissional não encontrado"));

        Servico servico = servicoRepository.findById(
                agendamento.getServico().getId()
        ).orElseThrow(() ->
                new ServicoNotFoundException("Serviço não encontrado"));

        boolean horarioOcupado =
                agendamentoRepository.existsByProfissional_IdAndDataAndHorarioAndStatusNotAndIdNot(
                        profissional.getId(),
                        agendamento.getData(),
                        agendamento.getHorario(),
                        StatusAgendamento.CANCELADO,
                        id
                );

        if (horarioOcupado) {
            throw new HorarioOcupadoException(
                    "Horário já está ocupado para esta profissional."
            );
        }

        agendamentoExistente.setData(agendamento.getData());
        agendamentoExistente.setHorario(agendamento.getHorario());
        agendamentoExistente.setStatus(agendamento.getStatus());
        agendamentoExistente.setCliente(cliente);
        agendamentoExistente.setProfissional(profissional);
        agendamentoExistente.setServico(servico);

        return agendamentoRepository.save(agendamentoExistente);
    }

    private AgendamentoResponse converterParaResponse(Agendamento agendamento) {

        AgendamentoResponse response = new AgendamentoResponse();

        response.setId(agendamento.getId());
        response.setData(agendamento.getData());
        response.setHorario(agendamento.getHorario());
        response.setStatus(agendamento.getStatus());

        response.setClienteId(agendamento.getCliente().getId());
        response.setProfissionalId(agendamento.getProfissional().getId());
        response.setServicoId(agendamento.getServico().getId());

        return response;
    }
}