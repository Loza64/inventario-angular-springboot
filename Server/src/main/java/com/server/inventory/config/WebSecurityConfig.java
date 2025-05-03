package com.server.inventory.config;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.server.inventory.dto.Message;
import com.server.inventory.filter.Authentication;
import org.springframework.boot.actuate.session.SessionsEndpoint;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.HttpStatus;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig {

    private final Authentication jwtFilter;

    /*
     * Basic mode
     * public InMemoryUserDetailsManager inMemoryUserDetailsManager(PasswordEncoder
     * encoder){
     * UserDetails user = User.withUsername("")
     * .password(encoder.encode(""))
     * .roles("ADMIN").build();
     * return new InMemoryUserDetailsManager(user,...);
     */

    public WebSecurityConfig(@Lazy Authentication jwtFilter){
        this.jwtFilter = jwtFilter;
    }

    private String ErrorResponse(String message) throws JsonProcessingException {
        return new ObjectMapper().writeValueAsString(new Message(false, message));
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, SessionsEndpoint sessionEndpoint) throws Exception {
        return http
                .headers(configurer -> {
                    configurer.contentSecurityPolicy(contentSecurityPolicyConfig -> {
                        contentSecurityPolicyConfig.policyDirectives("default-src 'self'; script-src 'self';");
                    });
                    configurer.httpStrictTransportSecurity(hstsConfig -> {
                        hstsConfig.maxAgeInSeconds(31536000);
                        hstsConfig.includeSubDomains(true);
                    });
                    configurer.xssProtection(HeadersConfigurer.XXssConfig::disable);
                    configurer.frameOptions(HeadersConfigurer.FrameOptionsConfig::deny);
                })
                .cors(Customizer.withDefaults())
                .csrf(AbstractHttpConfigurer::disable)
                .httpBasic(Customizer.withDefaults())
                .sessionManagement(session ->{
                     session.sessionCreationPolicy(SessionCreationPolicy.STATELESS);
                     session.init(http);
                })
                .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class)
                .authorizeHttpRequests(req -> req
                        .requestMatchers("server/inventory/json/api/rest/login").permitAll()
                        .requestMatchers("server/inventory/json/api/rest/signup").permitAll()
                        .requestMatchers("server/inventory/json/api/rest/token/**").permitAll()
                        .requestMatchers("server/inventory/json/api/rest/admin/**").hasRole("ADMIN")
                        .requestMatchers("server/inventory/json/api/rest/manage/**").hasAnyRole("ADMIN", "PROVIDER")
                        .requestMatchers("server/inventory/json/api/rest/profile/update/image").hasAnyRole("ADMIN", "PROVIDER", "NORMAL")
                        .requestMatchers("server/inventory/json/api/rest/profile").hasAnyRole("ADMIN", "PROVIDER", "NORMAL")
                        .anyRequest().authenticated()
                )
                .exceptionHandling(
                        configure -> {
                            configure.accessDeniedHandler((req, res, exception) -> {
                                res.setStatus(HttpStatus.FORBIDDEN.value());
                                res.setContentType("application/json");
                                res.getWriter().write(ErrorResponse(exception.getMessage()));
                            });
                            configure.authenticationEntryPoint((req, res, exception) -> {
                                res.setStatus(HttpStatus.UNAUTHORIZED.value());
                                res.setContentType("application/json");
                                res.getWriter().write(ErrorResponse(exception.getMessage()));
                            });
                        }
                ).build();
    }
}
