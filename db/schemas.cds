using {cuid} from '@sap/cds/common';

namespace db.schema;

entity Employee : cuid {     
    name : String;
    @readonly status : Association to one EmployeeStatus default 'W';
}

entity EmployeeStatus {
    key code : EmployeeStatusCode;
    desc : localized String;
}

type EmployeeStatusCode : String(1) enum {
    Working = 'W';
    OnPaidLeave = 'L';
    Sick    = 'S';
}