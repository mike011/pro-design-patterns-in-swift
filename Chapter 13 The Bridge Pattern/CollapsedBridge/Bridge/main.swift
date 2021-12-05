var comms = Communicator(channel: .satellite)

comms.send(clearTextMessage: "Hello!")
comms.send(secureMessage: "This is a secret")
comms.send(priorityMessage: "This is important")
