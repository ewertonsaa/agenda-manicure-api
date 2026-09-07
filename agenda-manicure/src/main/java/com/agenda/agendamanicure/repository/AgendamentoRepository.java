package com.agenda.agendamanicure.repository;

import com.agenda.agendamanicure.entity.Agendamento;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.time.LocalTime;

public interface AgendamentoRepository extends JpaRepository<Agendamento, Long> {

    boolean existsByProfissional_IdAndDataAndHorarioAndStatusNot(
            Long profissionalId,
            LocalDate data,
            LocalTime horario,
            String status
    );
}