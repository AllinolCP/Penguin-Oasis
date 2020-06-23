from twisted.internet import reactor
from Avalanche.PenguinFactory import PenguinFactory

reactor.listenTCP(9875, PenguinFactory("login"))
reactor.run()