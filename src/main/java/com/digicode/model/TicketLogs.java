package com.digicode.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "ticket_logs")
public class TicketLogs implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private String logData;
    private Date logDate;
    private String createdBy;
    private String assignee;

    @ManyToOne(fetch = FetchType.LAZY) // Many logs to one ticket
    @JoinColumn(name = "ticket_id", nullable = false, insertable = false, updatable = false) // ticketId column as foreign key
    private TicketsModel ticket; // Reference to the TicketsModel entity

    @Column(name = "ticket_id", nullable = false)
    private int ticketId; // Separate field to store the ticket's ID

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLogData() {
        return logData;
    }

    public void setLogData(String logData) {
        this.logData = logData;
    }

    public Date getLogDate() {
        return logDate;
    }

    public void setLogDate(Date logDate) {
        this.logDate = logDate;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getAssignee() {
        return assignee;
    }

    public void setAssignee(String assignee) {
        this.assignee = assignee;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public TicketsModel getTicket() {
        return ticket;
    }

    public void setTicket(TicketsModel ticket) {
        this.ticket = ticket;
    }
}
