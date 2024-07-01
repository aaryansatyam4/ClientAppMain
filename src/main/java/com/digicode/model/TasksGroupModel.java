package com.digicode.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;

@Entity
@Table(name = "tasksGroup")
public class TasksGroupModel implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private String groupName;
    private int status;
    private int level;

    // One-to-many relationship with TaskSubgroupModel
    @OneToMany(mappedBy = "parentGroup", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<TaskSubgroupModel> subGroups = new HashSet<>();

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public Set<TaskSubgroupModel> getSubGroups() {
        return subGroups;
    }

    public void setSubGroups(Set<TaskSubgroupModel> subGroups) {
        this.subGroups = subGroups;
    }

    // Add a subgroup
    public void addSubGroup(TaskSubgroupModel subGroup) {
        subGroups.add(subGroup);
        subGroup.setParentGroup(this);
    }

    // Remove a subgroup
    public void removeSubGroup(TaskSubgroupModel subGroup) {
        subGroups.remove(subGroup);
        subGroup.setParentGroup(null);
    }
}
