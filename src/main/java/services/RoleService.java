package services;

import dataaccess.RoleDB;
import java.util.List;
import sait.ca.lab6.models.Role;



/**
 *
 * @author hughm
 */
public class RoleService {
    
    private RoleDB roleDB = new RoleDB();
    
    public List<Role> getAll() throws Exception {
        System.out.println("grabbing all roles");
        List<Role> roles = this.roleDB.getAll();
        return roles;
    }
    
}
