import hashlib
import random

class Crypto:

	characters = [
		"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S",
		"T", "U", "V", "W", "X", "Y", "Z",
		"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
		"t", "u", "v", "w", "x", "y", "z"
		"_", "~", "{", "}", "?"
	]

	@staticmethod
	def generateRandomKey():
		rndK = ""

		for n in range(0, 9):
			rndK += random.choice(Crypto.characters)

		return rndK

	@staticmethod
	def encryptPassword(password, md5=True):
		if md5 == True:
			password = hashlib.md5(password.encode('utf-8')).hexdigest()

		hash = password[16:32] + password[0:16]

		return hash

	@staticmethod
	def getLoginHash(password, rndK):
		key = Crypto.encryptPassword(password, False)
		key += rndK
		key += "Y(02.>'H}t\":E1"

		hash = Crypto.encryptPassword(key)

		return hash