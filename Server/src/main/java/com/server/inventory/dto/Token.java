package com.server.inventory.dto;

import lombok.Getter;

@Getter
public class Token {

    private final boolean state;

    private final String message;

    private final String token;

    public Token(boolean state, String message, String token) {
        this.state = state;
        this.message = message;
        this.token = token;
    }
}
