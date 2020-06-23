Avalanche
=========
*Note: the brief overview section is a bit out-dated.*

Club Penguin server emulator written in Python using Twisted.

## Dependencies
#### [Twisted](https://twistedmatrix.com/)
This is used for the **networking** aspect of the server. With [pip](https://pip.pypa.io/en/latest/installing.html), you can easily install it by executing the following via a terminal or command prompt:

`pip install twisted`

#### [lxml](http://lxml.de/)
Lxml is used to parse incoming XML data.

`pip install lxml`

#### [MySQLdb](https://pypi.python.org/pypi/MySQL-python) *1.2.5*
Used for [database](Avalanche/Database.py) operations.

`pip install mysql-python`

## Running
Running [Avalanche](https://github.com/TunnelBlanket/Avalanche) is currently very simple, but for the time being, you should only run it if you intend to experiment with the code.

Navigate to the directory containing Avalanche's source-code, and execute the following command:

`python Login.py`

This will start the log-in server on port 6112. It currently handles all incoming XML-based data with the exception of the log-in packet - when the log-in packet is received, the server only outputs the name of the user who's attempting to sign in. This is due to the fact that the server currently lacks a database.

## Features
There aren't any sepcial features worth mentioning at the moment, but stay tuned!

## A Brief Overview
### [Penguin.py](Avalanche/Penguin.py)
#### ClubPenguinClient
This class is a child of [object](https://docs.python.org/2/library/functions.html#object) and [twisted.protocols.basic.LineReceiver](http://twistedmatrix.com/documents/current/api/twisted.protocols.basic.LineReceiver.html). This class deals with handling the client handshake, which includes the API version-check, as well as the random-key and cross-domain policy requests. It also takes care of the parsing aspect of the server (for now) and invokes the functions located in the handler dictionaries when necessary.
#### Spheniscidae
Handles the initial sign-in process where the client is given a **log-in** key to join a server.
#### Penguin
Handles the second sign-in process where the client actually joins a **server** (or "world").

### [PenguinFactory.py](Avalanche/Penguin.py)
#### PenguinFactory
Creates instances of either **Spheniscidae** or **Penguin** depending on the protocol specified in the consturctor.

## Todo
- [ ] [Check if username(s) exists](Avalanche/Penguin.py#L109)
	- [ ] Along with this, make sure ids exist as well
- [ ] Implement ban system (not a priority for the alpha release)
- [ ] Make sure that XML values in incoming data are safe to use
	- [ ] Find an efficient way to escape strings in queries
- [ ] Make a data-parser module
	- [ ] Isolate it
	- [ ] Move the code that's use to parse XML to this module
- [ ] Find a **less** [verbose way](Avalanche/Penguin.py#L123) of creating MD5 hexadecimal digests
- [ ] Document code
- [ ] Finish the [login procedure](Avalanche/Penguin.py#L154) for the world server
	- [ ] **Join World** (j#js)
		- [ ] Involves hash comparison. Take a look at how it was done in Kitsune
	- [ ] **Get Inventory** (i#gi)
		- [ ] Deffered threads would be great for this
	- [ ] **Join Room** (j#jr)
		- [ ] Send the client to a random room on-login
		- [ ] Requires creation of room class for room management
	- [ ] Secure the procedure!
- [ ] Remember that clients who have not completely identified themselves may not (and *should not*) be allowed to send game data
	- [ ] Users who haven't sent the **j#js** (Join World) reuest should not be heavily restricted - this means no room joining, etc
- [ ] Basic functionality
	- [ ] **Waddling** (u#sp)
	- [ ] **Buying inventory** (i#ai)
		- [ ] Very that the item is valid
		- [ ] Implement coin deduction using crumbs-cache
	- [ ] **Messaging** (m#sm)
	- [ ] **Emoticons** (u#se)
	- [ ] **Jokes** (u#sj*?*)
	- [ ] **Actions and frames** (u#sa, u#sf*?*)
	- [ ] Check that arguments are valid (e.g ids are numerical, etc)
- [ ] Implement a cache system for items, furniture, igloos, etc
- [ ] Isolate the [Penguin](Avalanche/Penguin.py) class and make it extensible
- [ ] Isolate handler functions (**?**)