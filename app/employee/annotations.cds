using MainService as service from '../../srv/services';
annotate service.Employees with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : 'Name',
            @UI.Importance : #High,
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
        {
            $Type : 'UI.DataField',
            Value : position_ID,
            Label : '{i18n>Position}',
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : status_code,
            Label : '{i18n>Status}',
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : project_ID,
            Label : '{i18n>Project}',
            @UI.Importance : #Medium,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'MainService.assignProject',
            Label : '{i18n>AssignProject}',
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
            {
                $Type : 'UI.DataField',
                Value : position_ID,
                Label : '{i18n>Position}',
            },
            {
                $Type : 'UI.DataField',
                Value : project_ID,
                Label : '{i18n>Project}',
            },
        ],
    },
);

annotate service.Employees with {

    ID @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
    );

    status @(
        Common.Text : status.name,
        Common.Text.@UI.TextArrangement : #TextOnly,
    );

    position @(
        Common.Text : position.position,
        Common.Text.@UI.TextArrangement : #TextOnly,
        );

    project @(
        Common.Text : project.name,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Projects',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : project_ID,
                    ValueListProperty : 'ID',
                },
            ],
            Label : '{i18n>Projects}',
        },
        Common.ValueListWithFixedValues : true,
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
    assignProject @from: #Working;
};

annotate service.Projects with {
    ID @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
        // Common.Text : project.name,
        // Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Projects',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ID,
                    ValueListProperty : 'ID',
                },
            ],
            Label : '{i18n>Projects}',
        },
        Common.ValueListWithFixedValues : true,
)};