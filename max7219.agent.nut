server.log("Agent started - Display message x: " + http.agenturl() + "?message=x");

function requestHandler(request, response)
{
  try
  {
    // check if the user sent 'print' as a query parameter
    if ("message" in request.query)
    {
        device.send("message", request.query.message);
    }
    response.send(200, (request.query.message + "\" sent."));
  }
  catch (ex)
  {
    response.send(500, "Internal Server Error: " + ex);
  }
}

function respond(bool_value)
{
  // Respond to a Device-sent 'ack' notification
  if (bool_value) server.log("Message displayed.");
}

// Register the HTTP handler
http.onrequest(requestHandler);

// Listen for a notification named 'ack' from the Device
device.on("ack", respond);
