<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%
    // Invalidate the session (use the implicit session object)
    if (session != null) {
        session.invalidate();
    }

    // Get all cookies
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            // Set the cookie's max age to 0 to delete it
            cookie.setMaxAge(0);
            cookie.setPath("/"); // Ensure the path is set correctly for deletion
            response.addCookie(cookie);
        }
    }

    // Redirect to index.html
    response.sendRedirect("index.html");
%>
