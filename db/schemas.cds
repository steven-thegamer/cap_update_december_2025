using {cuid, sap.common.CodeList } from '@sap/cds/common';

namespace db.schema;

entity Employee : cuid {     
    name : String;
    position : Association to one EmployeePosition;
    @readonly status : Association to one EmployeeStatus default 'W';
}

entity EmployeeStatus : CodeList {
    key code : EmployeeStatusCode;
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