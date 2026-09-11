package com.agenda.agendamanicure.exception;

public class ClienteNotFoundException extends RuntimeException {

    public ClienteNotFoundException(String mensagem) {
        super(mensagem);
    }
}