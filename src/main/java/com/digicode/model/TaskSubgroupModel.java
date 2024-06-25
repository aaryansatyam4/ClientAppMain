package com.digicode.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;

@Entity
@Table(name = "taskSubgroup")
public class TaskSubgroupModel implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private String subgroupName;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    private TasksGroupModel parentGroup;

    @OneToMany(mappedBy = "id", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<TicketsModel> tickets = new HashSet<>();

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSubgroupName() {
        return subgroupName;
    }

    public void setSubgroupName(String subgroupName) {
        this.subgroupName = subgroupName;
    }

   

    public TasksGroupModel getParentGroup() {
        return parentGroup;
    }

    public void setParentGroup(TasksGroupModel parentGroup) {
        this.parentGroup = parentGroup;
    }

    public Set<TicketsModel> getTickets() {
        return tickets;
    }

    public void setTickets(Set<TicketsModel> tickets) {
        this.tickets = tickets;
    }

    
}
