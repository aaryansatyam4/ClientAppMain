package com.digicode.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.digicode.dao.TicketDAO;
import com.digicode.model.TasksGroupModel;
import com.digicode.model.TaskSubgroupModel;
import com.digicode.model.TicketsModel;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@WebServlet("/listTicketGroups")
public class ListTicketGroups extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TicketDAO ticketDAO = new TicketDAO();

        List<TasksGroupModel> ticketGroups = ticketDAO.getTicketGroups();

        List<Map<String, Object>> groupList = new ArrayList<>();

        for (TasksGroupModel group : ticketGroups) {
            Map<String, Object> groupMap = new HashMap<>();
            groupMap.put("id", group.getId());
            groupMap.put("groupName", group.getGroupName());

            List<Map<String, Object>> subgroupList = new ArrayList<>();
            List<TaskSubgroupModel> subgroups = ticketDAO.getSubgroupsByGroupId(group.getId());

            for (TaskSubgroupModel subgroup : subgroups) {
                Map<String, Object> subgroupMap = new HashMap<>();
                subgroupMap.put("id", subgroup.getId());
                subgroupMap.put("subgroupName", subgroup.getSubgroupName());

                List<Map<String, Object>> ticketList = new ArrayList<>();
                List<TicketsModel> tickets = ticketDAO.getTicketsBySubgroupId(subgroup.getId());

                for (TicketsModel ticket : tickets) {
                    Map<String, Object> ticketMap = new HashMap<>();
                    ticketMap.put("id", ticket.getId());
                    ticketMap.put("ticketName", ticket.getTicketName());
                    ticketList.add(ticketMap);
                }

                subgroupMap.put("tickets", ticketList);
                subgroupList.add(subgroupMap);
            }

            groupMap.put("subgroups", subgroupList);
            groupList.add(groupMap);
        }

        // Convert to JSON using Gson
        Gson gson = new GsonBuilder().create();
        String json = gson.toJson(groupList);

        // Send JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}
