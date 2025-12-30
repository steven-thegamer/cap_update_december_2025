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
}

annotate MainService.Employees with {
    name @assert: (case
        when name is null then 'Name must be specified'
        when trim(name) = '' then 'Name must not be empty'
    end);
};


annotate MainService.Employees with @flow.status: status actions {
    OnLeave @from: #Working @to: #OnPaidLeave;
    BackToWork @from: [ #OnPaidLeave, #Sick ] @to: #Working;
    OnSick @from: #Working @to : #Sick; 
    Rollback @from: [ #OnPaidLeave, #Sick, #Working ] @to: $flow.previous;
};
