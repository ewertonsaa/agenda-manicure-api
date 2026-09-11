package com.agenda.agendamanicure.exception;

public class ServicoNotFoundException extends RuntimeException {

    public ServicoNotFoundException(String mensagem) {
        super(mensagem);
    }
}