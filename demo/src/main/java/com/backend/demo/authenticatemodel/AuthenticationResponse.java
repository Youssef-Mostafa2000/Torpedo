package com.backend.demo.authenticatemodel;

public class AuthenticationResponse {

	private String message;
	private String jwt;

	public AuthenticationResponse(String message, String jwt) {
		this.jwt = jwt;
		this.message = message;
	}



	public AuthenticationResponse(String message) {
		this.message = message;
	}

	public String getJwt() {
		return jwt;
	}

	public void setJwt(String jwt) {
		this.jwt = jwt;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
}
