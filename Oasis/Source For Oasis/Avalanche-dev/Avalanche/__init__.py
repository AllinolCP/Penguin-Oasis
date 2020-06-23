import logging

# Just sets up logging, nothing to do with the networking aspect of the server
logger = logging.getLogger("Avalanche")
logger.setLevel(logging.DEBUG)

formatter = logging.Formatter("%(asctime)s %(levelname)s: %(message)s", "%I:%M:%S")

steamHandler = logging.StreamHandler()

steamHandler.setFormatter(formatter)
logger.addHandler(steamHandler)