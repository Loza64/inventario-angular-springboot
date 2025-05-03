package com.server.inventory.controller;

import com.server.inventory.dto.Message;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.io.SerializationException;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.SQLException;

@ControllerAdvice
public class Advice {

    @ExceptionHandler(SQLException.class)
    @ResponseBody
    public ResponseEntity<Message> handleSqlException(SQLException ex) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new Message(false, ex.getMessage()));
    }

    @ExceptionHandler(DataAccessException.class)
    @ResponseBody
    public ResponseEntity<Message> handleDataAccessException(DataAccessException ex) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new Message(false, ex.getMessage()));
    }

    @ExceptionHandler(JwtException.class)
    public ResponseEntity<Message> handleJwtException(JwtException ex) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new Message(false, ex.getMessage()));
    }

    @ExceptionHandler(SerializationException.class)
    public ResponseEntity<Message> handleException(SerializationException ex) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new Message(false, ex.getMessage()));
    }

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public ResponseEntity<Message> handleException(Exception ex) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new Message(false, ex.getMessage()));
    }

}