using MainService as service from '../../srv/services';
annotate service.Positions with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : position,
            Label : '{i18n>Position}',
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Employees',
            ID : 'Employees',
            Target : 'employees/@UI.LineItem#Employees',
        },
    ],
);

annotate service.Positions with @hierarchy : parent;
annotate service.Employees with @(
    UI.LineItem #Employees : [
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
    ]
);

