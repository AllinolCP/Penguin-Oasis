import random
import hashlib
import socket
import string

class CPPSGameClient:

	def __init__(self, parent, peer, sockfd):
	
		self.is_authenticated = False
		self.userInfo 		  = {}
		self.username		  = ''
		self.nickname 		  = ''
		self.parent			  = parent
		self.invisible		  = False
		self.canSwitchRooms   = True
		self.userInfo['rndK'] = self.generateKey()
		self.sock = sockfd
		self.ip = peer[0]
		
		print "New Client Connected: %s:%s!" % peer
		
	def generateKey(self):
		rand = ''.join(random.choice(string.ascii_uppercase + string.digits + '?~{}[]|_' + string.ascii_lowercase) for x in range(random.randrange(10,15)))
		return rand
	def generateLoginKey(self, username):
		username = username.upper()
		hash = hashlib.sha1(username).hexdigest()
		hash = (hash.lower() + hash.upper())[(15 - username.__len__()):(40 - username.__len__())]
		return hash
		
	def send(self, data):
		try:
			self.sock.send(data + chr(0))
		except socket.error:
			print('Error sending data')
			return False
		return True

	def generateString(self):
		try:
			user = str(self.id) + '|'
		except:
			return ''
		user += self.nickname + '|'
		user += '1|'
		user += str(self.userInfo['crumbs']['color']) + '|'
		user += str(self.userInfo['crumbs']['head']) + '|'
		user += str(self.userInfo['crumbs']['face']) + '|'
		user += str(self.userInfo['crumbs']['neck']) + '|'
		user += str(self.userInfo['crumbs']['body']) + '|'
		user += str(self.userInfo['crumbs']['hands']) + '|'
		user += str(self.userInfo['crumbs']['feet']) + '|'
		user += str(self.userInfo['crumbs']['pin']) + '|'
		user += str(self.userInfo['crumbs']['photo']) + '|'
		user += str(self.userInfo['pos']['x']) + '|'
		user += str(self.userInfo['pos']['y']) + '|'
		user += str(self.userInfo['frame']) + '|'
		user += '1|'
		user += str(((6 if self.userInfo['crumbs']['isModerator'] else 1) * 146))
		return user
		
	def joinRoom(self, room_id, x, y):
		if self.canSwitchRooms == False:
			room_id = self.userInfo['room_id']
			x = self.userInfo['pos']['x']
			y = self.userInfo['pos']['y']
		if(self.parent.rooms.has_key(str(room_id)) == False):
			return False
		if(len(self.parent.rooms[str(room_id)]['clients']) >= 80):
			return self.send('%xt%e%-1%210%')
		if self.parent.game['isOn'] == True:
			self.send('%xt%pouh%-1%1%' + str(self.parent.game['hider']) + '%')
			self.send('%xt%pour%-1%1%' + str(self.parent.game['riddle']) + '%')
			if self.parent.game['hider'] == self.username:
				self.parent.rooms[str(self.userInfo['room_id'])]['containsHiddenPlayer'] = False
				self.parent.rooms[str(self.userInfo['room_id'])]['hiddenPlayer'] = False
				self.parent.rooms[str(room_id)]['containsHiddenPlayer'] = True
				self.parent.rooms[str(room_id)]['hiddenPlayer'] = self
				self.parent.game['room'] = room_id
		for client_obj in self.parent.rooms[str(self.userInfo['room_id'])]['clients']:
			self.parent.clients[client_obj].send('%xt%rp%-1%' + str(self.id) + '%')
		self.parent.rooms[str(self.userInfo['room_id'])]['clients'].pop(self.sock)
		self.userInfo['pos']['x'] = x
		self.userInfo['pos']['y'] = y
		self.userInfo['frame'] = 1
		self.userInfo['room_id'] = room_id
		self.parent.rooms[str(room_id)]['clients'][self.sock] = self
		if(bool(self.parent.rooms[str(room_id)]['game']) == True):
			self.send('%xt%jg%-1%' + str(room_id) + '%')
			self.send('%xt%ap%-1%' + self.generateString() + '%')
			return True
		else:
			room_string = '%xt%jr%-1%' + str(room_id) + '%' + '0|' + self.parent.config.get('Bot', 'name') + '|1|4|413|0|0|0|0|0|0|0|0|0|1|1|' + str((int(6 * 146))) + '%' #finish the bot config thing later, not as important
			for client in self.parent.rooms[str(room_id)]['clients']:
				if self.parent.clients[client].invisible == False or self.parent.clients[client].id == self.id:
					room_string = room_string + self.parent.clients[client].generateString() + '%'
				if self.invisible == False or self.parent.clients[client].id == self.id:
					self.parent.clients[client].send('%xt%ap%-1%' + self.generateString() + '%')
			self.send(room_string)
			
	def sendBotMsg(self, message):
		self.send('%xt%sm%-1%0%' + message + '%')
		return True
		
	def addItem(self, item_id):
		if(item_id.isdigit() == False):
			return False
		if(str(item_id) in self.userInfo['crumbs']['items']):
			self.send('%xt%e%-1%400%')
			return False
		self.userInfo['crumbs']['items'].append(str(item_id))
		self.send('%xt%ai%-1%' + str(item_id) + '%' + str(self.userInfo['coins']) + '%')
		return True
		
	def updateClothes(self, layer, item_id):
		if(item_id.isdigit() == False and layer != 'color'):
			return False
		handler = 'none'
		if(str(layer) == 'color'): handler = 'upc'
		if(str(layer) == 'head'):  handler = 'uph'
		if(str(layer) == 'face'):  handler = 'upf'
		if(str(layer) == 'neck'):  handler = 'upn'
		if(str(layer) == 'body'):  handler = 'upb'
		if(str(layer) == 'hands'): handler = 'upa'
		if(str(layer) == 'feet'):  handler = 'upe'
		if(str(layer) == 'photo'): handler = 'upp'
		if(str(layer) == 'pin'):   handler = 'upl'
		if(handler == 'none'):
			return False
		self.userInfo['crumbs'][str(layer)] = str(item_id)
		self.parent.sendToRoom(False, self.id, self.userInfo['room_id'], '%xt%' + handler + '%-1%' + str(self.id) + '%' + str(item_id) + '%')
	def sendToBuddies(self, packet):
		return True
	def getBuddies(self):
		string = ''
		return string[1:]	
	def getIgnored(self):
		string = ''
		return string[1:]		
	def addFurniture(self, furniture_id):
		return True
		
	def setupPlayer(self, userCrumbs, name):
		self.is_authenticated = True
		self.username = str(name)
		self.nickname = str(name)
		self.userInfo['pos'] = {'x': 0, 'y': 0}
		self.userInfo['frame'] = 1
		self.userInfo['room_id'] = 0
		self.userInfo['isMuted'] = False
		self.userInfo['crumbs'] = userCrumbs
	def getPostcards(self):
		return ''