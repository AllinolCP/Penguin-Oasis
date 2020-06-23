import logging
import hashlib

from time import time

from twisted.protocols.basic import LineReceiver
from lxml import etree

from Crypto import Crypto
from Database import Database

class ClubPenguinClient(object, LineReceiver):

	delimiter = "\x00"

	def __init__(self):
		self.logger = logging.getLogger("Avalanche")

		self.xmlHandlers = {
			"verChk": self.handleVersionCheck,
			"rndK": self.handleRandomKey,
			"login": self.handleLogin,
		}

	def handleVersionCheck(self, data):
		bodyTag = list(data)[0]
		apiVersion = bodyTag.get("v")

		self.logger.debug("Received version check")

		if apiVersion == "153":
			self.logger.debug("API versions match")

			self.sendLine("<msg t='sys'><body action='apiOK' r='0'></body></msg>")
		elif apiVersion!= "153":
			self.logger.debug("API versions don't match (client checked for version " + apiVersion + ")")

			self.sendLine("<msg t='sys'><body action='apiKO' r='0'></body></msg>")
		else:
			self.logger.error("Received a version-check packet from a client without a version attribute")
			self.transport.loseConnection()


	def handleRandomKey(self, data):
		self.logger.debug("Received random key request")

		randomKey = Crypto.generateRandomKey()
		self.randomKey = randomKey

		self.logger.debug("Generated random key " + randomKey)

		self.sendLine("<msg t='sys'><body action='rndK' r='-1'><k>" + self.randomKey + "</k></body></msg>")

	# Overriden in children
	def handleLogin(self, data):
		pass

	def lineReceived(self, line):
		self.logger.debug("Received: " + line)
		
		# Callback lookups, etc
		if line == "<policy-file-request/>":
			self.sendLine("<cross-domain-policy><allow-access-from domain='*' to-ports='*' /></cross-domain-policy>")
		elif line.startswith("<"):
			data = etree.fromstring(line)[0]

			if data is not None:
				action = data.get("action")

				if action is not None:
					# There's a callback assigned to this action
					if action in self.xmlHandlers:
						# So, let's call it!
						self.logger.debug("XML handler exists for " + action)

						self.xmlHandlers[action](data)
					else:
						self.logger.error(action + " not found in the XML handlers dictionary")
				else:
					self.logger.error("Received XML packet without a specified action attribute")
					self.transport.loseConnection()
			else:
				self.logger.error("Received malformed XML packet")
				self.transport.loseConnection()
		# Everything below this line focuses on parsing and handling world data (packets with %xt% in them)
		elif line.startswith("%"): 
			self.logger.debug("Received world data")
			# TODO: Implement packet parser

	def sendPacket(self, *args):
		line = "%xt%" + "%".join(args) + "%"

		self.logger.debug("Sending %s" % line)

		self.sendLine(line)

	def connectionLost(self, reason):
		self.logger.info("Client disconnected")

class Spheniscidae(ClubPenguinClient):

	def __init__(self):
		super(Spheniscidae, self).__init__()

		self.database = Database()
		
		self.logger.info("Spheniscidae instance created")

	def continueHandleLogin(self, results, penguin):
		id, dbPassword, email = results[0]
		id = str(id)

		username, password = penguin

		encryptedPassword = Crypto.getLoginHash(dbPassword, self.randomKey)

		if encryptedPassword != password:
			self.sendLine("%xt%e%-1%101%")
			self.transport.loseConnection()
		else:
			self.logger.info("Login successful")

			confirmationHash = hashlib.md5(self.randomKey.encode('utf-8')).hexdigest()
			friendsKey = hashlib.md5(id.encode('utf-8')).hexdigest()
			loginTime = str(time())

			loginString = "|".join((id, username, encryptedPassword, "1", "45", "2", "false", "true", loginTime))
			self.sendPacket("l", "-1", loginString, confirmationHash, friendsKey, "101,1", email)

			self.database.updateColumn(confirmationHash, column="ConfirmationHash", id=id)
			self.database.updateColumn(encryptedPassword, column="LoginKey", id=id)

			self.transport.loseConnection()

	def handleLogin(self, data):
		username = list(data)[0][0].text
		password = list(data)[0][1].text

		self.logger.info(username + " is attempting to log in")

		defer = self.database.getColumns("ID", "Password", "Email", name=username)
		defer.addCallback(self.continueHandleLogin, [username, password])

class Penguin(ClubPenguinClient):

	def __init__(self, users):
		super(Penguin, self).__init__()

		self.users = users
		self.users.add(self)

		self.logger.info("Penguin instance created")

	def handleLogin(self, data):
		username = list(data)[0][0].text
		password = list(data)[0][1].text

		self.logger.info(username + " is attempting to log in")
