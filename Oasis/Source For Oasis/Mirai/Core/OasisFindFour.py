class OasisFindFour:
	
	def __init__(self):
		self.label = 'Find Four'
		self.tables = {}
		self.actions = {
			'gz'   : 'handleGetGame',
			'jz'   : 'handleJoinGame',
			'lz'   : 'handleLeaveGame',
			'zm'   : 'handleSendMove',
			'a#lt' : 'handleLeaveGame'
		}
			
		
	def setupGame(self):
		tables = [102, 103, 104, 105, 106, 107, 108, 109]
		for i in tables:
			self.addTable(i)
		
	def getTableID(self, id):
		try:
			float(id)
		except:
			return False
		return ((int(id) + 100) - 2)
		
	def addTable(self, tableID):
		self.tables[int(tableID)] = {players: {}, watchers: {}, board: '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', player: 0}
		
	def handleAction(self, action, client, args):
		return False