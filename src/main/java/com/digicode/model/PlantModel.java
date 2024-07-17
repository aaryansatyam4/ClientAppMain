package com.digicode.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "plant")
public class PlantModel implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	private String plantName;
	private String plantAddress;
	private String plantCity;
	private String plantHead;
	private Date plantStartDate;
	private String plantStatus;

	public String getPlantStatus() {
		return plantStatus;
	}

	public void setPlantStatus(String plantStatus) {
		this.plantStatus = plantStatus;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPlantName() {
		return plantName;
	}

	public void setPlantName(String plantName) {
		this.plantName = plantName;
	}

	public String getPlantAddress() {
		return plantAddress;
	}

	public void setPlantAddress(String plantAddress) {
		this.plantAddress = plantAddress;
	}

	public String getPlantCity() {
		return plantCity;
	}

	public void setPlantCity(String plantCity) {
		this.plantCity = plantCity;
	}

	public String getPlantHead() {
		return plantHead;
	}

	public void setPlantHead(String plantHead) {
		this.plantHead = plantHead;
	}

	public Date getPlantStartDate() {
		return plantStartDate;
	}

	public void setPlantStartDate(Date plantStartDate) {
		this.plantStartDate = plantStartDate;
	}

}
