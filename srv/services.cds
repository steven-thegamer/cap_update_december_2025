using db.schema as schema from '../db/schemas';

service MainService {
    @odata.draft.enabled
    entity Employees as projection on schema.Employee
    actions {
        action OnLeave();
        action BackToWork();
        action OnSick();
        action Rollback();
    };
    entity Statuses as projection on schema.EmployeeStatus;
    entity Positions as projection on schema.EmployeePosition;
}