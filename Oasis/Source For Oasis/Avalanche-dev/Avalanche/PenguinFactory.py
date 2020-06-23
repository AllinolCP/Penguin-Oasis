from twisted.internet.protocol import Factory
from Penguin import Penguin
from Penguin import Spheniscidae

import logging

class PenguinFactory(Factory):

	# Protocol must either be "world" or "login"
	def __init__(self, protocol = "login"):
		self.logger = logging.getLogger("Avalanche")
		self.protocol = protocol

		if self.protocol != "world" and self.protocol != "login":
			self.logger.fatal("Protocol specified must either be \"world\" or \"login\"")
		elif self.protocol == "world":
			self.users = [] # Might use a deque in the future
		else: # No need to do anything special for the log-in protocol
			pass

		self.logger.info("PenguinFactory created")

	def buildProtocol(self, addr):
		self.logger.info("Client connected")

		if self.protocol == "login":
			return Spheniscidae()
		elif self.protocol == "world":
			return Penguin(self.users)
		else:
			pass # Invalid protocol!?