package com.backend.demo.authenticatemodel;

import org.springframework.security.core.userdetails.UserDetails;

import com.backend.demo.entity.Customer;

public class AuthenticationResponse {

	private String message;
	private String jwt;
	private Customer myCustomer;

	public AuthenticationResponse(String message, String jwt,Customer myCustomer) {
		this.jwt = jwt;
		this.message = message;
		this.myCustomer=myCustomer;
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



	public Customer getMyCustomer() {
		return myCustomer;
	}



	public void setMyCustomer(Customer myCustomer) {
		this.myCustomer = myCustomer;
	}




}
