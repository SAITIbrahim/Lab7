package dataaccess;

/**
 *
 * @author hughm
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;
import sait.ca.lab6.models.Role;
import sait.ca.lab6.models.User;

public class UserDB {

    public List < User > getAll() throws Exception {
      EntityManager em = DBUtil.getEmFactory().createEntityManager();

      try {
          Query query = em.createNamedQuery("User.findAll");
          return query.getResultList();
      } finally {
          em.close();
      }
  }

  public User get(String email) throws Exception {
      EntityManager em = DBUtil.getEmFactory().createEntityManager();

      try {
          User user = em.find(User.class, email);
          return user;
      } finally {
          em.close();
      }

  }

  public boolean insert(User user) throws Exception {
      EntityManager em = DBUtil.getEmFactory().createEntityManager();
      EntityTransaction trans = em.getTransaction();

      try {


          trans.begin();
          em.persist(user);
          em.merge(user);
          trans.commit();
          return true;
      } catch (Exception ex) {
          trans.rollback();
          return false;
      } finally {
          em.close();
      }
  }

  public boolean update(User user) throws Exception {
      EntityManager em = DBUtil.getEmFactory().createEntityManager();
      EntityTransaction trans = em.getTransaction();

      try {
          trans.begin();
          em.merge(user);
          trans.commit();
          return true;
      } catch (Exception ex) {
          trans.rollback();
          return false;
      } finally {
          em.close();
      }
  }

  public boolean delete(User user) throws Exception {
      EntityManager em = DBUtil.getEmFactory().createEntityManager();
      EntityTransaction trans = em.getTransaction();

      try {

          System.out.println("Removing user: " + user.getEmail());
          
          trans.begin();
          em.remove(em.merge(user));
          trans.commit();

          return true;
      } catch (Exception ex) {
          trans.rollback();

          return false;
      } finally {
          em.close();
      }

  }
    
    
}
