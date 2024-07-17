package com.digicode.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.*;

@Entity
@Table(name = "tickets")
public class TicketsModel implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "ticket_name")
    private String ticketName;

    @Column(name = "ticket_description")
    private String ticketDescription;

    @Column(name = "created_by")
    private String createdBy;

    @Column(name = "created_at")
    private Date createdAt;

    @Column(name = "updated_by")
    private String updatedBy;

    @Column(name = "updated_at")
    private Date updatedAt;

    @Column(name = "severity")
    private String severity;

    @Column(name = "remark")
    private String remark;

    @Column(name = "status")
    private String status;

    @Column(name = "manager")
    private String manager;

    @Column(name = "Due_Date")
    private Date dueDate;

    @Column(name = "CompletedAt")
    private Date completedAt;

    @Column(name = "check_read", columnDefinition = "boolean default false")
    private Boolean checkRead = false;

    // One-to-many relationship with TicketLogs
    @OneToMany(mappedBy = "ticket", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<TicketLogs> ticketLogs = new ArrayList<>();


   
    
    public List<TicketLogs> getTicketLogs() {
		return ticketLogs;
	}

	public void setTicketLogs(List<TicketLogs> ticketLogs) {
		this.ticketLogs = ticketLogs;
	}

	public EmployeeModel getEmployeeId() {
		return userId;
	}

	public void setEmployeeId(EmployeeModel userId) {
		this.userId = userId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id")
    private EmployeeModel userId;


    // Getters and Setters
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTicketName() {
        return ticketName;
    }

    public void setTicketName(String ticketName) {
        this.ticketName = ticketName;
    }

    public String getTicketDescription() {
        return ticketDescription;
    }

    public void setTicketDescription(String ticketDescription) {
        this.ticketDescription = ticketDescription;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

  

    public String getSeverity() {
        return severity;
    }

    public void setSeverity(String severity) {
        this.severity = severity;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }
    
    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public Date getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(Date completedAt) {
        this.completedAt = completedAt;
    }

    public Boolean getCheckRead() {
        return checkRead;
    }

    public void setCheckRead(Boolean checkRead) {
        this.checkRead = checkRead;
    }
    
    public List<TicketLogs> getTicketLogList() {
        return ticketLogs;
    }

    public void setTicketLogList(List<TicketLogs> ticketLogList) {
        this.ticketLogs = ticketLogList;
    }

   
}