package com.backend.demo.controller;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import com.backend.demo.authenticatemodel.AuthenticationRequest;
import com.backend.demo.authenticatemodel.AuthenticationResponse;
import com.backend.demo.jwtconfig.JwtUtil;
import com.backend.demo.service.BlackListedService;
import com.backend.demo.service.UserDetailsService;



@RestController
public class AuthenticationController {
	
	@Autowired
	private BlackListedService blackListedService;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/authenticate")
    public ResponseEntity<?> createAuthenticationToken(@RequestBody AuthenticationRequest authenticationRequest) throws Exception {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(authenticationRequest.getPhoneNumber(), authenticationRequest.getPassword()));
        } catch (BadCredentialsException e) {

            return new ResponseEntity(new AuthenticationResponse("Incorrect username or password", null),HttpStatus.NOT_FOUND);
        }

        final UserDetails userDetails = userDetailsService.loadUserByUsername(authenticationRequest.getPhoneNumber());
        final String jwt = jwtUtil.generateToken(userDetails);

        return ResponseEntity.ok(new AuthenticationResponse("success",jwt));
    }
    
    @PostMapping("/signout")
    public ResponseEntity<?> signOut(@RequestHeader("Authorization") String token) {
        if (token != null && token.startsWith("Bearer ")) {
            token = token.substring(7);
            Date expirationDate = jwtUtil.extractExpiration(token);
            blackListedService.blacklistToken(token, LocalDateTime.ofInstant(expirationDate.toInstant(), ZoneId.systemDefault()));
        }
        return new ResponseEntity(new AuthenticationResponse("Sign Out Successfully"),HttpStatus.OK);
    }
    

}
