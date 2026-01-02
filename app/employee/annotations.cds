using MainService as service from '../../srv/services';
annotate service.Employees with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : 'Name',
        },
        {
            $Type : 'UI.DataField',
            Value : status_code,
            Label : 'Status',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'MainService.OnLeave',
            Label : '{i18n>OnLeave}',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'MainService.BackToWork',
            Label : '{i18n>BackToWork}',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'MainService.OnSick',
            Label : '{i18n>OnSick}',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'MainService.Rollback',
            Label : '{i18n>Rollback}',
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General',
            ID : 'General',
            Target : '@UI.FieldGroup#General',
        },
    ],
    UI.FieldGroup #General : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : name,
                Label : '{i18n>Name}',
            },
            {
                $Type : 'UI.DataField',
                Value : status_code,
                Label : '{i18n>Status}',
            },
        ],
    },
);

annotate service.Employees with {
    status @(
        Common.Text : status.desc,
        Common.Text.@UI.TextArrangement : #TextOnly,
    )
};

annotate service.Employees with {
    name @assert: (case
        when name is null then 'Name must be specified!'
        when trim(name) = '' then 'Name must not be empty!'
        when length(name) < 3 then 'Name is too short!'
    end);
};

annotate service.Employees with @flow.status: status actions {
    OnLeave @from: #Working @to: #OnPaidLeave;
    BackToWork @from: [ #OnPaidLeave, #Sick ] @to: #Working;
    OnSick @from: #Working @to : #Sick; 
    Rollback @from: [ #OnPaidLeave, #Sick, #Working ] @to: $flow.previous;
};