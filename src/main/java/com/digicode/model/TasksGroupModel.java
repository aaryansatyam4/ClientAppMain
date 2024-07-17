package com.digicode.model;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;


@Entity
@Table(name = "tasksGroup")
public class TasksGroupModel implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	private String groupName;
	private int status;
	private int level;
	
	@OneToMany(mappedBy = "parentGroup", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<TaskSubgroupModel> subgroups = new HashSet<>();
	

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
	
	public Set<TaskSubgroupModel> getSubgroups() {
        return subgroups;
    }

    public void setSubgroups(Set<TaskSubgroupModel> subgroups) {
        this.subgroups = subgroups;
    }

    public void addSubgroup(TaskSubgroupModel subgroup) {
        subgroups.add(subgroup);
        subgroup.setParentGroup(this);
    }

    public void removeSubgroup(TaskSubgroupModel subgroup) {
        subgroups.remove(subgroup);
        subgroup.setParentGroup(null);
    }

}
