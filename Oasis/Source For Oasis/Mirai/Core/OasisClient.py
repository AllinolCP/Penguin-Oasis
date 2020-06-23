import random
import string
import time
import math
import hashlib
import copy
import datetime
import inspect
import pprint
import re
from lxml import etree
from time import strftime
from subprocess import call
from phpserialize import unserialize
from phpserialize import serialize
from twisted.protocols.basic import LineReceiver
class Oasis(LineReceiver):

	def __init__(self, OasisServer, addr, id):
		self.clientID       = int(id)
		self.ID 	        = 0
		self.loginName		= ''
		self.nickname		= ''
		self.requestedName  = ''
		self.password		= ''
		self.preBuddy		= ''
		self.hasNickChanged = False
		self.hasKickedConn  = False
		self.crumbs         = None
		self.hookedTo       = None
		self.inGame    	    = False
		self.isMuted   	    = False
		self.skipMe   	    = False
		self.canTransform   = True
		self.lastHeartbeat  = 0
		self.lastJoinRoom   = 0
		self.crumbSaved	    = False
		self.canFind	    = True
		self.roomID         = 0
		self.warnings		= 0
		self.frame          = 0
		self.pos            = {'x': 0, 'y': 0}
		self.parent         = OasisServer
		self.PEER 	        = {'ip' : addr.host, 'port': addr.port}
		self.delimiter      = chr(0)
		self.relationship   = {
			'requestID' : 0,
			'requestType' : 0
		}
		self.lastTimes      = {
			'joke'     : 0,
			'action'   : 0,
			'emote'    : 0,
			'joinRoom' : 0,
			'snowball' : 0,
			'message'  : 0,
			'pmPacket' : 0,
			'report'   : 0,
			'clothes'   : 0,
		}
		self.disabledActions = {
			'dance'    : False,
			'wave' 	   : False,
			'joke'     : False,
			'emote'    : False,
			'snowball' : False
		}
		
	def connectionMade(self):
		print '[Mirai] -> New Client Connected: ' + str(self.PEER['ip']) + ':' + str(self.PEER['port'])
		try:
			ip = self.parent.ipAddrs[str(self.PEER['ip'])]
		except:
			self.parent.ipAddrs[str(self.PEER['ip'])] = 0
			ip = self.parent.ipAddrs[str(self.PEER['ip'])]
		if ip > 5:
			self.connectionLost('')
			call(["csf", "-d", str(self.PEER['ip'])])
			print 'IP BANNING FOR DoS: ' + str(self.PEER['ip'])
			return False
		self.parent.ipAddrs[str(self.PEER['ip'])] += 1
		return

	def connectionLost(self, reason):
		self.skipMe = True
		if self.hasKickedConn == False:
			self.parent.ipAddrs[str(self.PEER['ip'])] -= 1
		if self.hookedTo != None:
			try:
				roomLink = self.parent.roomMap[int(self.hookedTo)]
				roomLink['botHooks'].pop(int(self.clientID))
			except:
				pass
		if self.inGame == True:
			self.parent.onlineUsers -= 1
			if self.hasNickChanged == False:
				self.parent.MySQL.dbAPI.runOperation('UPDATE accs SET crumbs=(%s), isOnline=0 WHERE ID=(%s);', (serialize(self.crumbs), self.ID))
			else:
				self.parent.MySQL.dbAPI.runOperation('UPDATE accs SET nickname=(%s), crumbs=(%s), isOnline=0 WHERE ID=(%s);', (self.nickname, serialize(self.crumbs), self.ID))
			if self.parent.roomMap.has_key(int(self.roomID)):
				if self.parent.roomMap[int(self.roomID)]['clients'].has_key(int(self.clientID)):
					self.parent.roomMap[int(self.roomID)]['clients'].pop(int(self.clientID))
					self.sendToRoom('%xt%rp%-1%' + str(self.ID) + '%', True)
			buddies = self.crumb('buddies')
			if buddies != False and len(buddies) != 0:
				for i in buddies:
					if self.isOnline(buddies[i]) == True:
						self.parent.sendToID(buddies[i], '%xt%bof%-1%' + str(self.ID) + '%')
			if self.parent.iglooMap.has_key((int(self.ID) + 1000)):
				self.parent.iglooMap.pop((int(self.ID) + 1000))
		try:
			self.transport.loseConnection()
		except:
			pass
		self.parent.removeClient(self.clientID)
		return
	
	def triggerSave(self):
		if self.hasNickChanged == False:
			self.parent.MySQL.dbAPI.runOperation('UPDATE accs SET crumbs=(%s), isOnline=0 WHERE ID=(%s);', (serialize(self.crumbs), self.ID))
		else:
			self.parent.MySQL.dbAPI.runOperation('UPDATE accs SET nickname=(%s), crumbs=(%s), isOnline=0 WHERE ID=(%s);', (self.nickname, serialize(self.crumbs), self.ID))
		return True

	def lineReceived(self, line):
		if(line == "<policy-file-request/>"):
			return self.sendLine("<cross-domain-policy><allow-access-from domain=\"*.mirai.so\" to-ports=\"*\" /></cross-domain-policy>");
		if(line[0:1] == '<'):
			data = etree.fromstring(line)
			data = data[0]
			if data is not None:
				action = data.get('action')
				if action == 'verChk':
					return self.sendLine("<msg t='sys'><body action='apiOK' r='0'></body></msg>");
				if action == 'kickPlayer':
					if data.get('authKey') == self.parent.modAuthKey['kick']['authKey'] and data.get('authUUID') == self.parent.modAuthKey['kick']['authUUID']:
						playerID = data.get('playerID')
						reason = data.get('kickReason')
						modID = data.get('modID')
						modName = data.get('modName')
						modIP = data.get('modIP')
						for i in self.parent.users:
							if str(self.parent.users[i].ID) == str(playerID):
								self.parent.MySQL.dbAPI.runOperation('INSERT INTO history (`playerid`, `actionid`, `modid`, `modname`, `date`, `ip`, `ip2`, `msg`) VALUES ((%s), 0,(%s), (%s), (%s),  (%s), (%s), (%s))', (playerID, modID, modName, strftime("%Y-%m-%d %H:%M"), self.parent.users[i].PEER['ip'], modIP, reason))
								self.parent.users[i].skipMe = True
								self.parent.users[i].sendLine('%xt%e%-1%5%' + str(modName) + '%' + str(reason) + '%')
								self.parent.users[i].connectionLost('')
								return True
						self.sendLine('<mnx_ADMIN><response action="kickPlayer" value="false"></response></mnx_ADMIN>')
					return True
				if action == 'disableAction':
					if data.get('authKey') == self.parent.modAuthKey['action']['authKey'] and data.get('authUUID') == self.parent.modAuthKey['action']['authUUID']:
						playerID = data.get('playerID')
						actionID = data.get('actionID')
						try:
							self.disabledActions[actionID]
						except:
							self.sendLine('<mnx_ADMIN><response action="disableAction" value="false|BAD_ACT"></response></mnx_ADMIN>')
							return False
						for i in self.parent.users:
							if str(self.parent.users[i].ID) == str(playerID):
								if self.parent.users[i].disabledActions[actionID]  == True:
									self.parent.users[i].disabledActions[actionID] = False
								else:
									self.parent.users[i].disabledActions[actionID] = True
								return True
						self.sendLine('<mnx_ADMIN><response action="disableAction" value="false"></response></mnx_ADMIN>')
					return True
				if action == 'warnPlayer':
					if data.get('authKey') == self.parent.modAuthKey['warn']['authKey'] and data.get('authUUID') == self.parent.modAuthKey['warn']['authUUID']:
						playerID = data.get('playerID')
						reason = data.get('warnReason')
						modID = data.get('modID')
						modName = data.get('modName')
						modIP = data.get('modIP')
						for i in self.parent.users:
							if str(self.parent.users[i].ID) == str(playerID):
								self.parent.MySQL.dbAPI.runOperation('INSERT INTO history (`playerid`, `actionid`, `modid`, `modname`, `date`, `ip`, `ip2`, `msg`) VALUES ((%s), 11, (%s), (%s), (%s),  (%s), (%s), (%s))', (playerID, modID, modName, strftime("%Y-%m-%d %H:%M"), self.parent.users[i].PEER['ip'], modIP, reason))
								self.parent.users[i].sendLine('%xt%e%-1%393%' + str(modName) + '%' + str(reason) + '%')
								return True
						self.sendLine('<mnx_ADMIN><response action="warnPlayer" value="false"></response></mnx_ADMIN>')
					return True
				if action == 'getRoom':
					if data.get('authKey') == self.parent.modAuthKey['room']['authKey'] and data.get('authUUID') == self.parent.modAuthKey['room']['authUUID']:
						roomID = data.get('roomID')
						try:
							roomLink = self.parent.roomMap[int(roomID)]
						except:
							self.sendLine('<mnx_ADMIN><response action="getRoom" value="false"></response></mnx_ADMIN>')
							return False
						roomStr = ''
						for  i in roomLink['clients']:
							roomStr += '#' + str(self.parent.users[i].ID) + '|' + str(self.parent.users[i].loginName) + '|' + str(self.parent.users[i].nickname)
						return self.sendLine('<mnx_ADMIN><response action="getRoom" value="' + roomStr + '"></response></mnx_ADMIN>')
					return True
				if action == 'viewChat':
					if data.get('authKey') == self.parent.modAuthKey['chat']['authKey'] and data.get('authUUID') == self.parent.modAuthKey['chat']['authUUID']:
						roomID = data.get('roomID')
						try:
							roomLink = self.parent.roomMap[int(roomID)]
						except:
							self.sendLine('<mnx_ADMIN><response action="viewChat" value="false"></response></mnx_ADMIN>')
							return False
						if self.hookedTo != None:
							try:
								oldRoomLink = self.parent.roomMap[int(self.hookedTo)]
								oldRoomLink['botHooks'].pop(int(self.clientID))
							except:
								pass
						#print 'Hooking to: ' + str(roomID)
						roomLink['botHooks'][int(self.clientID)] = self
						self.hookedTo = str(roomID)
						return self.sendLine('<mnx_ADMIN><response action="viewChat" value="true"></response></mnx_ADMIN>')
					return True
				if action == 'stopViewingChat':
					if data.get('authKey') == self.parent.modAuthKey['chat']['authKey'] and data.get('authUUID') == self.parent.modAuthKey['chat']['authUUID']:
						if self.hookedTo != None:
							try:
								roomLink = self.parent.roomMap[int(self.hookedTo)]
								roomLink['botHooks'].pop(int(self.clientID))
							except:
								pass
						self.hookedTo = None
						return self.sendLine('<mnx_ADMIN><response action="stopViewingChat" value="true"></response></mnx_ADMIN>')
					return True
				if action == 'banPlayer':
					if data.get('authKey') == self.parent.modAuthKey['ban']['authKey'] and data.get('authUUID') == self.parent.modAuthKey['ban']['authUUID']:
						playerID = data.get('playerID')
						reason = data.get('banReason')
						modID = data.get('modID')
						modName = data.get('modName')
						modIP = data.get('modIP')
						for i in self.parent.users:
							if str(self.parent.users[i].ID) == str(playerID):
								self.parent.MySQL.dbAPI.runOperation('INSERT INTO history (`playerid`, `actionid`, `modid`, `modname`, `date`, `ip`, `ip2`, `msg`) VALUES ((%s), 1,(%s), (%s), (%s),  (%s), (%s), (%s))', (playerID, modID, modName, strftime("%Y-%m-%d %H:%M"), self.parent.users[i].PEER['ip'], modIP, reason))
								self.parent.users[i].crumb('isBanned', True)
								self.parent.users[i].sendLine('%xt%e%-1%610%' + str(modName) + '%' + str(reason) + '%')
								self.parent.users[i].skipMe = True
								self.parent.users[i].connectionLost('')
								return True
						self.sendLine('<mnx_ADMIN><response action="banPlayer" value="false"></response></mnx_ADMIN>')
					return True
				if action == 'rndK':
					self.rndK = self.generaterndK();
					return self.sendLine("<msg t='sys'><body action='rndK' r='-1'><k>" + self.rndK + "</k></body></msg>");
				if action == 'login':
					if self.parent.maxUsers <= self.parent.onlineUsers:
						self.sendLine('%xt%e%-1%103%')
						self.connectionLost('')
						return True
					username = list(data)[0][0].text
					password = list(data)[0][1].text
					if username == '' or username == None:
						return self.sendLine('%xt%e%-1%100%')
					self.loginName = username
					self.password = password
					user = self.parent.MySQL.dbAPI.runQuery("SELECT * FROM `accs` WHERE `name` = (%s)", (username))
					user.addCallback(self._mysqlAuthSelf)
					return self.sendLine('%xt%ou%-1%' + str(self.parent.onlineUsers) + '%')
		if(line[0:1] == '%'):
			if(self.inGame == False and line[0:13] != '%xt%s%f#epfgf'):
				print '\033[93m[Mirai] -> Client ' + str(self.clientID) + ':' + str(self.PEER['ip']) + ' tried sending packet [' + str(line) + '] before logging in\033[0m'
				self.connectionLost('')
				return False
			allData = line.split('\0')
			for data in allData:
				if data is None or data == '':
					continue
				sData = data.split('%')
				try:
					self.parent.handlerMap[str(sData[3])]
				except:
					self.handleUnknownPacket(sData, line)
					continue
				handler = getattr(self, self.parent.handlerMap[str(sData[3])], 'handleUnknownPacket')
				if handler != False:
					#print 'RECEIVED: ' + str(line) + ' - GOING TO: ' + self.parent.handlerMap[str(sData[3])]
					handler(sData, line)
					
				continue
	
	def _mysqlAuthSelf(self, result):
		username = self.loginName
		if result == False or result == None:
			print '\033[93m[Mirai] -> ' + str(username) + ':' + str(self.PEER['ip']) + ' entered an unknown penguin\033[0m'
			return self.sendLine('%xt%e%-1%100%')
		user = result[0]
		try:
			user[10]
		except:
			return self.sendLine('%xt%e%-1%0%')
		if user == False:
			print '\033[93m[Mirai] -> ' + str(username) + ':' + str(self.PEER['ip']) + ' entered an unknown penguin\033[0m'
			return self.sendLine('%xt%e%-1%100%')
		password = self.password
		if self.hashPassword(user[10], self.rndK) != password and password[64:] != user[10]:
			print '\033[93m[Mirai] -> ' + str(username) + ':' + str(self.PEER['ip']) + ' failed to identify themselves[' + str(user[10]) + '\033[0m'
			return self.sendLine('%xt%e%-1%101%')
		print '\033[92m[Mirai] -> ' + str(user[1]) + ':' + str(self.PEER['ip']) + ' successfully identified themselves\033[0m'
		self.showRWarn = bool(user[12])
		mKey = hashlib.md5(user[1] + '9#UFJ89rhIHI@Uh*(U*O#HJ83ha89rh8r9hrufIHJ*(').hexdigest()
		self.parent.MySQL.dbAPI.runOperation('UPDATE `accs` SET lastLogin = (%s), loginKey = (%s), lastIP = (%s),showWarning=0,mKey=(%s),isOnline=1 WHERE ID = (%s)', (round(time.time()), '76R84YOTHG39R0GYH4W8O', self.PEER['ip'], mKey, user[0]))
		try:
			crumbs = unserialize(user[5])
			crumbs['isBanned']
		except:
			print '\033[93m[Mirai] -> ' + str(username) + ':' + str(self.PEER['ip']) + '\'s crumbs are cted\033[0m'
			return self.sendLine('%xt%e%-1%10005%')
		if(bool(crumbs['isBanned']) == True):
			print '\033[93m[Mirai] -> ' + str(username) + ':' + str(self.PEER['ip']) + ' logged into a banned penguin\033[0m'
			return self.sendLine('%xt%e%-1%603%')
		self.crumbs    = crumbs
		self.ID        = int(user[0])
		self.loginName = str(user[1])
		self.nickname  = str(user[2])
		self.inGame    = True
		self.parent.onlineUsers += 1
		self.lastJoinRoom  = time.time()
		self.lastHeartbeat = time.time()
		self.parent.ipAddrs[str(self.PEER['ip'])] -= 1
		self.hasKickedConn  = True
		return self.sendLine('%xt%l%-1%' + str(mKey) + '%')
		
	def handleUnknownPacket(self, sData, pString):
		print '\033[93m[Mirai] -> Unknown packet sent to the server: ' + str(pString) + ' from ' + str(self.PEER['ip']) + '\033[0m'
		return True
		
	def handleHeartbeat(self, sData, pString):
		self.lastHeartbeat = time.time()
		return self.sendLine('%xt%h%-1%')
		
	def handleJoinServer(self, sData, pString):
		self.sendLine('%xt%js%-1%1%1%' + ('1' if self.crumb('isModerator') == True else '0') + '%')
		self.sendLine('%xt%gps%-1%%')
		emotePacks = ''
		oP = self.crumb('emotePacks')
		for i in oP:
			emotePacks += str(oP[i]['name']) + '^' + str(oP[i]['pageInt']) + '$'
		if self.crumb('hasSC') and self.crumb('snowballColor') != '0':
			sc = str(self.crumb('snowballColor'))
		else:
			sc = ''
		if self.crumb('hasSpeed') and self.crumb('speed') != '0':
			sp = (self.crumb('speed'))
		else:
			sp = ''
		whoILiked = ''
		for i in self.crumb('whoILiked'):
			whoILiked += ('|' + str(i))
		self.sendLine('%xt%lp%-1%' + str(self.buildString()) + '%' + str(self.crumb('coins')) + '%0%1440%' + str(time.time()) + '%' + str(math.floor((time.time() - self.crumb("registertime")) / 86400)) + '%1000%233%%7%' + str(emotePacks) + '%' + str(self.crumb('credits')) + '%' + str(sp) + '%' + str(sc) + '%' + ('1' if self.crumb('hasSTC') == True else '0') + '%' + ('1' if self.crumb('hasPGF') == True else '0') + '%' + ('1' if self.crumb('hasNG') == True else '0') + '%' + ('1' if self.crumb('hasBC') == True else '0') + '%' + ('1' if self.crumb('hasRC') == True else '0') + '%' + ('1' if self.crumb('hasSC') == True else '0') + '%' + ('1' if self.crumb('hasSpeed') == True else '0') + '%' + whoILiked + '%')
		self.getAndSendSavedOutfits()
		self.handleGetMyPuffles({3: 'p#pgu', 5: self.ID}, '')
		if self.showRWarn == True:
			self.sendLine('%xt%gs%-1%BIG%Warning<br>A moderator has warned you for sending false reports. If you continue to do so, you will be banned forever.%Okay%WARN%')
		return True
		
	def handleSaveNewOutfit(self, sData, pString):
		try:
			sData[5]
			sData[14]
		except:
			return False
		i = 5
		oStr = ''
		while i <= 14:
			if i == 5:
				i += 1
				continue
			oStr += '|' + str(sData[i])
			if self.is_numeric(sData[i]) == False:
				return False
			i += 1
		if sData[5] == '':
			sData[5] = 'Untitled'
		try:
			sData[5][0:2]
		except:
			sData[5] = 'Untitled'
		self.parent.MySQL.dbAPI.runOperation('INSERT INTO `savedOutfits` ( `playerID`, `outfitString`, `outfitName` ) VALUES ((%s), (%s), (%s))', (self.ID, oStr[1:], sData[5]))
		self.getAndSendSavedOutfits()
		return True
		
	def handleWearOutfit(self, sData, pString):
		#color, head, face, neck, body, hand, feet, flag, photo
		try:
			sData[5]
			sData[13]
		except:
			return False
		i = 5
		while i <= 13:
			if self.is_numeric(sData[i]) == False:
				return False
			i += 1
		self.setOutfit(sData[5], sData[6],  sData[7],  sData[8],  sData[9],  sData[10],  sData[11],  sData[12],  sData[13])
		return True
	
	def handleDeleteOutfit(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		self.parent.MySQL.dbAPI.runOperation('DELETE FROM `savedOutfits` WHERE `id` = (%s) AND playerID = (%s)', (sData[5], self.ID))
		self.getAndSendSavedOutfits()
		return True
		
	def handleJoinRoom(self, sData, pString):
		try:
			roomID = sData[5]
			x = sData[6]
			y = sData[7]
		except:
			roomID = 800
			x = 0
			y = 0
		return self.joinRoom(roomID, x, y)
		
		
	def handleJoinPlayerIgloo(self, sData, pString):
		try:
			roomID = sData[5]
		except:
			return False
		x = 0
		y = 0
		return self.joinIgloo(roomID, x, y)
		
	def handleMyGetInventoryList(self, sData, pString):
		invStr = ''
		items = self.crumb('items')
		for i in items:
			if self.is_numeric(items[i]):
				invStr += str(items[i]) + '%'
		return self.sendLine('%xt%gi%-1%' + invStr)
		
	def handleStartMailEngine(self, sData, pString):
		return self.sendLine('%xt%mst%-1%0%1%')
	
	def handleGetMail(self, sData, pString):
		return self.sendLine('%xt%mg%-1%%')
	
	def handleGetMyPuffles(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		str_ = '%xt%' + str(sData[3].split('#')[1]) + '%-1%' + str(self.getPufflesById(str(sData[5]))) + '%'
		return self.sendLine(str_)
		
	def handleGetLastRevision(self, sData, pString):
		return self.sendLine('%xt%glr%-1%3239%')
		
	def handlePlayerFrame(self, sData, pString):
		if self.disabledActions['dance'] == True:
			return False
		try:
			sData[5]
		except:
			return False
		self.frame = sData[5]
		return self.sendToRoom('%xt%sf%-1%' + str(self.ID) + '%' + str(sData[5]) + '%', True)
		
	def handlePuffleMove(self, sData, pString):
		try:
			sData[5]
			sData[6]
			sData[7]
		except:
			return False
		return self.sendToRoom('%xt%pm%-1%' + str(sData[5]) + '%' + str(sData[6]) + '%' + str(sData[7]) + '%')
		
	def handlePuffleFrame(self, sData, pString):
		try:
			sData[5]
			sData[6]
		except:
			return False
		return self.sendToRoom('%xt%ps%-1%' + str(sData[5]) + '%' + str(sData[6]) + '%')
		
	def handlePuffleBath(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		return self.sendToRoom('%xt%pb%-1%' + str(sData[5]) + '|0|0|100|100|100%1%')
		
	def handlePuffleRest(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		return self.sendToRoom('%xt%pr%-1%' + str(sData[5]) + '|0|0|100|100|100%1%')
		
	def handlePufflePlay(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		return self.sendToRoom('%xt%pp%-1%' + str(sData[5]) + '|0|0|100|100|100%' + str(random.randrange(3)) + '%')
		
	def handlePuffleWalk(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		return self.sendToRoom('%xt%pw%-1%' + str(self.ID) + '%' + str(sData[5]) + '||||||||||||1|%')
		
	def handleSendEmote(self, sData, pString):
		if self.disabledActions['emote'] == True:
			return False
		if self.isMuted == True:
			return False
		if self.lastTimes['emote'] > time.time():
			return False
		self.lastTimes['emote'] = (time.time() + 2)
		return self.sendToRoom('%xt%se%-1%' + str(self.ID) + '%' + str(sData[5]) + '%')
		
	def handleSendSafeMessage(self, sData, pString):
		if self.isMuted == True:
			return False
		return self.sendToRoom('%xt%ss%-1%' + str(self.ID) + '%' + str(sData[5]) + '%')
		
	def handleReportPlayer(self, sData, pString):
		if self.lastTimes['report'] > time.time():
			print "The user " + str(self.nickname) + " [" + str(self.PEER['ip']) + "] has attempted to report others too fast."
			return False
		self.lastTimes['report'] = (time.time() + 5)
		for i in self.parent.users:
			if self.parent.users[i].crumb('isModerator') == True:
				self.parent.users[i].sendLine('%xt%hnr%-1%' + str(sData[7]) + '%' + str(self.nickname) + '%' + str(sData[6]) + '%' + str(self.roomID) + '%')
		return True
		
	def handleSendMessage(self, sData, pString):
		try:
			sData[5]
			sData[6]
			sData[7]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		if self.isMuted == True:
			return False
		if self.lastTimes['message'] > time.time():
			return False
		if str(sData[6]) != str(self.ID):
			print 'Client: ' + str(self.ID) + ':' + str(self.loginName) + ' attempted to send a message with this ID: ' + str(sData[6]) + ':' + str(sData[7]) + '--- IP banning!'
			self.connectionLost('')
			call(["csf", "-d", str(self.PEER['ip'])])
			return False
		self.lastTimes['message'] = (time.time() + 1)
		if sData[7].__len__() < 1:
			return False
		if sData[7].__len__() > 110 and self.crumb('isModerator') == False:
			return False
		if sData[7][0:1] == '!':
			try:
				command = self.parent.commands.runCommand(sData[7], self)
			except:
				command = False
				print str(sData[7]) + ' command failed'
			if command != 'NO_CMD':
				return True
		return self.sendToRoom('%xt%sm%' + str(sData[5]) + '%' + str(sData[6]) + '%' + str(sData[7]) + '%', True)
		
	def handleSendPrivateMessage(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		try:
			sData[6]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(sData[5]):
				self.parent.users[i].sendLine('%xt%pm%-1%' + str(self.ID) + '%' + str(self.nickname) + '%' + str(sData[6]) + '%')
				return True
		return False
	
	def handleKickPlayer(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		try:
			reason = sData[6]
		except:
			reason = ''
		if self.crumb('isModerator') == False:
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(sData[5]):
				self.parent.MySQL.dbAPI.runOperation('INSERT INTO history (`playerid`, `actionid`, `modid`, `modname`, `date`, `ip`, `ip2`, `msg`) VALUES ((%s), 0, (%s), (%s), (%s),  (%s), (%s), (%s))', (sData[5], self.ID, self.loginName, strftime("%Y-%m-%d %H:%M"), self.parent.users[i].PEER['ip'], self.PEER['ip'], reason))
				self.parent.users[i].skipMe = True
				self.parent.users[i].sendLine('%xt%e%-1%5%' + str(self.loginName) + '%' + str(reason) + '%')
				self.parent.users[i].connectionLost('')
				return True
	
	def handleBanPlayer(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		try:
			reason = sData[6]
		except:
			reason = ''
		if self.crumb('isModerator') == False:
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(sData[5]):
				self.parent.MySQL.dbAPI.runOperation('INSERT INTO history (`playerid`, `actionid`, `modid`, `modname`, `date`, `ip`, `ip2`, `msg`) VALUES ((%s), 1, (%s), (%s), (%s),  (%s), (%s), (%s))', (sData[5], self.ID, self.loginName, strftime("%Y-%m-%d %H:%M"), self.parent.users[i].PEER['ip'], self.PEER['ip'], reason))
				self.parent.users[i].sendLine('%xt%e%-1%610%' + str(self.loginName) + '%' + str(reason) + '%')
				self.parent.users[i].crumb('isBanned', True)
				self.parent.users[i].skipMe = True
				self.parent.users[i].connectionLost('')
				return True
	
	def handleWarnPlayer(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		try:
			reason = sData[6]
		except:
			reason = 'Breaking the rules'
		if self.crumb('isModerator') == False:
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(sData[5]):
				self.parent.MySQL.dbAPI.runOperation('INSERT INTO history (`playerid`, `actionid`, `modid`, `modname`, `date`, `ip`, `ip2`, `msg`) VALUES ((%s), 11, (%s), (%s), (%s),  (%s), (%s), (%s))', (sData[5], self.ID, self.loginName, strftime("%Y-%m-%d %H:%M"), self.parent.users[i].PEER['ip'], self.PEER['ip'], reason))
				self.parent.users[i].sendLine('%xt%e%-1%393%' + str(self.loginName) + '%' + str(reason) + '%')
				return True
	
	def handleMutePlayer(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		if self.crumb('isModerator') == False:
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(sData[5]):
				if self.parent.users[i].isMuted == False:
					self.parent.users[i].isMuted = True
				else:
					self.parent.users[i].isMuted = False
				return True
	
	def handleDeleteItem(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		items = self.crumb('items')
		for i in items:
			if str(items[i]) == str(sData[5]):
				try:
					items.pop(i)
				except:
					print 'Error deleting user item: ' + str(sData[5])
				return True
		self.crumb('items', items)
		return True
		
	def handleSendLikePlayer(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		if str(sData[5]) in self.crumb('whoILiked'):
			return False
		for i in self.parent.users:
			if str(sData[5]) == str(self.parent.users[i].ID):
				if str(self.PEER['ip']) == str(self.parent.users[i].PEER['ip']):
					if self.ID != 1 and self.ID != 29:
						return self.sendLine('%xt%e%-1%3%')
				self.parent.users[i].crumb('likes', self.parent.users[i].crumb('likes') + 1)
				lis = self.crumb('whoILiked')
				lis[(str(sData[5]))] = (str(sData[5]))
				self.crumb('whoILiked', lis)
				self.sendToRoom('%xt%snl%-1%' + str(sData[5]) + '%' + str(self.parent.users[i].crumb('likes')) + '%')
				return True
		return True
	
	def handleGiveUserCredits(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		try:
			amt = sData[6]
		except:
			amt = ''
		if self.is_numeric(amt) == False:
			return False
		if amt > 5000:
			if self.crumb('isAdmin') == False:
				return False
		if self.crumb('isModerator') == False:
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(sData[5]):
				self.parent.users[i].crumb('credits', int(self.parent.users[i].crumb('credits')) + int(amt))
				self.parent.users[i].sendLine('%xt%umcr%-1%' + str(self.nickname) + '%' + str(amt) + '%')
				self.parent.MySQL.dbAPI.runOperation('INSERT INTO history (`playerid`, `actionid`, `modid`, `modname`, `date`, `ip`, `ip2`, `msg`) VALUES ((%s), 10, (%s), (%s), (%s),  (%s), (%s), (%s))', (sData[5], self.ID, self.loginName, strftime("%Y-%m-%d %H:%M"), self.parent.users[i].PEER['ip'], self.PEER['ip'], amt))
				return True
		return False
		
	def handleSendJoke(self, sData, pString):
		if self.disabledActions['joke'] == True:
			return False
		if self.lastTimes['joke'] > time.time():
			return False
		self.lastTimes['joke'] = (time.time() + 5)
		return self.sendToRoom('%xt%sj%-1%' + str(self.ID) + '%' + str(sData[5]) + '%')
		
	def handleThrowBall(self, sData, pString):
		try:
			sData[5]
			sData[6]
		except:
			return False
		if self.disabledActions['snowball'] == True:
			return False
		if self.lastTimes['snowball'] > time.time():
			return False
		self.lastTimes['snowball'] = (time.time() + 2)
		if self.crumb('hasSC') and self.crumb('snowballColor') != '0':
			return self.sendToRoom('%xt%sb%-1%' + str(self.ID) + '%' + str(sData[5]) + '%' + str(sData[6]) + '%' + str(self.crumb('snowballColor')) + '%')
		return self.sendToRoom('%xt%sb%-1%' + str(self.ID) + '%' + str(sData[5]) + '%' + str(sData[6]) + '%')
		
	def handlePlayerAction(self, sData, pString):
		if self.disabledActions['wave'] == True:
			return False
		if self.lastTimes['action'] > time.time():
			return False
		self.lastTimes['action'] = (time.time() + 3)
		return self.sendToRoom('%xt%sa%-1%' + str(self.ID) + '%' + str(sData[5]) + '%', True)
		
	def handleDummyEPF(self, sData, pString):
		return self.sendLine('%xt%' + str(sData[3].split('#')[1]) + '%-1%0%')
	
	def handleOpenIgloo(self, sData, pString):
		self.parent.iglooMap[int(self.ID) + 1000] = str(self.nickname)
		return True
	
	def handleCloseIgloo(self, sData, pString):
		try:
			self.parent.iglooMap.pop(int(self.ID) + 1000)
		except:
			return false
		return True
		
	def handleGetIglooList(self, sData, pString):
		iL = self.parent.iglooMap
		iglooList = ''
		for i in iL:
			iglooList += '%' + str(i-1000) + '|' + str(iL[i])
		return self.sendLine('%xt%gr%-1' + str(iglooList) + '%')
	
	def handleGetPlayerIgloo(self, sData, pString):
		try:
			sData[5]
		except:
			return self.joinRoom(100, 0, 0)
		if self.is_numeric(sData[5]) == False:
			return self.joinRoom(100, 0, 0)
		igloo = self.parent.MySQL.dbAPI.runQuery("SELECT `playerID`, `currentIgloo`, `currentMusic`, `iglooFurniture` FROM `igloos` WHERE playerID = (%s)", (sData[5]))
		igloo.addCallback(self._mysqlGotIgloo)
		return True
	
	def _mysqlGotIgloo(self, result):
		if result == False or result == None:
			return self.joinRoom(100, 0, 0)
		try:
			result[0][0]
		except:
			return self.joinRoom(100, 0, 0)
		iglooString = str(result[0][0]) + '%' + str(result[0][1]) + '%' + str(result[0][2]) + '%0%' + str(result[0][3])
		return self.sendLine('%xt%gm%-1%' + str(iglooString) + '%0%')
		
	def handleSendBuyIglooType(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		igloo = self.parent.MySQL.dbAPI.runOperation("UPDATE `igloos` SET currentIgloo = (%s) WHERE playerID = (%s)", (sData[5], self.ID))
		self.sendLine('%xt%au%-1%' + str(sData[5]) + '%' + str(self.crumb('coins')) + '%')
		return True
		
	def handleBuyIglooFloor(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		self.sendLine('%xt%ag%-1%0%' + str(self.crumb('coins')) + '%')
		return True
		
	def handleSendBuyIglooMusic(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		self.crumb('music', sData[5])
		igloo = self.parent.MySQL.dbAPI.runOperation("UPDATE `igloos` SET currentMusic = (%s) WHERE playerID = (%s)", (sData[5], self.ID))
		self.sendLine('%xt%um%-1%' + str(sData[5]) + '%' + str(self.crumb('coins')) + '%')
		return True
		
	def handleSaveIglooFurniture(self, sData, pString):
		fStr = ''
		si = 0
		for i in sData:
			if si > 4:
				fStr += str(i) + ','
			si += 1
		igloo = self.parent.MySQL.dbAPI.runOperation("UPDATE `igloos` SET iglooFurniture = (%s) WHERE playerID = (%s)", (fStr, self.ID))
		self.sendLine('%xt%ur%-1%')
		return True
		
	def handleGetOwnedIgloos(self, sData, pString):
		iglooStr = ''
		igloos = self.crumb('igloos')
		if igloos == False:
			self.crumb('igloos', [1])
			igloos = [1]
		for i in igloos:
			iglooStr += '|' + str(i)
		return self.sendLine('%xt%go%-1%' + str(iglooStr[1:]) + '%')
		
	def handleGetFurniture(self, sData, pString):
		furnStr = ''
		furn = self.crumb('furniture')
		for i in furn:
			furnStr += '%' + str(i) + '|' + str(furn[i])
		return self.sendLine('%xt%gf%-1' + str(furnStr) + '%')
		
	def handleRequestRelationship(self, sData, pString):
		try:
			sData[5]
			sData[6]
		except:
			return False
		if self.is_numeric(sData[6]) == False:
			return False
		if self.crumb('isInRelationship') == True:
			return False
		if int(sData[6]) == int(self.ID):
			print str(self.nickname) + ':' + str(self.ID) + ' tried marry/bffing themselves'
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(sData[6]):
				user = self.parent.users[i]
				if user.crumb('isInRelationship') == True:
					return False
				user.relationship['requestID'] = self.ID
				user.relationship['requestType'] = ('1' if str(sData[5]) == 'marriage' else '2')
				user.sendLine('%xt%rrl%-1%' + ('1' if str(sData[5]) == 'marriage' else '2') + '%' + str(self.ID) + '%' + str(self.nickname) + '%')
				return True
		return True
		
	def handleAcceptRelationship(self, sData, pString):
		if self.crumb('isInRelationship') == True:
			return False
		if self.relationship['requestID'] == 0:
			return False
		if self.relationship['requestType'] != '1' and self.relationship['requestType'] != '2':
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(self.relationship['requestID']):
				user = self.parent.users[i]
				if user.crumb('isInRelationship') == True:
					self.sendLine('%xt%note%-1%Sorry! This user has already found a new relationship.%')
					return False
				self.crumb('isInRelationship', True)
				self.crumb('relationshipType', self.relationship['requestType'])
				self.crumb('relationshipWith', user.nickname)
				self.crumb('relationshipWithID', user.ID)
				user.crumb('isInRelationship', True)
				user.crumb('relationshipType', self.relationship['requestType'])
				user.crumb('relationshipWith', self.nickname)
				user.crumb('relationshipWithID', self.ID)
				self.relationship['requestID'] = 0
				self.relationship['requestType'] = 0
				user.relationship['requestID'] = 0
				user.relationship['requestType'] = 0
				user.sendLine('%xt%note%-1%' + str(self.nickname) + ' has accepted your relationship request! Re-join the room to see the change.%')
				self.sendLine('%xt%note%-1%Congratulations! Re-join the room to see the relationship status on your playercard.%')
				return True
		return True
		
	def handleAttemptDivorce(self, sData, pString):
		if self.crumb('isInRelationship') == False:
			return False
		relID = self.crumb('relationshipWithID')
		if relID == 0 or self.is_numeric(relID) == False:
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(relID):
				user = self.parent.users[i]
				self.crumb('isInRelationship', False)
				self.crumb('relationshipType', 0)
				self.crumb('relationshipWith', '')
				self.crumb('relationshipWithID', 0)
				if user.crumb('isInRelationship') == True and user.crumb('relationshipWithID') == self.ID:
					user.crumb('isInRelationship', False)
					user.crumb('relationshipType', self.relationship['requestType'])
					user.crumb('relationshipWith', self.nickname)
					user.sendLine('%xt%note%-1%Sorry... ' + str(self.nickname) + ' has just divorced you.%')
				self.sendLine('%xt%note%-1%Congratulations! Your divorce has been approved and you are now single!%')
				return True
		self.sendLine('%xt%note%-1%Divorcing... Please wait while we finish divorcing you two.%')
		user = self.parent.MySQL.dbAPI.runQuery("SELECT `ID`, `crumbs` FROM `accs` WHERE ID = (%s)", (self.crumb('relationshipWithID')))
		user.addCallback(self._mysqlGotUserForDivorce)
		return True
		
	def _mysqlGotUserForDivorce(self, result):
		if result == False or result == None:
			return False
		try:
			result[0][1]
		except:
			print 'Divorce error: ' + str(result)
			self.sendLine('%xt%note%-1%Error! There was an error divorcing this user... Try again.%')
			return False
		self.crumb('isInRelationship', False)
		self.crumb('relationshipType', 0)
		self.crumb('relationshipWith', '')
		self.crumb('relationshipWithID', 0)
		self.sendLine('%xt%note%-1%Congratulations! Your divorce has been approved and you are now single!%')
		crumbs = unserialize(result[0][1])
		crumbs['isInRelationship'] = False
		crumbs['relationshipWithID'] = 0
		crumbs['relationshipType'] = 0
		crumbs['relationshipWith'] = ''
		self.parent.MySQL.dbAPI.runOperation("UPDATE `accs` SET crumbs = (%s) WHERE ID = (%s)", (serialize(crumbs), result[0][0]))
		return True
		
	def handleActivateIgloo(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		igloo = self.parent.MySQL.dbAPI.runOperation("UPDATE `igloos` SET currentIgloo = (%s),iglooFurniture='',currentMusic=0 WHERE playerID = (%s)", (sData[5], self.ID))
		self.sendLine('%xt%ao%-1%')
		return True
		
	def handleBuyFurniture(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		self.addFurniture(sData[5])
		return True
		
	def handleGetBuddyList(self, sData, pString):
		return self.getBuddyList()
		
	def handleGetIgnoreList(self, sData, pString):
		return self.getIgnoreList()
		
	def handleQueryPlayerAwards(self, sData, pString):
		roomID = random.choice([801, 800, 110, 802, 803, 310, 340, 805, 200])
		self.joinRoom(int(roomID), '0', '0')
		return self.sendLine('%xt%qpa%-1%%')
	
	def handleUpdatePlayerClothing(self, sData, pString):
		if sData[3] == 's#uprac':
			return self.setOutfit(0, 0, 0, 0, 0, 0, 0, 0, 0)
		try:
			sData[5]
		except:
			return False
		if self.lastTimes['clothes'] > time.time():
			print "The user " + str(self.nickname) + " [" + str(self.PEER['ip']) + "] has attempted to change their clothing too fast."
			return False
		self.lastTimes['clothes'] = (time.time() + 1)
		if self.is_numeric(sData[5]) == False:
			if sData[3] == 's#upc':
				valid = re.match('^[\w-]+$', s[1]) is not None
				if valid == False:
					return False
			else:
				return False
		if sData[3] == 's#upc':
			self.crumb('color', sData[5])
		elif sData[3] == 's#uph':
			self.crumb('head', sData[5])
		elif sData[3] == 's#upf':
			self.crumb('face', sData[5])
		elif sData[3] == 's#upn':
			self.crumb('neck', sData[5])
		elif sData[3] == 's#upb':
			self.crumb('body', sData[5])
		elif sData[3] == 's#upa':
			self.crumb('hands', sData[5])
		elif sData[3] == 's#upe':
			self.crumb('feet', sData[5])
		elif sData[3] == 's#upl':
			self.crumb('pin', sData[5])
		elif sData[3] == 's#upp':
			self.crumb('photo', sData[5])
		else:
			return False
		self.sendToRoom('%xt%' + sData[3].split('#')[1] + '%-1%' + str(self.ID) + '%' + str(sData[5]) + '%')
		return True
		
	def handleSendNewPM(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.lastTimes['pmPacket'] > time.time():
			self.warnings += 1
			if self.warnings > 5:
				self.connectionLost('')
				print 'IP Banning: ' + str(self.loginName) + ':' + str(self.PEER['ip']) + ' for spamming PM packet!'
				call(["csf", "-d", str(self.PEER['ip'])])
			return False
		self.warnings = 0
		self.lastTimes['pmPacket'] = (time.time() + 3)
		for i in self.parent.users:
			if str(self.parent.users[i].nickname.lower()) == str(sData[5].lower()):
				self.parent.users[i].sendLine('%xt%gnpm%-1%')
				return True
		return True
		
	def handleWaterSlide(self, sData, pString):
		return self.sendToRoom('%xt%tnbchslide%-1%' + str(self.ID) + '%' + str(sData[5]) + '%')
		
	def handleUpdateStatus(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		self.crumb('mood', str(sData[5].replace('|', '')))
		self.sendToRoom('%xt%umo%-1%' + str(self.ID) + '%' + str(self.crumb('mood')) + '%', True)
		return True
		
	def handleUpdateMyCharacter(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		if self.canTransform == False:
			return False
		self.crumb('character', sData[5])
		self.sendToRoom('%xt%uch%-1%' + str(self.ID) + '%' + str(self.crumb('character')) + '%')
		return True
		
	def handleUpdatePlayerCardFace(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		if self.crumb('hasPGF') == False:
			return False
		if self.crumb('pengFace') == sData[5]:
			return False
		self.crumb('pengFace', sData[5])
		self.sendToRoom('%xt%upcf%-1%' + str(self.ID) + '%' + str(self.crumb('pengFace')) + '%')
		return True
		
	def handleUpdateStatusMod(self, sData, pString):
		try:
			sData[5]
			sData[6]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		if self.crumb('isModerator') == False:
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(sData[5]):
				self.parent.users[i].crumb('mood', str(sData[6].replace('|', '')))
				self.sendToRoom('%xt%umo%-1%' + str(sData[5]) + '%' + self.parent.users[i].crumb('mood') + '%')
				self.parent.MySQL.dbAPI.runOperation('INSERT INTO history (`playerid`, `actionid`, `modid`, `modname`, `date`, `ip`, `ip2`, `msg`) VALUES ((%s), 39, (%s), (%s), (%s),  (%s), (%s), (%s))', (sData[5], self.ID, self.loginName, strftime("%Y-%m-%d %H:%M"), self.parent.users[i].PEER['ip'], self.PEER['ip'], sData[6]))
				return True
		return True
		
	def handleUpdateNicknameMod(self, sData, pString):
		try:
			sData[5]
			sData[6]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		if self.crumb('isModerator') == False:
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(sData[5]):
				self.parent.users[i].nickname = sData[6]
				self.parent.users[i].hasNickChanged = True
				self.sendToRoom('%xt%upun%-1%' + str(sData[5]) + '%' + str(sData[6]) + '%')
				self.parent.MySQL.dbAPI.runOperation('INSERT INTO history (`playerid`, `actionid`, `modid`, `modname`, `date`, `ip`, `ip2`, `msg`) VALUES ((%s), 38, (%s), (%s), (%s),  (%s), (%s), (%s))', (sData[5], self.ID, self.loginName, strftime("%Y-%m-%d %H:%M"), self.parent.users[i].PEER['ip'], self.PEER['ip'], sData[6]))
				return True
		return True
		
	def handleMoveOtherPlayer(self, sData, pString):
		try:
			sData[5]
			sData[6]
			sData[7]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		if self.is_numeric(sData[6]) == False:
			return False
		if self.is_numeric(sData[7]) == False:
			return False
		if self.crumb('isModerator') == False:
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(sData[5]):
				self.parent.users[i].sendLine('%xt%smop%-1%' + str(sData[6]) + '%' + str(sData[7]) + '%')
				return True
		return True
		
	def handleDisableUserTransforms(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		if self.crumb('isModerator') == False:
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(sData[5]):
				if self.parent.users[i].canTransform  == True:
					self.parent.users[i].canTransform = False
					self.parent.users[i].crumb('character', 0)
					self.sendToRoom('%xt%uch%-1%' + str(sData[5]) + '%0%')
				else:
					self.parent.users[i].canTransform = True
				return True
		return True
		
	def handleDisableUserAction(self, sData, pString):
		try:
			sData[5]
			sData[6]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		if self.crumb('isModerator') == False:
			return False
		try:
			self.disabledActions[sData[6]]
		except:
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(sData[5]):
				if self.parent.users[i].disabledActions[sData[6]]  == True:
					self.parent.users[i].disabledActions[sData[6]] = False
				else:
					self.parent.users[i].disabledActions[sData[6]] = True
				return True
		return True
		
	def handleGetPlayer(self, sData, pString):
		if self.is_numeric(sData[5]) == False:
			return False
		if self.isOnline(sData[5]):
			myObj = False
			for id in self.parent.users:
				if self.parent.users[id].ID == sData[5]:
					myObj = self.parent.users[id].buildString()
					if myObj != False:
						return self.sendLine('%xt%gp%-1%' + str(myObj) + '%')
					else:
						return False
		user = self.parent.MySQL.dbAPI.runQuery('SELECT * FROM accs WHERE ID=(%s)', (sData[5]))
		user.addCallback(self._mysqlGotUser)
		return True
	
	def _mysqlGotUser(self, result):
		if result == False or result == None:
			return False
		return self.sendLine('%xt%gp%-1%' + str(self.buildObjFromStr(result[0][0], result[0][2], result[0][5])) + '%')
	
	def handleRemoveMessage(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		if self.crumb('isModerator') != True:
			return False
		self.sendToRoom('%xt%rmsg%-1%' + str(sData[5]) + '%')
		return True
	
	def handleAddItem(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		return self.addItem(sData[5])
		
	def _mysqlGotNicknameRequest (self, result):
		if result == None or result == False or not result:
			self.crumb('credits', (self.crumb('credits')-20000))
			self.nickname = self.requestedName
			self.hasNickChanged = True
			self.sendToRoom('%xt%upun%-1%' + str(self.ID) + '%' + str(self.nickname) + '%')
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%245%' + str(self.crumb('credits')) + '%nnc%')
		else:
			try:
				user = result[0]
			except:
				#print 'Result[0] doesnt exist: ' + str(result)
				return self.sendLine('%xt%aci%-1%101%' + str(self.crumb('credits')) + '%nnc%')
			if int(user[0]) == int(self.ID):
				self.crumb('credits', (self.crumb('credits')-20000))
				self.nickname = self.requestedName
				self.hasNickChanged = True
				self.sendToRoom('%xt%upun%-1%' + str(self.ID) + '%' + str(self.nickname) + '%')
				self.triggerSave()
				return self.sendLine('%xt%aci%-1%245%' + str(self.crumb('credits')) + '%nnc%')
			#print 'Name taken: ' + str(result)
			return self.sendLine('%xt%aci%-1%101%' + str(self.crumb('credits')) + '%nnc%')
		
	def handleAddStoreItem(self, sData, pString):
		try:
			itemID = sData[5]
		except:
			return False
		if itemID == 'ng':
			if self.crumb('hasNG') == True:
				return False
			if self.crumb('credits') < 35000:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			self.crumb('credits', (self.crumb('credits')-35000))
			self.crumb('hasNG', True)
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%1%' + str(self.crumb('credits')) + '%ng%')
		if itemID == 'rc':
			if self.crumb('hasRC') == True:
				return False
			if self.crumb('credits') < 7500:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			self.crumb('credits', (self.crumb('credits')-7500))
			self.crumb('hasRC', True)
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%1%' + str(self.crumb('credits')) + '%rc%')
		if itemID == 'csb':
			if self.crumb('hasCustomBG') == True:
				return False
			if self.crumb('credits') < 20000:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			self.crumb('credits', (self.crumb('credits')-20000))
			self.crumb('hasCustomBG', True)
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%1%' + str(self.crumb('credits')) + '%')
		if itemID == 'nnc':
			try:
				sData[6]
			except:
				return False
			if self.crumb('credits') < 20000:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			if sData[6].__len__() < 4 or sData[6].__len__() > 16:
				return self.sendLine('%xt%aci%-1%101%' + str(self.crumb('credits')) + '%')
			valid = re.match('^[A-Za-z0-9]+( [A-Za-z0-9]+)*$', sData[6]) is not None
			if valid == False:
				return self.sendLine('%xt%aci%-1%101%' + str(self.crumb('credits')) + '%')
			self.requestedName = sData[6]
			user = self.parent.MySQL.dbAPI.runQuery('SELECT `id` FROM accs WHERE name=(%s) OR nickname=(%s)', (sData[6], sData[6]))
			user.addCallback(self._mysqlGotNicknameRequest)
			return True
		if itemID == 'sp':
			if self.crumb('hasSpeed') == True:
				return False
			if self.crumb('credits') < 15000:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			self.crumb('credits', (self.crumb('credits')-15000))
			self.crumb('hasSpeed', True)
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%1%' + str(self.crumb('credits')) + '%sp%')
		if itemID == 'snc':
			if self.crumb('hasSC') == True:
				return False
			if self.crumb('credits') < 12000:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			self.crumb('credits', (self.crumb('credits')-12000))
			self.crumb('hasSC', True)
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%1%' + str(self.crumb('credits')) + '%snc%')
		if itemID == 'bc':
			if self.crumb('hasBC') == True:
				return False
			if self.crumb('credits') < 30000:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			self.crumb('credits', (self.crumb('credits')-30000))
			self.crumb('hasBC', True)
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%1%' + str(self.crumb('credits')) + '%bc%')
		if itemID == 'stc':
			if self.crumb('hasSTC') == True:
				return False
			if self.crumb('credits') < 23000:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			self.crumb('credits', (self.crumb('credits')-23000))
			self.crumb('hasSTC', True)
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%1%' + str(self.crumb('credits')) + '%stc%')
		if itemID == 'pgf':
			if self.crumb('hasPGF') == True:
				return False
			if self.crumb('credits') < 30000:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			self.crumb('credits', (self.crumb('credits')-30000))
			self.crumb('hasPGF', True)
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%1%' + str(self.crumb('credits')) + '%pgf%')
		if itemID == 'he':
			ep = self.crumb('emotePacks')
			name = 'Halloween Emotes'
			for i in ep:
				if ep[i]['name'] == name:
					return False
			if self.crumb('credits') < 2500:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			ep[len(ep)] = {'name': 'Halloween Emotes', 'pageInt': 4}
			self.crumb('credits', (self.crumb('credits')-2500))
			self.crumb('emotePacks', ep)
			emoteStr = ''
			for x in ep:
				emoteStr += str(ep[x]['name']) + '^' + str(ep[x]['pageInt']) + '$'
			self.sendLine('%xt%sme%-1%' + emoteStr + '%')
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%1%' + str(self.crumb('credits')) + '%')
		if itemID == 'ppe':
			ep = self.crumb('emotePacks')
			name = 'Party Emotes'
			for i in ep:
				if ep[i]['name'] == name:
					return False
			if self.crumb('credits') < 4500:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			ep[len(ep)] = {'name': 'Party Emotes', 'pageInt': 7}
			self.crumb('credits', (self.crumb('credits')-4500))
			self.crumb('emotePacks', ep)
			emoteStr = ''
			for x in ep:
				emoteStr += str(ep[x]['name']) + '^' + str(ep[x]['pageInt']) + '$'
			self.sendLine('%xt%sme%-1%' + emoteStr + '%')
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%1%' + str(self.crumb('credits')) + '%')
		if itemID == 'htr':
			ep = self.crumb('transPacks')
			name = 'Halloween Transformations'
			for i in ep:
				if ep[i]['name'] == name:
					return False
			if self.crumb('credits') < 25000:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			ep[len(ep)] = {'name': 'Halloween Transformations', 'pageInt': 4}
			self.crumb('credits', (self.crumb('credits')-25000))
			self.crumb('transPacks', ep)
			emoteStr = ''
			for x in ep:
				emoteStr += str(ep[x]['name']) + '^' + str(ep[x]['pageInt']) + '$'
			self.sendLine('%xt%smtr%-1%' + emoteStr + '%')
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%1%' + str(self.crumb('credits')) + '%')
		if itemID == 'me':
			ep = self.crumb('emotePacks')
			name = 'Memes'
			for i in ep:
				if ep[i]['name'] == name:
					return False
			if self.crumb('credits') < 4000:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			ep[len(ep)] = {'name': 'Memes', 'pageInt': 5}
			self.crumb('credits', (self.crumb('credits')-4000))
			self.crumb('emotePacks', ep)
			emoteStr = ''
			for x in ep:
				emoteStr += str(ep[x]['name']) + '^' + str(ep[x]['pageInt']) + '$'
			self.sendLine('%xt%sme%-1%' + emoteStr + '%')
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%1%' + str(self.crumb('credits')) + '%')
		if itemID == 'ce':
			ep = self.crumb('emotePacks')
			name = 'Christmas Emotes'
			for i in ep:
				if ep[i]['name'] == name:
					return False
			if self.crumb('credits') < 4000:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			ep[len(ep)] = {'name': 'Christmas Emotes', 'pageInt': 7}
			self.crumb('credits', (self.crumb('credits')-4000))
			self.crumb('emotePacks', ep)
			emoteStr = ''
			for x in ep:
				emoteStr += str(ep[x]['name']) + '^' + str(ep[x]['pageInt']) + '$'
			self.sendLine('%xt%sme%-1%' + emoteStr + '%')
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%1%' + str(self.crumb('credits')) + '%')
		if itemID == 'oe':
			ep = self.crumb('emotePacks')
			name = 'Oasis Emotes'
			for i in ep:
				if ep[i]['name'] == name:
					return False
			if self.crumb('credits') < 3500:
				return self.sendLine('%xt%aci%-1%100%' + str(self.crumb('credits')) + '%')
			ep[len(ep)] = {'name': 'Oasis Emotes', 'pageInt': 6}
			self.crumb('credits', (self.crumb('credits')-3500))
			self.crumb('emotePacks', ep)
			emoteStr = ''
			for x in ep:
				emoteStr += str(ep[x]['name']) + '^' + str(ep[x]['pageInt']) + '$'
			self.sendLine('%xt%sme%-1%' + emoteStr + '%')
			self.triggerSave()
			return self.sendLine('%xt%aci%-1%1%' + str(self.crumb('credits')) + '%')
		return False
		
	def handleSendPlayerMove(self, sData, pString):
		try:
			x = sData[5]
			y = sData[6]
		except:
			x = 0
			y = 0
		self.pos['x'] = x
		self.pos['y'] = y
		if self.crumb('hasSpeed') == True and self.crumb('speed') != '0':
			if self.crumb('speed') == '2':
				self.sendToRoom('%xt%tp%-1%' + str(self.ID) + '%' + str(x) + '%' + str(y) + '%')
				return True
			if self.crumb('speed') == '1':
				self.sendToRoom('%xt%sp%-1%' + str(self.ID) + '%' + str(x) + '%' + str(y) + '%1%')
				return True
		return self.sendToRoom('%xt%sp%-1%' + str(self.ID) + '%' + str(x) + '%' + str(y) + '%')
		
	def handleTeleportPlayer(self, sData, pString):
		try:
			x = sData[5]
			y = sData[6]
		except:
			x = 0
			y = 0
		self.pos['x'] = x
		self.pos['y'] = y
		return self.sendToRoom('%xt%tp%-1%' + str(self.ID) + '%' + str(x) + '%' + str(y) + '%')
		
	def handleToggleFindOption (self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if sData[5] == 'on':
			self.canFind = False
		else:
			self.canFind = True
		return True
	
	def handleGetPlayerLocationById(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(sData[5]):
				if self.parent.users[i].canFind == False:
					return self.sendLine('%xt%bf%-1%99999%')
				return self.sendLine('%xt%bf%-1%' + str(self.parent.users[i].roomID) + '%')
		return False
		
	def handleBuddyRemove(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		myBuddies = self.crumb('buddies')
		for i in myBuddies:
			if str(myBuddies[i]) == str(sData[5]):
				myBuddies.pop(i)
				break
		self.crumb('buddies', myBuddies)
		self.triggerSave()
		self.sendLine('%xt%rb%-1%' + str(sData[5]) + '%')
		for x in self.parent.users:
			if str(self.parent.users[x].ID) == str(sData[5]):
				theirBuddies = self.parent.users[x].crumb('buddies')
				for q in theirBuddies:
					if str(theirBuddies[q]) == str(self.ID):
						theirBuddies.pop(q)
						try:
							self.parent.users[i].sendLine('%xt%rb%-1%' + str(self.ID) + '%')
						except:
							return True
						return True
				return True
		buddyQuery = self.parent.MySQL.dbAPI.runQuery("SELECT `ID`, `crumbs` FROM `accs` WHERE `ID` = (%s)", (sData[5]))
		buddyQuery.addCallback(self._mysqlGotBuddy)
		return True
		
	def _mysqlGotBuddy(self, result):
		if result == False or result == None:
			return False
		crumbs = unserialize(result[0][1])
		theirBuddies = crumbs['buddies']
		for o in theirBuddies:
			if str(theirBuddies[o]) == str(self.ID):
				theirBuddies.pop(o)
				crumbs['buddies'] = theirBuddies
				self.parent.MySQL.dbAPI.runOperation('UPDATE accs SET crumbs=(%s) WHERE ID = (%s)', (serialize(crumbs), result[0][0]))
				return True
		return True

	def handleBuddyRequest(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		for i in self.parent.users:
			if str(self.parent.users[i].ID) == str(sData[5]):
				self.parent.users[i].sendLine('%xt%br%-1%' + str(self.ID) + '%' + str(self.nickname) + '%' + str(self.crumb('body')) + '%' + str(self.crumb('feet')) + '%' + str(self.crumb('hands')) + '%' + str(self.crumb('face')) + '%' + str(self.crumb('neck')) + '%' + str(self.crumb('head')) + '%')
				return True
		return True
		
	def handleBuddyAdd(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		myBuddies = self.crumb('buddies')
		for i in myBuddies:
			if str(myBuddies[i]) == str(sData[5]):
				return False
		myBuddies[int(sData[5])] = int(sData[5])
		self.crumb('buddies', myBuddies)
		self.triggerSave()
		for x in self.parent.users:
			if str(self.parent.users[x].ID) == str(sData[5]):
				theirBuddies = self.parent.users[x].crumb('buddies')
				theirBuddies[int(self.ID)] = int(self.ID)
				self.parent.users[x].crumb('buddies', theirBuddies)
				self.parent.users[x].sendLine('%xt%ba%-1%' + str(self.ID) + '%' + str(self.nickname) + '%' + str(self.crumb('body')) + '%' + str(self.crumb('feet')) + '%' + str(self.crumb('hands')) + '%' + str(self.crumb('face')) + '%' + str(self.crumb('neck')) + '%' + str(self.crumb('head')) + '%' + str(self.crumb('color')) + '%')
				self.sendLine('%xt%ba%-1%' + str(sData[5]) + '%' + str(self.parent.users[x].nickname) + '%' + str(self.parent.users[x].crumb('body')) + '%' + str(self.parent.users[x].crumb('feet')) + '%' + str(self.parent.users[x].crumb('hands')) + '%' + str(self.parent.users[x].crumb('face')) + '%' + str(self.parent.users[x].crumb('neck')) + '%' + str(self.parent.users[x].crumb('head')) + '%' + str(self.parent.users[x].crumb('color')) + '%')
				return True
		buddyQuery = self.parent.MySQL.dbAPI.runQuery("SELECT `ID`,`crumbs`,`nickname` FROM `accs` WHERE `ID` = (%s)", (sData[5]))
		buddyQuery.addCallback(self._mysqlGotAcceptBuddy)
		return True
		
	def _mysqlGotAcceptBuddy(self, result):
		if result == False or result == None:
			return False
		theirCrumbs = unserialize(result[0][1])
		theirBuddies = theirCrumbs['buddies']
		theirName = result[0][2]
		theirBuddies[int(self.ID)] = int(self.ID)
		theirCrumbs['buddies'] = theirBuddies
		self.sendLine('%xt%ba%-1%' + str(result[0][0]) + '%' + str(theirName) + '%' + str(self.crumbFromObj(theirCrumbs, 'body')) + '%' + str(self.crumbFromObj(theirCrumbs, 'feet')) + '%' + str(self.crumbFromObj(theirCrumbs, 'hands')) + '%' + str(self.crumbFromObj(theirCrumbs, 'face')) + '%' + str(self.crumbFromObj(theirCrumbs, 'neck')) + '%' + str(self.crumbFromObj(theirCrumbs, 'head')) + '%' + str(self.crumbFromObj(theirCrumbs, 'color')))
		self.parent.MySQL.dbAPI.runOperation('UPDATE accs SET crumbs=(%s) WHERE ID = (%s)', (serialize(theirCrumbs), result[0][0]))
		return True
		
	def handleUpdateStatusColor(self, sData, pString):
		try:
			sData[5]
			sData[6]
		except:
			return False
		if self.crumb('hasSTC') == False:
			return False
		if sData[5] == 'font':
			if sData[6] == 'Arial':
				self.crumb('statusFont', 'Arial')
				self.sendToRoom('%xt%ustc%-1%' + str(self.ID) + '%font%Arial%')
				return True
			if sData[6] == 'Burbank Small':
				self.crumb('statusFont', 'Burbank Small')
				self.sendToRoom('%xt%ustc%-1%' + str(self.ID) + '%font%Burbank Small%')
				return True
			if sData[6] == 'Comic Sans MS':
				self.crumb('statusFont', 'Comic Sans MS')
				self.sendToRoom('%xt%ustc%-1%' + str(self.ID) + '%font%Comic Sans MS%')
				return True
		if sData[5] == 'gs':
			if self.is_numeric(sData[6]):
				if sData[6] > 5 and sData[6] < 1001:
					self.crumb('statusGlowStrength', str(sData[6]))
					self.sendToRoom('%xt%ustc%-1%' + str(self.ID) + '%gs%' + str(sData[6]) + '%')
					return True
		if sData[5] == 'gc':
			if sData[6].__len__() > 3 and sData[6].__len__() < 7:
				self.crumb('statusGlowColor', sData[6])
				self.sendToRoom('%xt%ustc%-1%' + str(self.ID) + '%gc%' + str(sData[6]) + '%')
				return True
		if sData[5] == 'tc':
			if sData[6].__len__() > 3 and sData[6].__len__() < 7:
				self.crumb('statusTextColor', sData[6])
				self.sendToRoom('%xt%ustc%-1%' + str(self.ID) + '%tc%' + str(sData[6]) + '%')
				return True
		return True
			
	def handleRemoveIgnore(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		myIgnore = self.crumb('ignore')
		for i in myIgnore:
			if str(myIgnore[i]) == str(sData[5]):
				myIgnore.pop(i)
				break
		self.crumb('ignore', myIgnore)
		self.sendLine('%xt%rn%-1%' + str(sData[5]) + '%')
		return True
		
	def handleAddIgnore(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		myIgnore = self.crumb('ignore')
		for i in myIgnore:
			if str(myIgnore[i]) == str(sData[5]):
				return False
		myIgnore[int(sData[5])] = int(sData[5])
		self.crumb('ignore', myIgnore)
		get = self.parent.cachedNames.get(str(sData[5]), False)
		if get != False:
			self.sendLine('%xt%an%-1%' + str(sData[5]) + '%' + str(get) + '%')
		else:
			user = self.parent.MySQL.dbAPI.runQuery("SELECT `ID`,`nickname` FROM `accs` WHERE `ID` = (%s)", (sData[5]))
			user.addCallback(self._mysqlGotNameForIgnore)
		return True
		
	def _mysqlGotNameForIgnore(self, result):
		if result == False or result == None:
			return False
		self.sendLine('%xt%an%-1%' + str(result[0][0]) + '%' + str(result[0][1]) + '%')
		return True

	def handleGameOver(self, sData, pString):
		try:
			sData[5]
		except:
			return False
		if self.is_numeric(sData[5]) == False:
			return False
		coins = int(self.crumb('coins')) + int(sData[5])
		self.crumb('coins', coins)
		return self.sendLine('%xt%zo%-1%' + str(coins) + '%')
		
	def sendBotMessage(self, message):
		return self.sendLine('%xt%sm%-1%7446%' + str(message) + '%')
		
	def addItem(self, itemID):
		if self.is_numeric(itemID) == False:
			return False
		if str(itemID) == '0':
			return False
		items = self.crumb('items')
		for i in items:
			if items[int(i)] == int(itemID):
				return False
		items[int(itemID)] = int(itemID)
		self.crumb('items', items)
		self.sendLine('%xt%ai%-1%' + str(itemID) + '%' + str(self.crumb('coins')) + '%')
		return True
		
	def setOutfit(self, color, head, face, neck, body, hand, feet, flag, photo, addItems=False):
		self.crumb('color', color)
		self.crumb('head', head)
		self.crumb('face', face)
		self.crumb('neck', neck)
		self.crumb('body', body)
		self.crumb('hands', hand)
		self.crumb('feet', feet)
		self.crumb('pin', flag)
		self.crumb('photo', photo)
		if addItems == True:
			self.addItem(color)
			self.addItem(head)
			self.addItem(face)
			self.addItem(neck)
			self.addItem(body)
			self.addItem(hand)
			self.addItem(feet)
			self.addItem(flag)
			self.addItem(photo)
		self.sendToRoom('%xt%upc%-1%' + str(self.ID) + '%' + str(color) + "%\0%xt%uph%-1%" + str(self.ID) + '%' + str(head) + "%\0%xt%upf%-1%" + str(self.ID) + '%' + str(face) + "%\0%xt%upn%-1%" + str(self.ID) + '%' + str(neck) + "%\0%xt%upb%-1%" + str(self.ID) + '%' + str(body) + "%\0%xt%upa%-1%" + str(self.ID) + '%' + str(hand) + "%\0%xt%upe%-1%" + str(self.ID) + '%' + str(feet) + "%\0%xt%upl%-1%" + str(self.ID) + '%' + str(flag) + "%\0%xt%upp%-1%" + str(self.ID) + '%' + str(photo) + "%")
		return True
		
	def addFurniture(self, furnitureID):
		if self.is_numeric(furnitureID) == False:
			return False
		furniture = self.crumb('furniture')
		hasDone = False
		for i in furniture:
			if i == furnitureID:
				hasDone = True
				try:
					furniture[i] = int(furniture[i]) + 1
				except:
					furniture[i] = 50
		if hasDone == False:
			furniture[furnitureID] = 1
		self.crumb('furniture', furniture)
		self.sendLine('%xt%af%-1%' + str(furnitureID) + '%' + str(self.crumb('coins')) + '%')
		return True
		
	def getPlayer(self, playerID):
		if self.is_numeric(playerID) == False:
			return False
		if self.isOnline(playerID):
			myObj = False
			for id in self.parent.users:
				if self.parent.users[id].ID == playerID:
					myObj = {0: self.parent.users[id].crumb('body'), 1: self.parent.users[id].crumb('feet'), 2: self.parent.users[id].crumb('hands'), 3: self.parent.users[id].crumb('face'), 4: self.parent.users[id].crumb('neck'), 5: self.parent.users[id].crumb('head'), 6: str(datetime.datetime.fromtimestamp(int(time.time())).strftime('%b %d, %Y')), 7: self.parent.users[id].nickname, 8: self.parent.users[id].crumb('color')}
					return myObj
		return False
	
	def getBuddyList(self):
		buddies = self.crumb('buddies')
		if buddies == False:
			return self.sendLine('%xt%gb%-1%%')
		if len(buddies) == 0:
			return self.sendLine('%xt%gb%-1%%')
		newString = ''
		buddyList = []
		for i in buddies:
			if buddies[i] == self.ID:
				continue
			player = self.getPlayer(buddies[i])
			if player == False:
				buddyList.append(str(buddies[i]))
			else:
				self.parent.sendToID(buddies[i], '%xt%bon%-1%' + str(self.ID) + '%')
				newString += str(buddies[i]) + '|' + str(player[7]) + '|1|' + str(player[0]) + '|' + str(player[1]) + '|' + str(player[2]) + '|' + str(player[3]) + '|' + str(player[4]) + '|' + str(player[5]) + '|' + str(player[6]) + '|' + str(player[8]) + '%'
		if len(buddyList) == 0:
			return self.sendLine('%xt%gb%-1%' + newString + '%')
		self.preBuddy = newString
		getBuddies = self.parent.MySQL.dbAPI.runQuery("SELECT `ID`,`crumbs`,`nickname`,`lastLogin` FROM `accs` WHERE `ID` IN %s" % '(' + ','.join(buddyList) + ')')
		getBuddies.addCallback(self._mysqlGotBuddyList)
		return True
	
	def _mysqlGotBuddyList(self, result):
		if result == False or result == None:
			return self.sendLine('%xt%gb%-1%' + str(self.preBuddy) + '%')
		for i in result:
			obj = unserialize(i[1])
			player = {0: self.crumbFromObj(obj, 'body'), 1: self.crumbFromObj(obj, 'feet'), 2: self.crumbFromObj(obj, 'hands'), 3: self.crumbFromObj(obj, 'face'), 4: self.crumbFromObj(obj, 'neck'), 5: self.crumbFromObj(obj, 'head'), 6: str(datetime.datetime.fromtimestamp(int(i[3])).strftime('%b %d, %Y')), 7: i[2], 8: self.crumbFromObj(obj, 'color')}
			self.preBuddy += str(i[0]) + '|' + str(i[2]) + '|0|' + str(player[0]) + '|' + str(player[1]) + '|' + str(player[2]) + '|' + str(player[3]) + '|' + str(player[4]) + '|' + str(player[5]) + '|' + str(player[6]) + '|' + str(player[8]) + '%'
		return self.sendLine('%xt%gb%-1%' + str(self.preBuddy) + '%')
		
	def getAndSendSavedOutfits(self):
		outfits = self.parent.MySQL.dbAPI.runQuery("SELECT `id`,`outfitName`,`outfitString` FROM `savedOutfits` WHERE `playerID` = (%s)", (self.ID))
		outfits.addCallback(self._mysqlGotOutfits)
		return True
	def _mysqlGotOutfits(self, result):
		if result == False or result == None:
			return self.sendLine('%xt%gmso%-1%%')
		gStr = ''
		for i in result:
			try:
				i[2]
			except:
				continue
			gStr += '%' + str(i[0]) + '}!-!{' + str(i[1]) + '}!-!{' + str(i[2])
		if gStr == '':
			return self.sendLine('%xt%gmso%-1%%')
		return self.sendLine('%xt%gmso%-1' + str(gStr) + '%')
		
	def getIgnoreList(self):
		ignored = self.crumb('ignore')
		if ignored == False or ignored == False:
			return self.sendLine('%xt%gn%-1%%')
		if len(ignored) == 0:
			return self.sendLine('%xt%gn%-1%%')
		newString = ''
		namesNeeded = []
		for i in ignored:
			name = self.parent.cachedNames.get(str(ignored[i]), False)
			if name == False:
				namesNeeded.append(ignored[i])
				continue
			newString += str(ignored[i]) + '|' + str(name) + '%'
		if len(namesNeeded) == 0:
			return self.sendLine('%xt%gn%-1%' + str(newString) + '%')
		self.preIgnore = newString
		names = self.parent.MySQL.dbAPI.runQuery("SELECT `ID`,`nickname` FROM `accs` WHERE `ID` IN %s" % '(' + str(','.join(namesNeeded)) + ')')
		names.addCallback(self._mysqlGotIgnoreList)
		return newString
		
	def _mysqlGotIgnoreList(self, result):
		if result == False or result == None:
			return self.sendLine('%xt%gn%-1%' + str(self.preIgnore) + '%')
		for i in result:
			self.preIgnore += str(i[0]) + '|' + str(i[1]) + '%'
		return self.sendLine('%xt%gn%-1%' + str(self.preIgnore) + '%')
		
	def getPufflesById(self, ID):
		if self.is_numeric(ID) == False:
			return False
		puffles = False
		#puffles = self.parent.MySQL.selectAll('SELECT `id`,`name`,`puffleID`, `health`, `energy`, `rest` FROM `puffles` WHERE `ownerID` = "' + str(ID) + '"')
		if puffles == False:
			pStr = ''
		else:
			pStr = ''
			for i in puffles:
				try:
					i[1]
				except:
					continue
				pStr += '%s|%s|%s|%s|%s|%s' % (str(i[0]), str(i[1]), str(i[2]), str(i[3]), str(i[4]), str(i[5]))
				pStr += '%'
		return pStr
	
	def getName(self, ID):
		if self.is_numeric(ID) == False:
			return False
		get = self.parent.cachedNames.get(str(ID), False)
		if get == False:
			user = self.parent.MySQL.selectData('SELECT * FROM `accs` WHERE ID = "' + str(ID) + '"')
			if user == False:
				return False
			fID = user[2]
			self.parent.cachedNames[str(ID)] = fID
			return fID
		else:
			return self.parent.cachedNames.get(str(ID), False)
		return False
		
	def unserializeCrumbs(self, crumbs):
		try:
			crumbs = unserialize(crumbs)
		except:
			return False
		return crumbs
		
	def serializeCrumbs(self, crumbs):
		try:
			crumbs = serialize(crumbs)
		except:
			return False
		return crumbs
		
	def is_numeric(self, var):
		try:
			float(var)
			return True
		except ValueError:
			return False
			
	def sendToRoom(self, send, isForBot=False):
		roomMap = self.parent.roomMap[int(self.roomID)]['clients']
		for id in roomMap:
			if self.parent.roomMap[int(self.roomID)]['clients'][int(id)] == False:
				try:
					self.parent.roomMap[int(self.roomID)]['clients'].pop(int(id))
				except:
					continue
			try:
				if self.parent.users[id].skipMe == False:
					self.parent.users[id].sendLine(send)
			except:
				print 'Error sending to client: ' + str(id) + ';' + str(self.roomID) + ';' + str(send)
				try:
					self.parent.users[id].connectionLost('')
					self.parent.roomMap[int(self.roomID)]['clients'].pop(int(id))
				except:
					print 'Error removing the user from the server during sendToRoom () : ' + str(id)
					continue
				continue
		try:
			self.parent.roomMap[int(self.roomID)]['botHooks']
		except:
	#		print 'No bot hooks'
			return False
	#	print 'Debug: ' + str(len(self.parent.roomMap[int(self.roomID)]['botHooks'])) + ':' + str(isForBot)
		if len(self.parent.roomMap[int(self.roomID)]['botHooks']) != 0 and isForBot == True:
			for x in self.parent.roomMap[int(self.roomID)]['botHooks']:
				#print 'Sending to bot: ' + str(send)
				self.parent.roomMap[int(self.roomID)]['botHooks'][x].sendLine(send)
		return True
	
	def getID(self, name):
		get = self.parent.cachedIDs.get(str(name), False)
		if get == False:
			user = self.parent.MySQL.selectData('SELECT * FROM `accs` WHERE name = "' + self.parent.MySQL.MySQL.escape_string(str(name)) + '"')
			if user == False:
				return False
			fName = user[0]
			self.parent.cachedIDs[str(name)] = fName
			return fName
		else:
			return self.parent.cachedIDs.get(str(name), False)
		return False
		
	def isOnline(self, ID):
		if self.is_numeric(ID) == False:
			return False
		return self.parent.isOnline(ID)
	
	def validRoom(self, roomID):
		if(self.parent.roomMap.has_key(int(roomID)) == False):
			return False
		return True
		
	def joinRoom(self, roomID, x, y):
		if(self.is_numeric(x) == False):
			return False
		if(self.is_numeric(y) == False):
			return False
		if(self.validRoom(roomID) == False):
			return False
		if(len(self.parent.roomMap[int(roomID)]['clients']) >= 60):
			self.sendLine('%xt%e%-1%210%')
			return False
		if(self.parent.roomMap[int(roomID)]['moderatorOnly'] == True):
			if self.crumb('isModerator') != True:
				self.sendLine('%xt%e%-1%210%')
				return False
		if(int(self.roomID) != 0):
			oldRoom = self.roomID
			if(self.validRoom(oldRoom) == True):
				oldRoomLink = self.parent.roomMap[int(oldRoom)]
				if oldRoomLink['clients'].has_key(int(self.clientID)):
					oldRoomLink['clients'].pop(int(self.clientID))
					if(len(oldRoomLink['clients']) > 0):
						for id in oldRoomLink['clients']:
							try:
								self.parent.users[id].sendLine('%xt%rp%-1%' + str(self.ID) + '%')
							except:
								continue
		self.roomID = roomID
		self.parent.roomMap[int(roomID)]['clients'][int(self.clientID)] = self
		self.frame = 0
		self.pos['x'] = x
		self.pos['y'] = y
		if(self.parent.roomMap[int(roomID)]['isGame'] == True):
			self.sendLine('%xt%jg%-1%' + str(roomID) + '%')
			self.sendLine('%xt%ap%-1%' + str(self.buildString()) + '%')
		else:
			if self.parent.showBot == True:
				roomString = str(self.parent.botString) + '%'
			else:
				roomString = ''
			recentTime = time.time() - 420
			for user in self.parent.roomMap[int(roomID)]['clients']:
				if self.parent.roomMap[int(roomID)]['clients'][user] == False:
					self.parent.roomMap[int(roomID)]['clients'].pop(user)
					continue
				try:
					self.parent.users[user].skipMe
					self.parent.users[user].lastHeartbeat
				except:
					continue
				if self.parent.users[user].skipMe == True:
					continue
				if self.parent.users[user].lastHeartbeat < recentTime:
					continue
				try:
					roomString = roomString + str(self.parent.users[user].buildString()) + '%'
				except:
					continue
			self.sendLine('%xt%jr%-1%' + str(roomID) + '%' + roomString)
			self.sendToRoom('%xt%ap%-1%' + str(self.buildString()) + '%', True)
			self.lastJoinRoom = time.time()
		return True
		
	def joinIgloo(self, roomID, x, y):
		if(self.is_numeric(x) == False):
			return False
		if(self.is_numeric(y) == False):
			return False
			return False
		if(int(self.roomID) != 0):
			oldRoom = self.roomID
			try:
				oldRoomLink = self.parent.roomMap[int(oldRoom)]
			except:
				return False
			oldRoomLink['clients'].pop(self.clientID)
			if(len(oldRoomLink['clients']) > 0):
				for id in oldRoomLink['clients']:
					try:
						self.parent.users[id].sendLine('%xt%rp%-1%' + str(self.ID) + '%')
					except:
						continue
		self.roomID = roomID
		try:
			self.parent.roomMap[int(roomID)]['clients'][int(self.clientID)] = self
		except:	
			self.parent.roomMap[int(roomID)] = {'clients': {}, 'isGame': False, 'isIgloo': True, 'isOpen': False, 'name': 'igloo', 'membersOnly': False}
			self.parent.roomMap[int(roomID)]['clients'][int(self.clientID)] = self
		if(len(self.parent.roomMap[int(roomID)]['clients']) >= 80):
			return self.sendLine('%xt%e%-1%210%')
		self.frame = 0
		self.pos['x'] = x
		self.pos['y'] = y
		if self.parent.showBot == True:
			roomString = str(self.parent.botString) + '%'
		else:
			roomString = ''
		for user in self.parent.roomMap[int(roomID)]['clients']:
			try:
				if self.parent.users[user].skipMe == True:
					continue
				roomString = roomString + str(self.parent.users[user].buildString()) + '%'
			except:
				continue
		self.sendLine('%xt%jp%-1%' + str(roomID) + '%')
		self.sendLine('%xt%jr%-1%' + str(roomID) + '%' + roomString)
		self.sendToRoom('%xt%ap%-1%' + str(self.buildString()) + '%', True)
		return True
		
	def _mysqlGotUserForMod(self, result):
		if result == False or result == None:
			return False
		try:
			result[0][1]
		except:
			return False
		uCrumbs = unserialize(result[0][1])
		try:
			uCrumbs['isModerator']
		except:
			return False
		uCrumbs['isModerator'] = True
		self.parent.MySQL.dbAPI.runOperation('UPDATE accs SET crumbs=(%s) WHERE ID=(%s)', (serialize(uCrumbs), result[0][0]))
		return True
		
	def _mysqlGotUserForDemod(self, result):
		if result == False or result == None:
			return False
		try:
			result[0][1]
		except:
			return False
		uCrumbs = unserialize(result[0][1])
		try:
			uCrumbs['isModerator']
		except:
			return False
		uCrumbs['isModerator'] = False
		uCrumbs['isAdmin'] = False
		self.parent.MySQL.dbAPI.runOperation('UPDATE accs SET crumbs=(%s) WHERE ID=(%s)', (serialize(uCrumbs), result[0][0]))
		return True
		
	def _mysqlGotUserForUnban(self, result):
		if result == False or result == None:
			return False
		try:
			result[0][1]
		except:
			return False
		uCrumbs = unserialize(result[0][1])
		try:
			uCrumbs['isBanned']
		except:
			return False
		uCrumbs['isBanned'] = False
		self.parent.MySQL.dbAPI.runOperation('UPDATE accs SET crumbs=(%s) WHERE ID=(%s)', (serialize(uCrumbs), result[0][0]))
		return True
		
	def _mysqlGotUserForClone(self, result):
		if result == False or result == None:
			return False
		try:
			result[0][1]
		except:
			return False
		uCrumbs = unserialize(result[0][1])
		try:
			uCrumbs['color']
			uCrumbs['head']
			uCrumbs['face']
			uCrumbs['neck']
			uCrumbs['body']
			uCrumbs['hands']
			uCrumbs['pin']
			uCrumbs['photo']
			uCrumbs['feet']
		except:
			return False
		self.setOutfit(uCrumbs['color'], uCrumbs['head'], uCrumbs['face'], uCrumbs['neck'], uCrumbs['body'], uCrumbs['hands'], uCrumbs['feet'], uCrumbs['pin'], uCrumbs['photo'], True)
		return True
	
	def buildString(self):
		playerString = str(self.ID) + '|'
		playerString += str(self.nickname) + '|'
		playerString += '1|'
		playerString += str(self.crumb('color')) + '|'
		playerString += str(self.crumb('head')) + '|'
		playerString += str(self.crumb('face')) + '|'
		playerString += str(self.crumb('neck')) + '|'
		playerString += str(self.crumb('body')) + '|'
		playerString += str(self.crumb('hands')) + '|'
		playerString += str(self.crumb('feet')) + '|'
		playerString += str(self.crumb('pin')) + '|'
		playerString += str(self.crumb('photo')) + '|'
		playerString += str(self.pos['x']) + '|'
		playerString += str(self.pos['y']) + '|'
		playerString += str(self.frame) + '|'
		playerString += '1|'
		playerString += ('2159' if self.crumb('isModerator') == True else '0') + '|'
		playerString += '0|'
		playerString += '0|'
		playerString += str(self.crumb('mood')) + '|'
		playerString += str(self.crumb('bubbleColor')) + '|'
		playerString += str(self.crumb('pointerColor')) + '|'
		playerString += str(self.crumb('bubbleTextColor')) + '|'
		playerString += str(self.crumb('namecolor')) + '|'
		playerString += str(self.crumb('nameglow')) + '|'
		playerString += str(self.crumb('character')) + '|'
		playerString += str(self.crumb('ringColor')) + '|'
		playerString += str(self.crumb('pengFace')) + '|'
		playerString += str(self.crumb('statusFont')) + '|'
		playerString += str(self.crumb('statusGlowStrength')) + '|'
		if self.crumb('hasSTC'):
			playerString += str(self.crumb('statusTextColor')) + '|'
			playerString += str(self.crumb('statusGlowColor')) + '|'
		else:
			playerString += '0|0|'
		playerString += str(self.crumb('likes')) + '|'
		if self.crumb('isInRelationship'):
			playerString += str(self.crumb('relationshipType')) + '|'
			playerString += str(self.crumb('relationshipWith')) + '|'
		return playerString
		
	def buildObjFromStr(self, id, nick, string):
		obj = unserialize(string)
		playerString = str(id) + '|'
		playerString += str(nick) + '|'
		playerString += '1|'
		playerString += str(self.crumbFromObj(obj, 'color')) + '|'
		playerString += str(self.crumbFromObj(obj, 'head')) + '|'
		playerString += str(self.crumbFromObj(obj, 'face')) + '|'
		playerString += str(self.crumbFromObj(obj, 'neck')) + '|'
		playerString += str(self.crumbFromObj(obj, 'body')) + '|'
		playerString += str(self.crumbFromObj(obj, 'hands')) + '|'
		playerString += str(self.crumbFromObj(obj, 'feet')) + '|'
		playerString += str(self.crumbFromObj(obj, 'pin')) + '|'
		playerString += str(self.crumbFromObj(obj, 'photo')) + '|'
		playerString += '0|'
		playerString += '0|'
		playerString += '0|'
		playerString += '1|'
		playerString += ('2159' if self.crumbFromObj(obj, 'isModerator') == True else '0') + '|'
		playerString += '0|'
		playerString += '0|'
		playerString += str(self.crumbFromObj(obj, 'mood')) + '|'
		playerString += '0|'
		playerString += '0|'
		playerString += '0|'
		playerString += '0|'
		playerString += '0|'
		playerString += '0|'
		playerString += '0|'
		playerString += str(self.crumbFromObj(obj, 'pengFace')) + '|'
		playerString += str(self.crumbFromObj(obj, 'statusFont')) + '|'
		playerString += str(self.crumbFromObj(obj, 'statusGlowStrength')) + '|'
		# playerString += str(self.crumbFromObj(obj, 'statusTextColor')) + '|'
		# playerString += str(self.crumbFromObj(obj, 'statusGlowColor')) + '|'
		if self.crumbFromObj(obj, 'hasSTC'):
			playerString += str(self.crumbFromObj(obj, 'statusTextColor')) + '|'
			playerString += str(self.crumbFromObj(obj, 'statusGlowColor')) + '|'
		else:
			playerString += '0|0|'
		playerString += str(self.crumbFromObj(obj, 'likes')) + '|'
		if self.crumbFromObj(obj, 'isInRelationship'):
			playerString += str(self.crumbFromObj(obj, 'relationshipType')) + '|'
			playerString += str(self.crumbFromObj(obj, 'relationshipWith')) + '|'
		return playerString
				
	def hashPassword(self, password, rndKey):
		key = self.swapMD5(password, False)
		key = key.upper()
		key = key + str(rndKey)
		key = key + "Y(02.>'H}t\":E1"
		key = self.swapMD5(key, True)
		return key
	def swapMD5(self, strPasswd, blnMd5):
		if(blnMd5):
			strPasswd = hashlib.sha256(hashlib.md5(strPasswd + '93JFD!U5NF9!NG67!6&!*').hexdigest()).hexdigest()
		return strPasswd[32:] + strPasswd[:32]
	def generaterndK(self):
		return ''.join(random.choice(string.ascii_uppercase + string.digits + '?~{}[]|_' + string.ascii_lowercase) for x in range(random.randrange(10,15)))
		
	def crumbFromObj(self, obj, key, set = None):
		try:
			obj[key]
		except:
			return False
		return obj[key]
			
	def crumb(self, key, set = None):
		if set == None:
			try:
				self.crumbs[key]
			except:
				return False
			return self.crumbs[key]
		else:
			self.crumbs[key] = set
			return self.crumbs[key]
			
	def nestedCrumb(self, key1, key2, set = None):
		if set == None:
			try:
				self.crumbs[key1][key2]
			except:
				return False
			return self.crumbs[key1][key2]
		else:
			self.crumbs[key1][key2] = set
			return self.crumbs[key1][key2]
			
	def nestedCrumbFromObj(self, obj, key1, key2):
		try:
			obj[key1][key2]
		except:
			return False
		return obj[key1][key2]