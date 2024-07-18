package com.digicode.controller;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.json.JSONArray;
import org.json.JSONObject;

import com.digicode.dao.TaskSubgroupServiceImpl;
import com.digicode.model.TaskSubgroupModel;

@Path("/sub")
public class TaskSubGroupController {

    @POST
    @Path("/subgroup")
  //  @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
   public Response getSubgroups(@FormParam("id") String parentGroupId) {
      
        
        JSONObject responseJSON = new JSONObject();
        JSONArray subgroupsArray = new JSONArray();
        TaskSubgroupServiceImpl subgroupService = new TaskSubgroupServiceImpl();
        List<TaskSubgroupModel> subgroups;

        try {
            subgroups = subgroupService.getSubgroupsByParentGroupId(Integer.parseInt(parentGroupId));

            for (TaskSubgroupModel subgroup : subgroups) {
                JSONObject subgroupJSON = new JSONObject();
                subgroupJSON.put("id", subgroup.getId());
                subgroupJSON.put("subgroupName", subgroup.getSubgroupName());

                // Assuming parentGroup is fetched lazily
                if (subgroup.getParentGroup() != null) {
                    JSONObject parentGroupJSON = new JSONObject();
                    parentGroupJSON.put("id", subgroup.getParentGroup().getId());
                    parentGroupJSON.put("groupName", subgroup.getParentGroup().getGroupName());
                    subgroupJSON.put("parentGroup", parentGroupJSON);
                }

                subgroupsArray.put(subgroupJSON);
            }

            responseJSON.put("status", "success");
            responseJSON.put("message", "Subgroups retrieved successfully");
            responseJSON.put("subgroups", subgroupsArray);
        } catch (Exception e) {
            responseJSON.put("status", "failure");
            responseJSON.put("message", "Error retrieving subgroups");
            e.printStackTrace();
        }

        // Return JSON response with appropriate status
        return Response.ok(responseJSON.toString(), MediaType.APPLICATION_JSON).build();
    }
}
