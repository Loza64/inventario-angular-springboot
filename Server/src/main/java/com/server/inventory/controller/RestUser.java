package com.server.inventory.controller;

import com.server.inventory.config.JwtConfig;
import com.server.inventory.dto.*;
import com.server.inventory.service.interfaces.ImageServices;
import com.server.inventory.service.interfaces.UserServices;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;

@RestController
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
@RequestMapping(path = "server/inventory/json/api/rest", produces = "application/json")
public class RestUser {

    private final UserServices service;
    private final JwtConfig jwt;
    private final ImageServices imageServices;

    private ResponseEntity<Object> buildResponse(int status, String message, Object data) {
        boolean state = status >= 200 && status <= 299;
        Map<String, Object> response = new LinkedHashMap<>();
        response.put("state", state);
        response.put("message", message);
        if (data != null) {
            response.put("result", data);
        }
        return ResponseEntity.status(status).body(response);
    }

    private LinkedHashMap<?, ?> userSession(HttpSession session) {
        return (LinkedHashMap<?, ?>) session.getAttribute("user");
    }

    @PostMapping(path = "/signup")
    private ResponseEntity<Object> signUp(@Validated @RequestBody SignUp body) {
        return service.signUp(body)
                .map(user -> buildResponse(HttpStatus.CREATED.value(), "Sign Up Successful", null))
                .orElse(buildResponse(HttpStatus.CONFLICT.value(), "Sign Up Error", null));
    }

    @PostMapping(path = "/login")
    private ResponseEntity<Object> login(HttpSession session, @Validated @RequestBody Login body) {
        return service.login(body.getUsername(), body.getPassword())
                .map(user -> {
                    if (!user.getState()) {
                        return buildResponse(HttpStatus.FORBIDDEN.value(), "You are locked", null);
                    }
                    String token = jwt.createToken(user);
                    session.setAttribute("user", user);
                    return buildResponse(HttpStatus.OK.value(), "Login success", token);
                })
                .orElse(buildResponse(HttpStatus.FORBIDDEN.value(), "Invalid username or password", null));
    }

    @GetMapping(path = "/token/{token}")
    private ResponseEntity<Object> verifyToken(@PathVariable String token) {
        return jwt.isTokenExpired(token)
                ? buildResponse(HttpStatus.UNAUTHORIZED.value(), "Invalid or expired token", null)
                : buildResponse(HttpStatus.OK.value(), "Token verified", null);
    }

    @PatchMapping("/profile/update/image")
    private ResponseEntity<Object> updateProfileImage(@RequestParam("image") MultipartFile image) throws IOException {
        Map<String,Object> data = imageServices.UploadImage(image);
        return buildResponse(HttpStatus.OK.value(), "Image uploaded", data);
    }

    @GetMapping(path = "/manage/list/users")
    private ResponseEntity<Object> getUsers() {
        return buildResponse(HttpStatus.OK.value(), "list users", service.getUsers());
    }

    @GetMapping(path = "/profile")
    private ResponseEntity<Object> getProfile(HttpSession session) {
        var profile = userSession(session);

        if (profile == null) {
            return buildResponse(HttpStatus.UNAUTHORIZED.value(), "You are not logged in", null);
        }

        return buildResponse(HttpStatus.OK.value(), "Profile", profile);
    }
}