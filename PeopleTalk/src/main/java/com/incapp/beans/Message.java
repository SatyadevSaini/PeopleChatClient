package com.incapp.beans;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Component;

@Component
public class Message {
	private int id;
	private String sEmail,rEmail,message,fileName;
	private LocalDate udate;
	private String utime;
	
	
	public Message() {
		udate=LocalDate.now();
		utime = LocalTime.now().format(DateTimeFormatter.ofPattern("hh:mm a"));
	}
	
	public java.time.LocalDate getUdate() {
		return udate;
	}

	public void setUdate(java.time.LocalDate udate) {
		this.udate = udate;
	}

	public String getUtime() {
		return utime;
	}
	public void setUtime(String utime) {
		this.utime = utime;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getsEmail() {
		return sEmail;
	}
	public void setsEmail(String sEmail) {
		this.sEmail = sEmail;
	}
	public String getrEmail() {
		return rEmail;
	}
	public void setrEmail(String rEmail) {
		this.rEmail = rEmail;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
}
