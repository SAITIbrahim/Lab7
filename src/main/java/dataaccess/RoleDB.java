
package dataaccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;
import sait.ca.lab6.models.Role;

/**
 *
 * @author hughm
 */
public class RoleDB {
    
    public List<Role> getAll() throws Exception {
        
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        
        try {
            Query query = em.createNamedQuery("Role.findAll");
            return query.getResultList();
        } finally {
            em.close();
        }
        
    }
    
}
