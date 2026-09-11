package com.agenda.agendamanicure.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import com.agenda.agendamanicure.exception.ClienteComAgendamentoException;
import com.agenda.agendamanicure.exception.ProfissionalComAgendamentoException;
import com.agenda.agendamanicure.exception.ProfissionalNotFoundException;
import com.agenda.agendamanicure.exception.ServicoNotFoundException;
import com.agenda.agendamanicure.exception.ServicoComAgendamentoException;
import com.agenda.agendamanicure.exception.DataAgendamentoInvalidaException;
import com.agenda.agendamanicure.exception.HorarioAgendamentoInvalidoException;

import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ClienteNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public Map<String, String> tratarClienteNaoEncontrado(
            ClienteNotFoundException exception) {

        return Map.of(
                "erro", exception.getMessage()
        );
    }

    @ExceptionHandler(ProfissionalComAgendamentoException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public Map<String, String> tratarProfissionalComAgendamento(
            ProfissionalComAgendamentoException exception) {

        return Map.of(
                "erro", exception.getMessage()
        );
    }

    @ExceptionHandler(ClienteComAgendamentoException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public Map<String, String> tratarClienteComAgendamento(
            ClienteComAgendamentoException exception) {

        return Map.of(
                "erro", exception.getMessage()
        );
    }

    @ExceptionHandler(ProfissionalNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public Map<String, String> tratarProfissionalNaoEncontrado(
            ProfissionalNotFoundException exception) {

        return Map.of(
                "erro", exception.getMessage()
        );
    }

    @ExceptionHandler(ServicoNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public Map<String, String> tratarServicoNaoEncontrado(
            ServicoNotFoundException exception) {

        return Map.of(
                "erro", exception.getMessage()
        );
    }

    @ExceptionHandler(ServicoComAgendamentoException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public Map<String, String> tratarServicoComAgendamento(
            ServicoComAgendamentoException exception) {

        return Map.of(
                "erro", exception.getMessage()
        );
    }

    @ExceptionHandler(AgendamentoNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public Map<String, String> tratarAgendamentoNaoEncontrado(
            AgendamentoNotFoundException exception) {

        return Map.of("erro", exception.getMessage());
    }

    @ExceptionHandler(HorarioOcupadoException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public Map<String, String> tratarHorarioOcupado(
            HorarioOcupadoException exception) {

        return Map.of("erro", exception.getMessage());
    }

    @ExceptionHandler(DataAgendamentoInvalidaException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, String> tratarDataAgendamentoInvalida(
            DataAgendamentoInvalidaException exception) {

        return Map.of("erro", exception.getMessage());
    }

    @ExceptionHandler(HorarioAgendamentoInvalidoException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, String> tratarHorarioAgendamentoInvalido(
            HorarioAgendamentoInvalidoException exception) {

        return Map.of("erro", exception.getMessage());
    }

    @ExceptionHandler(StatusAgendamentoInvalidoException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, String> tratarStatusAgendamentoInvalido(
            StatusAgendamentoInvalidoException exception) {

        return Map.of("erro", exception.getMessage());
    }

    @ExceptionHandler(HorarioForaDoFuncionamentoException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, String> tratarHorarioForaDoFuncionamento(
            HorarioForaDoFuncionamentoException exception) {

        return Map.of("erro", exception.getMessage());
    }

}