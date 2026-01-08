using db.schema as schema from '../db/schemas';

service MainService {
    @odata.draft.enabled
    entity Employees as projection on schema.Employee
    actions {
        action OnLeave();
        action BackToWork();
        action OnSick();
        action Rollback();
        action assignProject(project : Projects:ID);
    };
    entity Statuses as projection on schema.EmployeeStatus;
    entity Positions as projection on schema.EmployeePosition;
    entity Projects as projection on schema.Project;
}