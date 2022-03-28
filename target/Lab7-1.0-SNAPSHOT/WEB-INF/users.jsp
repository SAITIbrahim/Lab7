<%-- 
    Document   : users
    Created on : Mar 11, 2022, 2:50:44 PM
    Author     : hughm
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
          <title>User Management Portal</title>

        <!-- Using Materialize UI Kit to make things pretty -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <!-- Add google font -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display&display=swap" rel="stylesheet">

        <style>

            /* Override styles from UI Kit */
            .container { 
                width: 90%;
                max-width: 90%;
            }

            /* Override fonts on desired elements */

            .body-style {
                background-color: #0E185F;
                font-family: 'Playfair Display', serif;
                color: white;
            }

            .div-section-style{
                background-color: #283593;
                border-radius: 5%;
            }

            input, select, textarea{
                color: white;
            }

        </style>

    </head>
    
    <body class="body-style">

        <!-- Top Nav-Bar -->
        <nav>
            <div class="nav-wrapper indigo darken-4">
                <a href="#" class="brand-logo center">
                    <i class="material-icons">account_box</i>
                    User Management Portal
                </a>
            </div>
        </nav>

        <!-- Declare base container to hold all components -->
        <div class="container" style="margin-top: 1em;">

            <!-- First row of the grid to hold the title information -->
            <div class="row">

                <div class="col s2">
                    <div class="center-align">
                        <h4>
                            Add User
                        </h4>
                    </div>
                </div>

                <div class="col s8">
                    <div class="center-align">
                        <h4>
                            Manage Users
                        </h4>
                    </div>
                </div>

                <div class="col s2">
                    <div class="center-align">
                        <h4>
                            Edit User
                        </h4>
                    </div>
                </div>

            </div>

            <div class="row" >

                <!-- User Creation/Modification Form -->
                <div class="col s2 div-section-style">
                    
                    <form method="POST">

                        <input id="e_operation_type" name="operation_type" value="creation" type="hidden"/>
                        
                        <div class="input-field">
                            <input placeholder="user@edu.sait.ca" id="cUser_Email" name="cUser_Email" type="text"/>
                            <label for="eFirst_Name">Email</label>
                        </div>

                        <div class="input-field">
                            <input placeholder="First Name" id="cUser_First_Name" name="cUser_First_Name" type="text"/>
                            <label for="first_name">First Name</label>
                        </div>

                        <div class="input-field">
                            <input placeholder="Last Name" id="cUser_Last_Name" name="cUser_Last_Name" type="text"/>
                            <label for="first_name">Last Name</label>
                        </div>

                        <div class="input-field">
                            <input placeholder="Password" id="cUser_Password" name="cUser_Password" type="text"/>
                            <label for="first_name">Password</label>
                        </div>
                        
                        <div class="input-field">
                            <select id="cUser_Role" name="cUser_Role">
                                <c:forEach var="role" items="${roles}">
                                    <option value="${role.id}">${role.name}</option>
                                </c:forEach>                                
                            </select>
                            <label>Select Role</label>
                        </div>

                        <div class="input-field">
                            <div class="switch">
                                <label>
                                  Active
                                  <input id="cUser_IsActive" name="cUser_IsActive" type="checkbox">
                                  <span class="lever"></span>
                                  Disabled
                                </label>
                            </div>
                        </div>
                        
                        <div class="input-field">
                            <button id="submitFormBtn" class="btn waves-effect waves-light" onclick="AddUser('${user.email}')" action="submit" style="width: 100%;">Create User
                                <i class="material-icons right">save</i>
                            </button>
                        </div>

                    </form>

                </div>

                <!-- User Overview Table -->
                <div class="col s8">
                    <div class="center-align div-section-style">
                        <table class="centered highlight">
                            <thead>
                              <tr>
                                  <th>Email</th>
                                  <th>First Name</th>
                                  <th>Last Name</th>
                                  <th>Role</th>
                                  <th>Edit</th>
                                  <th>Delete</th>
                              </tr>
                            </thead>
                    
                            <tbody>
                                
                                <c:forEach var="user" items="${users}">
                                    
                                    <tr>
                                        
                                        <!-- User Information -->
                                        <td>${user.email}</td>
                                        <td>${user.firstName}</td>
                                        <td>${user.lastName}</td>
                                        <td>${user.role.name}</td>
                                        
                                        <!-- User Access Control Options -->
                                        <td>
                                            <button class="btn waves-effect waves-light" type="submit" onclick="EditUser('${user.email}')" name="action">Edit
                                                <i class="material-icons right">edit</i>
                                            </button>
                                        </td>
                                        
                                        <td>
                                            <button class="btn waves-effect waves-light red" type="submit" onclick="RemoveUser('${user.email}')" name="action">Delete
                                                <i class="material-icons right">delete</i>
                                            </button>
                                        </td>

                                    </tr>
                                    
                                </c:forEach>
                                
                            </tbody>
                          </table>
                    </div>
                </div>

                <!-- User Modification Form -->
                <div class="col s2 div-section-style">
                                
                    <form method="POST">
                        
                        <input name="operation_type" value="edit" type="hidden"/>

                        <div class="input-field">
                            <input readonly placeholder="user@edu.sait.ca" name="eUser_Email" id="eUser_Email" type="text"/>
                            <label for="eFirst_Name">Email</label>
                        </div>

                        <div class="input-field">
                            <input placeholder="First Name" name="eUser_First_Name" id="eUser_First_Name" type="text"/>
                            <label for="first_name">First Name</label>
                        </div>

                        <div class="input-field">
                            <input placeholder="Last Name" name="eUser_Last_Name" id="eUser_Last_Name" type="text"/>
                            <label for="first_name">Last Name</label>
                        </div>

                        <div class="input-field">
                            <input placeholder="Password" name="eUser_Password" id="eUser_Password" type="text"/>
                            <label for="first_name">Password</label>
                        </div>
                        
                        <div class="input-field">
                            <select name="eUser_Role" id="eUser_Role">
                                <c:forEach var="role" items="${roles}">
                                    <option value="${role.id}">${role.name}</option>
                                </c:forEach>                                
                            </select>
                            <label>Select Role</label>
                        </div>

                        <div class="input-field">
                            <div class="switch">
                                <label>
                                  Active
                                  <input name="eUser_IsActive" id="eUser_IsActive" type="checkbox">
                                  <span class="lever"></span>
                                  Disabled
                                </label>
                            </div>
                        </div>
                        
                        <div class="input-field">
                            <button class="btn waves-effect waves-light" type="submit" name="action" style="width: 100%;">Save User
                                <i class="material-icons right">save</i>
                            </button>
                        </div>
                        
                    </form>

                </div>


            </div>

        </div>

        <script>

            function InitializeHooks() {
                
                document.addEventListener('DOMContentLoaded', _ => {
                    var elems = document.querySelectorAll('select');
                    var instances = M.FormSelect.init(elems, null);
                });

            }
            
            let userCollection = [];
            
            function EditUser(arg) {
                console.log("Edit user called", arg);                
                let chosenUser = userCollection.find(user => user.email == arg);
                
                console.log("Chosen user", chosenUser);
                
                let userEmailInput = document.querySelector('#eUser_Email');
                let userFNameInput = document.querySelector('#eUser_First_Name');
                let userLNameInput = document.querySelector('#eUser_Last_Name');
                let userPassword = document.querySelector('#eUser_Password');
                let userRole = document.querySelector('#eUser_Role');
                
                let userIsActive = document.querySelector('#eUser_IsActive');
                
                console.log(chosenUser.firstName);
                
                userEmailInput.value = chosenUser.email;
                userFNameInput.value = chosenUser.firstName;
                userLNameInput.value = chosenUser.lastName;
                userPassword.value = chosenUser.password;
                userIsActive.checked = chosenUser.isActive == "true";
                
                console.log("Updated", userEmailInput);
                
            }
            
            function AddUser(arg) {
                
                let userEmailInput = document.querySelector('#cUser_Email');
                let userFNameInput = document.querySelector('#cUser_First_Name');
                let userLNameInput = document.querySelector('#cUser_Last_Name');
                let userPassword = document.querySelector('#cUser_Password');
                let userRoleIndex = parseInt(document.querySelector('#cUser_Role').value);
                let userIsActive = document.querySelector('#cUser_IsActive');
               
                let user = {
                    email: userEmailInput.value,
                    firstName: userFNameInput.value,
                    lastName: userLNameInput.value,
                    password: userPassword.value,
                    isActive: userIsActive.checked,
                    userRoleIndex: userRoleIndex
                };
                
                console.log(user);
                
                userEmailInput.value = chosenUser.email;
                userFNameInput.value = chosenUser.firstName;
                userLNameInput.value = chosenUser.lastName;
                userPassword.value = chosenUser.password;
                userIsActive.checked = chosenUser.isActive == "true";

                console.log("Updated", userEmailInput);
                
            }
            
            function RemoveUser(arg) {
                
                document.querySelector('#cUser_Email').value = arg;
                document.querySelector('#e_operation_type').value = "deletion";
                document.querySelector('#submitFormBtn').click();

                console.log("Remove user called", arg);
            }
            
            function SaveEdit() {
                
            }
   
            
            <c:forEach var="user" items="${users}">
                
                userCollection.push({
                    email: '${user.email}',
                    password: '${user.password}',
                    isActive: '${user.active}',
                    firstName: '${user.firstName}',
                    lastName: '${user.lastName}',
                    role: parseInt('${user.role.id}'),
                    roleName: ('${user.role.name}')
                });
                
                
            </c:forEach>
            
            console.log(userCollection);

            InitializeHooks();

        </script>

    </body>

    <!-- Footer -->
    
</html>
