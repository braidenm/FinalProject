package com.skilldistillery.doggyTinder.entities;

import java.util.Date;

import javax.print.attribute.standard.DateTimeAtCreation;

public class Message {

	private Integer id;
	private Integer senderId;
	private Integer receiverId;
	private String text;
	private DateTimeAtCreation date;
}
