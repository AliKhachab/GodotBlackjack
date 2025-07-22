const CARD_SHEET = preload("res://assets/sprites/cardsLarge_tilemap_packed.png")
const CARD_GRID_SIZE = 64
const CARD_WIDTH = 42
const CARD_HEIGHT = 60
const COLUMNS = 13 # there are 14 rows in the spritesheet but im only using 13 for the relevant playing cards
const ROWS = 4
static var card_textures := {}
const CARDS = {
	"2S": ["2", "S"], 
	"2D": ["2", "D"], 
	"2C": ["2", "C"], 
	"2H": ["2", "H"],
	"3S": ["3", "S"], 
	"3D": ["3", "D"], 
	"3C": ["3", "C"], 
	"3H": ["3", "H"],
	"4S": ["4", "S"], 
	"4D": ["4", "D"], 
	"4C": ["4", "C"], 
	"4H": ["4", "H"],
	"5S": ["5", "S"], 
	"5D": ["5", "D"], 
	"5C": ["5", "C"], 
	"5H": ["5", "H"],
	"6S": ["6", "S"], 
	"6D": ["6", "D"], 
	"6C": ["6", "C"], 
	"6H": ["6", "H"],
	"7S": ["7", "S"], 
	"7D": ["7", "D"], 
	"7C": ["7", "C"], 
	"7H": ["7", "H"],
	"8S": ["8", "S"], 
	"8D": ["8", "D"], 
	"8C": ["8", "C"], 
	"8H": ["8", "H"],
	"9S": ["9", "S"], 
	"9D": ["9", "D"], 
	"9C": ["9", "C"], 
	"9H": ["9", "H"],
	"10S": ["10", "S"], 
	"10D": ["10", "D"], 
	"10C": ["10", "C"],
	"10H": ["10", "H"],
	"JS": ["J", "S"], 
	"JD": ["J", "D"], 
	"JC": ["J", "C"], 
	"JH": ["J", "H"],
	"QS": ["Q", "S"], 
	"QD": ["Q", "D"], 
	"QC": ["Q", "C"], 
	"QH": ["Q", "H"],
	"KS": ["K", "S"], 
	"KD": ["K", "D"], 
	"KC": ["K", "C"], 
	"KH": ["K", "H"],
	"AS": ["A", "S"], 
	"AD": ["A", "D"], 
	"AC": ["A", "C"], 
	"AH": ["A", "H"]
}

const SUITS = {
	"H": "Hearts",
	"D": "Diamonds",
	"S": "Spades",
	"C": "Clubs"
}

const RANKS = {
	"A": "Ace",
	"K": "King",
	"Q": "Queen",
	"J": "Jack",
	"10": "10",
	"9": "9",
	"8": "8",
	"7": "7",
	"6": "6",
	"5": "5",
	"4": "4",
	"3": "3",
	"2": "2"
}

static func initialize_card_textures():
	var suits = ["S", "D", "C", "H"]
	var ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]

	for row in range(ROWS):
		for col in range(COLUMNS):
			var card_key = ranks[col] + suits[row]
			var region = Rect2(
				col * CARD_GRID_SIZE + 11,
				row * CARD_GRID_SIZE + 2,
				CARD_WIDTH,
				CARD_HEIGHT
			)
			# Rect2(x, y, width, height) (x,y) at top left.
			var tex = AtlasTexture.new()
			tex.atlas = CARD_SHEET
			tex.region = region
			card_textures[card_key] = tex

func expand_card_name(card_key: String) -> String:
	var rank = CARDS[card_key][0]
	var suit = CARDS[card_key][1]
	return RANKS[rank] + " of " + SUITS[suit]

static func generate_standard_deck(deck: Array[String]):
	var suits := ["S", "D", "C", "H"]
	var ranks := ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]  
	for i in ranks:
		for j in suits:
			deck.append(i+j)

static func get_rank_from_code(card: Card) -> String:
	# Take the first character in the string. Correspond it to a rank in RANKS dictionary.
	if card.card_code:
		if len(card.card_code) == 2: # return the first character (i.e. K, 9)
			return card.card_code[0]
		else: 
			return "10" # in case the code is not 2 characters long i.e. AH, KC, that means it is 3 characters long
			# i.e. 10D, so we just return "10" since it has to be a rank of 10.
	else:
		printerr("NEGATIVE ONE FOR SOME REASON")
		return "-1"
