import OasisFindFour

class OasisGames:

	def __init__(self, parent):
		self.parent = parent
		self.findFour = OasisFindFour(self)
		self.games = {
			'four' : self.findFour
		}
		
	def startGame(self, name):
		try:
			self.games[name]
		except:
			print '\033[91m[Oasis] -> Game "' + str(name) + '" does not exist!\033[0m'
			return False
		self.games[name].setupGame()
		print "\033[92m[Oasis] -> Successfully started game: " + self.games[name].label + '\033[0m'
		return True
	
	def endGame(self, name):
		try:
			self.games[name]
		except:
			print '\033[91m[Oasis] -> Game "' + str(name) + '" does not exist!\033[0m'
			return False
		self.games[name].stopGame()
		print "\033[92m[Oasis] -> Successfully stopped game: " + self.games[name].label + '\033[0m'
		return True
	
	def run(self, name, client, action, args):
		try:
			self.games[name]
		except:
			print '\033[91m[Oasis] -> Game "' + str(name) + '" does not exist!\033[0m'
			return False
		self.games[name].handleAction(action, client, args)
		return True