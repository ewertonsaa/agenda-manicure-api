package com.agenda.agendamanicure.exception;

public class AgendamentoNotFoundException extends RuntimeException {

    public AgendamentoNotFoundException(String mensagem) {
        super(mensagem);
    }
}