package com.server.inventory.dto;

import lombok.Getter;

@Getter
public class Message {

    private final Boolean state;
    private final String message;

    public Message(Boolean state, String message) {
        this.state = state;
        this.message = message;
    }
}
