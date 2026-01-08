package com.steven.cap_update_december_2025;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.ql.Update;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.mainservice.Employees;
import cds.gen.mainservice.EmployeesAssignProjectContext;
import cds.gen.mainservice.Employees_;
import cds.gen.mainservice.MainService_;

@Component
@ServiceName(MainService_.CDS_NAME)
public class AssignProjectActionHandler implements EventHandler {

    @Autowired
    PersistenceService db;

    @On(entity=Employees_.CDS_NAME, event=EmployeesAssignProjectContext.CDS_NAME)
    public void onAssignProject(EmployeesAssignProjectContext context){
        List<Employees> employees = db.run(context.getCqn()).listOf(Employees.class);
        employees.forEach(employee -> {
            employee.setProjectId(context.getProject());
        });
        db.run(Update.entity(Employees_.CDS_NAME).entries(employees));
        context.setCompleted();
    }

}
