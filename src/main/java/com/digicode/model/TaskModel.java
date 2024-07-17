package com.digicode.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "task")
public class TaskModel implements Serializable, AutoCloseable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "task_name")
	private String taskname;
	
	@Column(name = "assignee")
	private String assignee;

	@Column(name = "task_description")
	private String taskDescription;

	@Column(name = "created_by")
	private String createdBy;

	@Column(name = "created_at")
	private Date createdAt;

	@Column(name = "remark")
	private String remark;

	@Column(name = "status")
	private String status;

	
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "userId")
	private EmployeeModel EmployeeModel;
	// Many-to-one relationship with TaskSubgroupModel
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "subgroup_id")
	private TaskSubgroupModel taskSubgroup;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTaskName() {
		return taskname;
	}

	public void setTaskName(String taskName) {
		this.taskname = taskName;
	}

	public String getTaskDescription() {
		return taskDescription;
	}

	public String getTaskname() {
		return taskname;
	}

	public void setTaskname(String taskname) {
		this.taskname = taskname;
	}

	public String getAssignee() {
		return assignee;
	}

	public void setAssignee(String assignee) {
		this.assignee = assignee;
	}

	public EmployeeModel getEmployeeModel() {
		return EmployeeModel;
	}

	public void setEmployeeModel(EmployeeModel employeeModel) {
		EmployeeModel = employeeModel;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public void setTaskDescription(String taskDescription) {
		this.taskDescription = taskDescription;
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

	public TaskSubgroupModel getTaskSubgroup() {
		return taskSubgroup;
	}

	public void setTaskSubgroup(TaskSubgroupModel taskSubgroup) {
		this.taskSubgroup = taskSubgroup;
	}

	@Override
	public String toString() {
		return "TaskModel [id=" + id + ", ticketName=" + taskname + ", ticketDescription=" + taskDescription
				+ ", createdBy=" + createdBy + ", createdAt=" + createdAt + ", remark=" + remark + ", status=" + status
				+ ", taskSubgroup=" + taskSubgroup + "]";
	}

	@Override
	public void close() throws Exception {
		// TODO Auto-generated method stub

	}

}
