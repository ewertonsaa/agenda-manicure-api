package com.agenda.agendamanicure.repository;

import com.agenda.agendamanicure.entity.Agendamento;
import org.springframework.data.jpa.repository.JpaRepository;
import com.agenda.agendamanicure.StatusAgendamento;
import java.time.LocalDate;
import java.time.LocalTime;

public interface AgendamentoRepository extends JpaRepository<Agendamento, Long> {

    boolean existsByProfissional_IdAndDataAndHorarioAndStatusNot(
            Long profissionalId,
            LocalDate data,
            LocalTime horario,
            StatusAgendamento status
    );

    boolean existsByCliente_Id(Long clienteId);
    boolean existsByProfissional_Id(Long profissionalId);
    boolean existsByServico_Id(Long servicoId);
    boolean existsByProfissional_IdAndDataAndHorarioAndStatusNotAndIdNot(
            Long profissionalId,
            LocalDate data,
            LocalTime horario,
            StatusAgendamento status,
            Long id
    );
}