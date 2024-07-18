package com.digicode.controller;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.json.JSONArray;
import org.json.JSONObject;

import com.digicode.dao.TasksServiceImpl;
import com.digicode.model.TaskModel;

@Path("/Task")
public class TaskController {

    @POST
    @Path("/bysubgroup")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public Response getTasksBySubgroup(@FormParam("id") String subgroupID) {
        JSONObject responseJSON = new JSONObject();
        JSONArray tasksArray = new JSONArray();
        TasksServiceImpl taskService = new TasksServiceImpl();
        List<TaskModel> tasks;

        try {
            tasks = taskService.getTaskByParentGroupId(Integer.parseInt(subgroupID));

            for (TaskModel task : tasks) {
                JSONObject taskJSON = new JSONObject();
                taskJSON.put("id", task.getId());
                taskJSON.put("taskName", task.getTaskName());
                // Add more task details as needed

                tasksArray.put(taskJSON);
            }

            responseJSON.put("status", "success");
            responseJSON.put("message", "Tasks retrieved successfully");
            responseJSON.put("tasks", tasksArray);
        } catch (Exception e) {
            responseJSON.put("status", "failure");
            responseJSON.put("message", "Error retrieving tasks");
            e.printStackTrace();
        }

        // Return JSON response with appropriate status
        return Response.ok(responseJSON.toString(), MediaType.APPLICATION_JSON).build();
    }
}
