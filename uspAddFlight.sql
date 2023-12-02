CREATE PROCEDURE uspAddFlight
     @intFlightID				AS INTEGER OUTPUT
    ,@dtmFlightDate				AS DATETIME
    ,@strFlightNumber			AS VARCHAR(255)
    ,@dtmTimeofDeparture		AS TIME
    ,@dtmTimeOfLanding			AS TIME
    ,@intFromAirportID			AS INTEGER 
    ,@intToAirportID			AS INTEGER
    ,@intMilesFlown 			AS INTEGER
    ,@intPlaneID				AS INTEGER
	,@intEmployeeID				AS INTEGER
	
AS
SET XACT_ABORT ON --terminate and rollback if any errors
BEGIN TRANSACTION
    SELECT @intFlightID = MAX(intFlightID) + 1 
    FROM TFlights (TABLOCKX) -- lock table until end of transaction
    -- default to 1 if table is empty
    SELECT @intFlightID = COALESCE(@intFlightID, 1)
    INSERT INTO TFlights (intFlightID, dtmFlightDate, strFlightNumber,  dtmTimeofDeparture, dtmTimeOfLanding, intFromAirportID, intToAirportID, intMilesFlown, intPlaneID, intEmployeeID)
    VALUES (@intFlightID, @dtmFlightDate, @strFlightNumber, @dtmTimeofDeparture, @dtmTimeOfLanding, @intFromAirportID, @intToAirportID, @intMilesFlown, @intPlaneID, @intEmployeeID)

COMMIT TRANSACTION
GO
