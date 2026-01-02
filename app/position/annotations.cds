using MainService as service from '../../srv/services';
annotate service.Positions with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : position,
            Label : '{i18n>Position}',
        },
    ],
);

annotate service.Positions with @hierarchy : parent;