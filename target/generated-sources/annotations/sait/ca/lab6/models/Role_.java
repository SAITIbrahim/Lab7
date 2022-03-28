package sait.ca.lab6.models;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import sait.ca.lab6.models.User;

@Generated(value="EclipseLink-2.7.9.v20210604-rNA", date="2022-03-27T22:24:53")
@StaticMetamodel(Role.class)
public class Role_ { 

    public static volatile SingularAttribute<Role, String> name;
    public static volatile SingularAttribute<Role, Integer> id;
    public static volatile ListAttribute<Role, User> user;

}