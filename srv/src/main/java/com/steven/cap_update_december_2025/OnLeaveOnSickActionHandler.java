package com.steven.cap_update_december_2025;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.ql.Update;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.mainservice.Employees;
import cds.gen.mainservice.EmployeesOnLeaveContext;
import cds.gen.mainservice.EmployeesOnSickContext;
import cds.gen.mainservice.Employees_;
import cds.gen.mainservice.MainService_;

@Component
@ServiceName(MainService_.CDS_NAME)
public class OnLeaveOnSickActionHandler  implements EventHandler  {

    @Autowired
    PersistenceService db;

    @On(entity=Employees_.CDS_NAME, event= EmployeesOnLeaveContext.CDS_NAME)
    public void onEmployeeLeave(EmployeesOnLeaveContext context){
        removeProjectFromEmployee(context.getCqn());
        context.setCompleted();
    }

    @On(entity=Employees_.CDS_NAME, event= EmployeesOnSickContext.CDS_NAME)
    public void onEmployeeSick(EmployeesOnSickContext context) {
        removeProjectFromEmployee(context.getCqn());
        context.setCompleted();
    }

    public void removeProjectFromEmployee(CqnSelect select){
        List<Employees> employees = db.run(select).listOf(Employees.class);
        employees.forEach(employee -> {
            employee.setProjectId("");
        });
        db.run(Update.entity(Employees_.CDS_NAME).entries(employees));
    }


}
