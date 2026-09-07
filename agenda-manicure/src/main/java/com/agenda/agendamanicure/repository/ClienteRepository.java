package com.agenda.agendamanicure.repository;

import com.agenda.agendamanicure.entity.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClienteRepository extends JpaRepository<Cliente, Long> {
}