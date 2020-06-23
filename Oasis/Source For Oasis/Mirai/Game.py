#!/usr/bin/env python
import sys
import ConfigParser
import json
import urllib2
import threading
import time
from copy import deepcopy
from twisted.internet.protocol import Factory
from twisted.internet import reactor
#from twisted_hang import HangWatcher
#from Core import OasisCleanUp
from Core import OasisClient
from Core import OasisCommands
from Core import OasisGames
from Core import OasisMySQL

config = ConfigParser.ConfigParser()
config.read('config.ini')


class OasisServer(Factory):

	def __init__(self, serverID):
		self.users = {}
		self.cachedIDs = {}
		self.cachedNames = {}
		self.nextID = 0
		print """\033[95m #######     ###     ######  ####  ######  
##     ##   ## ##   ##    ##  ##  ##    ## 
##     ##  ##   ##  ##        ##  ##       
##     ## ##     ##  ######   ##   ######  
##     ## #########       ##  ##        ## 
##     ## ##     ## ##    ##  ##  ##    ## 
 #######  ##     ##  ######  ####  ######  \033[0m"""
		print 'Mirai'
		print "\t->[AS2]Club Penguin Private Server Source"
		print "\t->Written by Tybone10"
		print "\t->Credits to Arthur and sam for part of the base"
		print "[Mirai] -> Starting Mirai..."
		print "[Mirai] -> Connecting to MySQL Database..."
		self.MySQL = OasisMySQL.OasisMySQL({'host': str(config.get('MySQL', 'host')), 'user': str(config.get('MySQL', 'user')), 'pass': str(config.get('MySQL', 'pass')), 'name': str(config.get('MySQL', 'name'))})
		server = self.MySQL.dbAPI.runQuery('SELECT * FROM `servers` WHERE `id` = (%s)', (str(serverID),))
		self.serverID = serverID
		server.addCallback(self._mysqlGotServers)
		self.roomMap = {}
		self.iglooMap = {}
		rooms = self.MySQL.dbAPI.runQuery('SELECT `roomID`, `roomKey`, `isModerator`, `isGame` FROM `rooms` WHERE type="normal"')
		rooms.addCallback(self._mysqlGotRooms)
		self.roomMap[0] = {'name': 'Mirai Start Room', 'membersOnly': False, 'moderatorOnly' : False, 'isGame': False, 'clients': {}}
		print '[Mirai] -> Setting up handlers...'
		self.onlineUsers = 0 #separate count so when we update the db, it doesnt include random connections
		self.handlerMap = {
		
			'zo'      : 'handleGameOver',

			'j#js'    : 'handleJoinServer',
			'j#jr'    : 'handleJoinRoom',
			'j#jp'    : 'handleJoinPlayerIgloo',
			
			'i#ai'    : 'handleAddItem',
			'i#gi'    : 'handleMyGetInventoryList',
			'i#qpa'   : 'handleQueryPlayerAwards',
			'i#aci'   : 'handleAddStoreItem',
			
			'l#mst'   : 'handleStartMailEngine',
			'l#mg'    : 'handleGetMail',
			
			'o#k'     : 'handleKickPlayer',
			'o#b'     : 'handleBanPlayer',
			'o#m'     : 'handleMutePlayer',
			'o#mduc'  : 'handleDisableUserTransforms',
			'o#mupn'  : 'handleUpdateNicknameMod',
			'o#mguc'  : 'handleGiveUserCredits',
			'o#mwu'   : 'handleWarnPlayer',
			'o#mdua'  : 'handleDisableUserAction',
			'o#smop'  : 'handleMoveOtherPlayer',
			'o#rmsg'  : 'handleRemoveMessage',
			
			'b#gb'    : 'handleGetBuddyList',
			'b#bf'    : 'handleGetPlayerLocationById',
			'b#br'    : 'handleBuddyRequest',
			'b#ba'    : 'handleBuddyAdd',
			'b#rb'    : 'handleBuddyRemove',
			
			'g#gr'    : 'handleGetIglooList',
			'g#gm'    : 'handleGetPlayerIgloo',
			'g#au'    : 'handleSendBuyIglooType',
			'g#ao'    : 'handleActivateIgloo',
			'g#af'    : 'handleBuyFurniture',
			'g#ag'    : 'handleBuyIglooFloor',
			'g#um'    : 'handleSendBuyIglooMusic',
			'g#ur'    : 'handleSaveIglooFurniture',
			'g#go'    : 'handleGetOwnedIgloos',
			'g#gf'    : 'handleGetFurniture',
			'g#or'    : 'handleOpenIgloo',
			'g#cr'    : 'handleCloseIgloo',
			
			"s#uph"   : "handleUpdatePlayerClothing",
			"s#upf"   : "handleUpdatePlayerClothing",
			"s#upn"   : "handleUpdatePlayerClothing",
			"s#upb"   : "handleUpdatePlayerClothing",
			"s#upa"   : "handleUpdatePlayerClothing",
			"s#upe"   : "handleUpdatePlayerClothing",
			"s#upl"   : "handleUpdatePlayerClothing",
			"s#upp"   : "handleUpdatePlayerClothing",
			"s#upc"   : "handleUpdatePlayerClothing",
			"s#uprac" : "handleUpdatePlayerClothing",
			's#umo'   : 'handleUpdateStatus',
			's#umod'  : 'handleUpdateStatusMod',
			's#uch'   : 'handleUpdateMyCharacter',
			's#scg'   : 'handleUpdateStatusColor',
			's#upcf'  : 'handleUpdatePlayerCardFace',
			's#upcc'  : 'handleUpdatePlayerCheeks',
			
			'u#glr'   : 'handleGetLastRevision',
			'u#h'     : 'handleHeartbeat',
			'u#sp'    : 'handleSendPlayerMove',
			'u#se'    : 'handleSendEmote',
			'u#sf'    : 'handlePlayerFrame',
			'u#sa'    : 'handlePlayerAction',
			'u#sj'    : 'handleSendJoke',
			'u#ss'    : 'handleSendSafeMessage',
			'u#sb'    : 'handleThrowBall',
			'u#gp'    : 'handleGetPlayer',
			'u#tp'    : 'handleTeleportPlayer',
			
			'm#sm'    : 'handleSendMessage',
			'm#pm'    : 'handleSendPrivateMessage',
			'm#r'     : 'handleReportPlayer',
			
			'p#pgu'   : 'handleGetMyPuffles',
			'p#pg'    : 'handleGetMyPuffles',
			'p#pm'    : 'handlePuffleMove',
			'p#ps'    : 'handlePuffleFrame',
			'p#pr'    : 'handlePuffleRest',
			'p#pb'    : 'handlePuffleBath',
			'p#pp'    : 'handlePufflePlay',
			'p#pf'    : 'handlePuffleFeed',
			'p#pw'    : 'handlePuffleWalk',
			'p#pt'    : 'handlePuffleTreat',
			'p#pn'    : 'handleAdoptPuffle',
			'p#ip'    : 'handlePuffleInteraction_PLAY',
			'p#ir'    : 'handlePuffleInteraction_REST',
			'p#if'    : 'handlePuffleInteraction_FEED',
			'p#pip'   : 'handlePuffleInitInteraction_PLAY',
			'p#pir'   : 'handlePuffleInitInteraction_REST',
			
			'po#snco' : 'handleSaveNewOutfit',
			'po#wsci' : 'handleWearOutfit',
			'po#dsci' : 'handleDeleteSavedClothes',
			'po#snpm' : 'handleSendNewPM',
			'po#did'  : 'handleDeleteItem',
			'po#ttfo' : 'handleToggleFindOption',
			
			'mnx#snl' : 'handleSendLikePlayer',
			'mnx#rrl' : 'handleRequestRelationship',
			'mnx#acr' : 'handleAcceptRelationship',
			'mnx#sdr' : 'handleAttemptDivorce',
			
			'f#epfga' : 'handleDummyEPF',
			'f#epfgr' : 'handleDummyEPF',
			'f#epfgf' : 'handleDummyEPF',
			'f#epfsa' : 'handleDummyEPF',
			
			'n#an'    : 'handleAddIgnore',
			'n#rn'    : 'handleRemoveIgnore',
			'n#gn'    : 'handleGetIgnoreList',
			
			'mr#wso'  : 'handleWearOutfit',
			'mr#sno'  : 'handleSaveNewOutfit',
			'mr#dso'  : 'handleDeleteOutfit',
			
			'tnbch#tnbchslide' : 'handleWaterSlide',
			'tnbch#tnbchshow'  : 'handleConcertTime'
			
		}
		print '[Mirai] -> Setting up commands...'
		self.commands  = OasisCommands.OasisCommands(self)
		#OasisCleanUp.OasisCleanUp(self)
		#watcher = HangWatcher() 
		#watcher.start()
		
	def _mysqlGotServers(self, result):
		if result == False:
			print 'Error retrieving server configuration from database for server ID: ' + str(self.serverID)
			sys.exit()
		print "\033[92m[Mirai] -> Successfully retrieved server " + str(self.serverID) + " (\"" + str(result[0][1]) + "\") from database\033[0m"
		self.maxUsers  = int(result[0][2])
		self.showBot   = bool(result[0][3])
		self.botString = str(result[0][4])
		self.ipAddrs   = {}
		try:
			self.modAuthKey   = json.loads(result[0][7])['keys']
			self.modAuthKey['kick']['authKey']
		except:
			print "\033[91m[Mirai] -> Unable to parse auth keys for web-tools\033[0m"
			print "\033[91m[Mirai] -> Shutting down...\033[0m"
			sys.exit()
		print "\033[92m[Mirai] -> Server \"" + str(result[0][1]) + "\" has been started on port " + str(config.get('GameServer1_' + str(self.serverID), 'port')) + ". Now accepting clients...\033[0m"
			
	def _mysqlGotRooms(self, result):
		if result == False:
			print 'Error retrieving server ROOM configuration from database: ' + str(self.serverID)
			sys.exit()
		print '[Mirai] -> Added a total of ' + str(len(result)) + ' rooms'
		for rid in result:
			try:
				rid[1]
			except:
				continue
			self.roomMap[int(rid[0])] = {'name': str(rid[1]), 'membersOnly': False, 'botHooks' : {}, 'moderatorOnly': bool(rid[2]), 'isGame': bool(rid[3]), 'clients': {}}
		return True

	def buildProtocol(self, addr):
		self.users[int(self.nextID)] = OasisClient.Oasis(self, addr, self.nextID)
		user = self.users[int(self.nextID)]
		self.nextID += 1
		return user
	
	def sendToID(self, id, send):
		for i in self.users:
			if self.users[i].ID == id:
				self.users[i].sendLine(send)
				return True
		return False
		
	def isOnline(self, ID):
		for i in self.users:
			if self.users[i].ID == ID:
				return True
		return False
		
	def refreshServerSettings(self):
		server = self.MySQL.dbAPI.runQuery('SELECT * FROM `servers` WHERE `id` = (%s)', (str(self.serverID),))
		server.addCallback(self._mysqlGotServerRefresh)
			
	def _mysqlGotServerRefresh(self, result):
		if result == False:
			return False
		server = result[0]
		self.maxUsers  = int(server[2])
		self.showBot   = bool(server[3])
		self.botString = str(server[4])
		try:
			self.modAuthKey   = json.loads(result[0][7])['keys']
			self.modAuthKey['kick']['authKey']
		except:
			print "\033[91m[Mirai] -> Unable to parse auth keys for web-tools\033[0m"
			print "\033[91m[Mirai] -> Setting auth-keys as {} to prevent breach...\033[0m"
			self.modAuthKey = {}
			
	
	def checkClients(self):
		print 'Checking clients...'
		recentTime = time.time() - 420
		x = 0
		for i in self.users.items():
			try: #------deepcopy------ copied old list and user no longer exists :>
				self.users[i[0]]
				self.users[i[0]].lastHeartbeat
			except:
				self.users.pop(i[0])
				continue
			if recentTime > self.users[i[0]].lastHeartbeat:
				x += 1
				print '[Mirai] ->#1 Removed client on cleanup: ' + str(self.users[i[0]].clientID) + ';' + str(self.users[i[0]].nickname)
				try:
					self.users[i[0]].connectionLost ('')
				except:
					print 'Failed to lose conn'
					continue
				continue
			elif self.users[i[0]].skipMe == True or self.users[i[0]] == False:
				x += 1
				print '[Mirai] ->#2 Removed client on cleanup: ' + str(self.users[i[0]].clientID) + ';' + str(self.users[i[0]].nickname)
				try:
					self.users[i[0]].connectionLost ('')
				except:
					print 'Failed to lose conn'
					continue
		print '[Mirai] -> Removed [' + str(x) + '] clients in client clean-up'
		
	def runCleanup(self):
		return (self.checkClients())

	def removeClient(self, id):
		if self.users.has_key (int(id)):
			self.users.pop(int(id))
			return True
		else:
			print '[Mirai] -> Users dict has no key for this user: ' + str(id)
			return False
	
	def __exit__(self):
		print 'Shutting down...'

try:
	float(sys.argv[1])
except:
	print 'Please enter a numeric server ID when starting the server... (nohup python Game.py 101) [' + str(sys.argv[1]) + ']'
	sys.exit()
OasisCL = OasisServer(sys.argv[1])
reactor.listenTCP(int(config.get('GameServer1_' + str(sys.argv[1]), 'port')), OasisCL)
if sys.argv[1] != '103':
	reactor.listenTCP(int(config.get('GameServer2_' + str(sys.argv[1]), 'port')), OasisCL)
reactor.run()