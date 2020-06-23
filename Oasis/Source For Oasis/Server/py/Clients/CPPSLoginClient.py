import random
import hashlib
import string

class CPPSLoginClient:

	def __init__(self, parent, peer, sockfd):
	
		self.userInfo = {}
		self.parent = parent
		print "New Client Connected: %s:%s!" % peer
		self.userInfo['rndK'] = self.generateKey()
		self.userInfo['ip'] = peer[0]
		self.userInfo['peer'] = peer
		self.sock = sockfd
	def generateKey(self):
		rand = ''.join(random.choice(string.ascii_uppercase + string.digits + '?~{}[]|_' + string.ascii_lowercase) for x in range(random.randrange(10,15)))
		return rand
	def generateLoginKey(self, username):
		username = username.upper() + str(self.generateKey())
		hash = hashlib.sha1(username).hexdigest()
		return hash
	def send(self, data):
		try:
			self.sock.send(data + chr(0))
		except:
			print('Error sending data to %s:%s' % self.userInfo['peer'])
			return False
		return True
		