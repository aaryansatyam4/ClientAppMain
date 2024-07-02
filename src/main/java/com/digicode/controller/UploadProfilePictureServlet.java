package com.digicode.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.digicode.dao.LoginServiceImpl;
import com.digicode.model.EmployeeModel;

@WebServlet("/uploadProfilePicture")
public class UploadProfilePictureServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LoginServiceImpl loginService = new LoginServiceImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("userId"); // Ensure you have userId to associate with the profile picture

        // Get the file part from request
        Part filePart = request.getPart("profilePicture");
        String fileName = extractFileName(filePart); // Extract filename from content-disposition header of part

        // Save the file to server or database
        if (fileName != null && !fileName.isEmpty()) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String savePath = uploadPath + File.separator + fileName;
            File fileSaveDir = new File(savePath);
            filePart.write(savePath);

            // Update profile picture path in database
            EmployeeModel user = loginService.getUserById(userId); // Fetch user using instantiated service object
            if (user != null) {
                user.setProfilePicture(savePath); // Save the file path to database
                loginService.updateUser(user); // Update the user with profile picture path
            }
        }

        response.sendRedirect("profile.jsp"); // Redirect to profile page after upload
    }

    private String extractFileName(Part part) {
        if (part != null) {
            String contentDisp = part.getHeader("content-disposition");
            String[] items = contentDisp.split(";");
            for (String s : items) {
                if (s.trim().startsWith("filename")) {
                    return s.substring(s.indexOf("=") + 2, s.length() - 1);
                }
            }
        }
        return null;
    }
}
