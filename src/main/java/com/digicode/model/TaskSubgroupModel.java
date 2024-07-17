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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String subgroupName;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    private TasksGroupModel parentGroup;

    @OneToMany(mappedBy = "taskSubgroup", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<TaskModel> task = new HashSet<>();

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

    public Set<TaskModel> getTasks() {
        return task;
    }

    public void setTickets(Set<TaskModel> tasks) {
        this.task = tasks;
    }

    public void addTicket(TaskModel tasks) {
        task.add(tasks);
        tasks.setTaskSubgroup(this);
    }

    public void removeTicket(TaskModel tasks) {
        task.remove(tasks);
        tasks.setTaskSubgroup(null);
    }
}