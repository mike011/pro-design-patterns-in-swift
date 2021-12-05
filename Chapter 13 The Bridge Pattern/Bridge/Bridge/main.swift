var bridge = CommunicatorBridge(channel: SatelliteChannel());
var comms = Communicator(clearChannel: bridge, secureChannel: bridge, priorityChannel: bridge);

comms.send(clearTextMessage: "Hello!")
comms.send(secureMessage: "This is a secret")
comms.send(priorityMessage: "This is important")
