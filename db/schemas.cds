using {cuid, sap.common.CodeList } from '@sap/cds/common';

namespace db.schema;

entity Employee : cuid {     
    name : String;
    position : Association to one EmployeePosition;
    @readonly status : Association to one EmployeeStatus default 'W';
    project : Association to one Project;
}

entity EmployeeStatus : CodeList {
    key code : EmployeeStatusCode;
}

entity Project : cuid {
    name : String;
    involvedEmployees : Association to many Employee on involvedEmployees.project = $self;
}

entity EmployeePosition : cuid {
    position : String;
    parent : Association to one EmployeePosition;
    employees : Association to many Employee on employees.position = $self;
}

type EmployeeStatusCode : String(1) enum {
    Working = 'W';
    OnPaidLeave = 'L';
    Sick    = 'S';
}