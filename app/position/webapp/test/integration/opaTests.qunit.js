sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'position/test/integration/FirstJourney',
		'position/test/integration/pages/PositionsList',
		'position/test/integration/pages/PositionsObjectPage'
    ],
    function(JourneyRunner, opaJourney, PositionsList, PositionsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('position') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePositionsList: PositionsList,
					onThePositionsObjectPage: PositionsObjectPage
                }
            },
            opaJourney.run
        );
    }
);