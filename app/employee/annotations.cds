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
            Label : 'On Leave',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'MainService.BackToWork',
            Label : 'Back To Work',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'MainService.OnSick',
            Label : 'On Sick',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'MainService.Rollback',
            Label : 'Rollback',
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
                Label : 'Name',
            },
            {
                $Type : 'UI.DataField',
                Value : status_code,
                Label : 'status_code',
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

