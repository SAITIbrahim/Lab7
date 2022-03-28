/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import services.UserService;
import services.RoleService;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sait.ca.lab6.models.Role;
import sait.ca.lab6.models.User;

/**
 *
 * @author hughm
 */
@WebServlet(name = "UserServlet", urlPatterns = {"/user"})
public class UserServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UserService uService = new UserService();
        RoleService rService = new RoleService();
        
        try {
            
            System.out.println("Grabbing list of users");
            
            List<User> users = uService.getAll();
            List<Role> roles = rService.getAll();
            
            System.out.println("Got list of users: " + users.size());
            request.setAttribute("users", users);
            request.setAttribute("roles", roles);
            
        }catch(Exception err) {
            System.out.println("Exception grabbing list of users: " + err);
        }
        
        this.getServletContext().getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UserService uService = new UserService();
        RoleService rService = new RoleService();
        
        String operationType = request.getParameter("operation_type");

        System.out.println("Operation type: " + operationType);
        
        if (operationType.equals("deletion")) {
            String email = request.getParameter("cUser_Email");
            try {
                uService.delete(email);
            }catch(Exception err) {
                System.out.println("Error deleing user: " + err);
            }
        }
        
        if (operationType.equals("edit")) {
            
            String email = request.getParameter("eUser_Email");
            String fName = request.getParameter("eUser_First_Name");
            String lName = request.getParameter("eUser_Last_Name");
            String password = request.getParameter("eUser_Password");
            String role = request.getParameter("eUser_Role");
            String isActive = "on";//request.getParameter("eUser_IsActive");
            
            Role nRole = new Role();
            nRole.setId(Integer.parseInt(role));
            
            try {
                uService.update(email, isActive.equals("on"), fName, lName, password, nRole);    
            }catch(Exception err) {
                System.out.println("Error updating user: " + err);
            }
            
        }
        
        if (operationType.equals("creation")) {
        
            String email = request.getParameter("cUser_Email");
            String fName = request.getParameter("cUser_First_Name");
            String lName = request.getParameter("cUser_Last_Name");
            String password = request.getParameter("cUser_Password");
            String role = request.getParameter("cUser_Role");
            String isActive = request.getParameter("cUser_IsActive");

            // String email, boolean active, String firstName, String lastName, String password, Role role
            
            Role nRole = new Role();
            nRole.setId(Integer.parseInt(role));
            
            try {
                uService.insert(email, isActive != null && isActive.equals("on"), fName, lName, password, nRole);    
            }catch(Exception err) {
                System.out.println("Error creating new user: " + err.getMessage());
            }

            System.out.println("Got parameter: " + email + " " + fName + " " + lName + " " +  password + " " + role + " " + isActive + " " + operationType);

        }
        
        try {
            
            System.out.println("Grabbing list of users");
            
            List<User> users = uService.getAll();
            List<Role> roles = rService.getAll();
            
            System.out.println("Got list of users: " + users.size());
            request.setAttribute("users", users);
            request.setAttribute("roles", roles);
            
        }catch(Exception err) {
            System.out.println("Exception grabbing list of users: " + err.getMessage());
        }
        
        this.getServletContext().getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
        
    }
    
    

}

