
'               A long time ago, in a galaxy far, far away...
'
'                      STAR WARS PLANETS: PARTY EDITION
'                              by David Benson
'
'       Star Wars Planets is a game that mixes text adventure, board, and
' multiplayer games all into one.
' Features wanted to include:
' 1. Land/Property colonization and management
' 2. Bartering, trading, and shops
' 3. Numerous occupations like shopkeeper, bounty hunter, weapons designer,
'    used ship salesperson, adventurer, soldier (, and later politician,
'    smuggler, biologist, & hunter)
' 4. City founding
' 5. actual massive 'Smart' AIs - or at least smart enough to act like normal
'    people to passers-by (who don't run away to corners in the desert and
'    into walls fighting blindly with anyone in contact, and who don't give
'    new objects away for $0.02 if you ask them enough)
' 6. Interaction in a turn-based game (with AI, other players, ghost AI, etc.)
' 7. A good battle system with fair play
' 8. Explorable lands where players can live wherever they want
' 9. Skill levels
'10. Ability to add plotline for different players (a.k.a. Captain Typho,
'    Jedi, etc.)
'11. To make all the above features into an enjoyable FUN text game (if there
'    is such a thing) that would appeal to 10 people to play for at least
'    20 minutes, and that would seem realistic

' NOTE: For all you people wanting realtime action, just try to get 10 people
' to play at the same computer at once - JUST TRY (I did-not good)
'
DECLARE SUB EnterMe (p)
DECLARE FUNCTION Fluctuate& (amt AS LONG, mul AS SINGLE)
DECLARE FUNCTION People (a AS INTEGER, b AS INTEGER, c AS INTEGER)
DECLARE FUNCTION Days ()
DECLARE FUNCTION InMonth ()
CLS
COLOR 0, 2
CLS

CONST Version = 2.01
CONST gName$ = "Star Wars: Planets Party Edition"

DIM oName(100) AS STRING                        'Object's Names
DIM oProp(100, 5) AS LONG                       'Object Properties - unused currently
DIM pObjects(1 TO 10, 100) AS LONG              'Player's Objects - how many objects each player has
DIM pName(1 TO 10) AS STRING                    'Player's Names
DIM SHARED pStat(1 TO 10, 10) AS INTEGER        'Player Statistics - location, health, training, etc.
DIM lName(4) AS STRING                          'Location Names
DIM lGrid(4, -2 TO 12, -2 TO 12, 6) AS INTEGER  'Location Grid Map
DIM lGridName(4, 10, 10) AS STRING              'Location Grid Map Names
DIM holonet(10)  AS STRING                      'Holonet Forums
DIM aiName(1 TO 30)  AS STRING                  'AI's Names
DIM SHARED aiStat(1 TO 30, 4) AS INTEGER        'AI Statistics - location, toughness
DIM gStat(4) AS LONG                            'Game Statistics - type of game
DIM aiGoal(16 TO 30, 4) AS INTEGER              'AI goals for each character
DIM T(6) AS LONG                                'Temp
DIM aiThink(26, 1) AS INTEGER                   'AI Thought temporary variables
DIM mDroid(6) AS INTEGER                        'Messenger Droid numbers
DIM mDroidLetter(6) AS STRING                   'Messenger Droid messages
DIM SHARED pNum AS INTEGER                      'Number of players
DIM bPrint(10, 5, 6) AS INTEGER
DIM SHARED lps AS LONG
DIM SHARED time AS LONG
PRINT
PRINT "                                  Loading..."
'
' Memory Needed: 16 KB in vars, 26 KB in program = 42 K Memory Needed
'pNum - # of players
'
'pStat (x,0) - Location (1-4)
'pStat (x,1) - X grid location
'pStat (x,2) - Y grid location
'pStat (x,3) - HPs
'pStat (x,4) - Health ( goes down when you don't eat food, get sick)
'pStat (x,5) - Skill Level
'pStat (x,6) - Craftsmanship Level (not yet implemented)
'pStat (x,7) - Job ID
'pStat (x,8) -
'
'Instructions:
'lGrid: every space (x,x,x,0) may have somthing on it of these types:
'0 - Blank
'1 - Protected
'2 - Forest
'3 - Housing
'4 - Shop
'5 - Farm
'6 - Resturaunt
'7 - Food Stall
'8 - Warehouse
'9 - Spaceport
'10 - Docking Bay
'11 - Guard Station
'12 - Guild Location
'13 - Hiring Station
'14 - Palace
'15 - Factory
'16 - Designer's Office

'define AI
FOR i = 1 TO 15
	RANDOMIZE TIMER
	aiStat(i, 0) = INT(RND * 5)
	RANDOMIZE TIMER
	aiStat(i, 1) = INT(RND * 10)
	RANDOMIZE TIMER
	aiStat(i, 2) = INT(RND * 10)
NEXT i
aiName(1) = "Jabba"
aiStat(1, 0) = 0
aiName(2) = "Adi Gala"
aiStat(2, 0) = 4
aiName(3) = "Watto"
aiStat(3, 0) = 0
aiName(4) = "Sebulba"
aiStat(4, 0) = 0
aiName(5) = "A Vendor"
aiName(6) = "Goui Antilles"
aiStat(6, 0) = 3
aiName(7) = "Fa'hhi'uoi"
aiName(8) = "A Selonian"
aiStat(8, 0) = 4
aiName(9) = "Dunaro"
aiStat(9, 0) = 1
aiName(10) = "Tid-Ron"
aiName(11) = "Jango Fett"
aiName(12) = "Captain Tarpals"
aiStat(12, 0) = 1
aiName(13) = "A Rodian"
aiName(14) = "Windy"
aiName(15) = "Ha'tui'olo"
aiName(16) = "A Wookie"
aiName(16) = "Senator Madilial"
aiName(17) = "Aurra Sing"
aiName(18) = "Dunaro"
aiName(19) = "A Black Sun Merchant"
aiName(20) = "Kei-Choe Gasud"
aiName(21) = "Kenth Dagobi"
aiName(22) = "Ben Durrin"
aiName(23) = "A Clonetrooper"
aiName(24) = "A Clonetrooper"
aiName(25) = "A Clonetrooper"

'define objects------------------------------------------
i = 0
OPEN "c:\progra~2\q-basic\david\swpObj.Dat" FOR INPUT AS #1
DO UNTIL EOF(1) = true OR i = 101
	INPUT #1, oName(i), oProp(i, 0), oProp(i, 1)
	i = i + 1
LOOP
CLOSE #1
Objects = i

'Fluctuate prices
FOR i = 1 TO Objects
	'PRINT oProp(i, 1),
	oProp(i, 1) = Fluctuate(oProp(i, 1), .1)
	'PRINT oProp(i, 1), oName(i)
NEXT

'define maps

RANDOMIZE TIMER
lName(0) = "Tatooine"
lGridName(0, 5, 6) = "a Mos Eisly docking bay"
lGrid(0, 5, 6, 0) = 10
lGrid(0, 5, 6, 1) = INT(RND * 500) + 75
FOR ii = 0 TO 10
	lGrid(0, ii, 0, 0) = 1
	lGridName(0, ii, 0) = "a strip of dessert"
	lGrid(0, ii, 10, 0) = 1
	lGridName(0, ii, 10) = "the Dune Sea"
	lGrid(0, 0, ii, 0) = 1
	lGridName(0, 0, ii) = "a strip of dessert"
	lGrid(0, 10, ii, 0) = 1
	lGridName(0, 10, ii) = "a strip of dessert"
NEXT

RANDOMIZE TIMER
lName(1) = "Naboo"
lGridName(1, 5, 6) = "the Naboo Royal Hanger"
lGrid(1, 5, 6, 0) = 10
lGrid(1, 5, 6, 1) = INT(RND * 500) + 75
FOR ii = 0 TO 10
	lGrid(1, ii, 0, 0) = 1
	lGridName(1, ii, 0) = "a swampy marsh"
	lGrid(1, ii, 10, 0) = 1
	lGridName(1, ii, 10) = "a flat grassy plain"
	lGrid(1, 0, ii, 0) = 1
	lGridName(1, 0, ii) = "a swampy marsh"
	lGrid(1, 10, ii, 0) = 1
	lGridName(1, 10, ii) = "a flat grassy plain"
NEXT

RANDOMIZE TIMER
lName(2) = "Coruscant"
lGridName(2, 5, 6) = "a Coruscant docking bay"
lGrid(2, 5, 6, 0) = 10
lGrid(2, 5, 6, 1) = INT(RND * 500) + 75
FOR ii = 0 TO 10
	lGrid(2, ii, 0, 0) = 1
	lGridName(2, ii, 0) = "a unknown strip of buildings"
	lGrid(2, ii, 10, 0) = 1
	lGridName(2, ii, 10) = "a unknown strip of buildings"
	lGrid(2, 0, ii, 0) = 1
	lGridName(2, 0, ii) = "a run down apartment complex"
	lGrid(2, 10, ii, 0) = 1
	lGridName(2, 10, ii) = "a unknown strip of buildings"
NEXT
RANDOMIZE TIMER
lGridName(2, 3, 1) = "a Coruscant docking bay"
lGrid(2, 3, 1, 0) = 10
lGrid(2, 3, 1, 1) = INT(RND * 500) + 75

RANDOMIZE TIMER
lName(3) = "Corellia"
lGridName(3, 5, 6) = "a Corellian Hanger"
lGrid(3, 5, 6, 0) = 10
lGrid(3, 5, 6, 1) = INT(RND * 500) + 75
FOR ii = 0 TO 10
	lGrid(3, ii, 0, 0) = 1
	lGridName(3, ii, 0) = "a sandy beach"
	lGrid(3, ii, 10, 0) = 1
	lGridName(3, ii, 10) = "a flat grassy plain"
	lGrid(3, 0, ii, 0) = 1
	lGridName(3, 0, ii) = "a sandy beach"
	lGrid(3, 10, ii, 0) = 1
	lGridName(3, 10, ii) = "a flat grassy plain"
NEXT

'get speed

T(0) = TIMER
DO
	T(1) = T(1) + 1
	T(2) = TIMER
LOOP WHILE T(2) < T(0) + 2.2
lps = T(1) / 2

'----------------------------introduction-really long-------------------------
CLS
LOCATE 12, 32
PRINT "Deches Presents"
SLEEP 1
FOR i = 1 TO 12
	FOR ii = 1 TO lps * 1.2: NEXT
	PRINT
NEXT
PRINT TAB(27); "Our 2002 Game of the Year"
FOR i = 1 TO 12
	FOR ii = 1 TO lps * 1.2: NEXT
	PRINT
NEXT
SLEEP 2
PRINT TAB(24); "Star Wars: Planets - Party Edition"
FOR i = 1 TO 12
	FOR ii = 1 TO lps * 1.2: NEXT
	PRINT
NEXT
SLEEP 4

50 CLS '----------------------------The game starts here------------------------
PRINT
PRINT " Welcome to Star Wars Planets, Party Edition. This editon of SW planets"
PRINT " is turn-based, with up to 10 players. How many players do you wish to"
INPUT " have"; pNum
IF pNum > 10 THEN 50
PRINT
PRINT " Select Game Type:"
PRINT " 1. To X Credits         2. Forever"
PRINT " 3. To X Objects         4. Event-Driven (Only in Ver. 2)"
DO
	k$ = LCASE$(INKEY$)
LOOP WHILE k$ = ""
SELECT CASE k$
CASE "1"
	gStat(0) = 0
	PRINT " To X Credits"
	INPUT " How Many"; gStat(1)
CASE "2"
	PRINT " Forever"
	'Do Nothing
CASE "3"
	PRINT " To X Objects"
	PRINT " Which Object (see guide for ID Numbers)?"
	INPUT " ", gStat(0)
	INPUT " How Many"; gStat(1)
CASE ELSE
	PRINT " Not available. Redo"
	GOTO 50
END SELECT

FOR i = 1 TO pNum
	pObjects(i, 0) = 8000
	RANDOMIZE TIMER
	pObjects(i, INT(RND * 24) + 1) = 1
	pObjects(i, 48) = 10
	RANDOMIZE TIMER
	pStat(i, 1) = INT(RND * 10) + 1
	RANDOMIZE TIMER
	pStat(i, 2) = INT(RND * 10) + 1
	RANDOMIZE TIMER
	pStat(i, 0) = INT(RND * 4)
	GOSUB devCheat
	PRINT " Player "; i; ", you have 1000 character points."
	INPUT " What is your name"; pName(i)
60
	T(0) = 1000
	INPUT " How many HPs do you want"; pStat(i, 3)
	T(0) = T(0) - pStat(i, 3)
	IF T(0) < 0 THEN 60
	PRINT " Which skill level are you at (Choose one)? 1. Unskilled (0 pts.)"
	PRINT " 2. Basic skills (25 pts.) 3. Warrior (80 pts.) 4. Mechanical (100 pts.)"
	PRINT " 5-7. Official (90, 120, 150) 8. Specialized (300 pts.)"
	INPUT " ", pStat(i, 5)
	IF pStat(i, 5) = 2 THEN T(0) = T(0) - 25
	IF pStat(i, 5) = 3 THEN T(0) = T(0) - 80
	IF pStat(i, 5) = 4 THEN T(0) = T(0) - 100
	IF pStat(i, 5) = 5 THEN T(0) = T(0) - 90
	IF pStat(i, 5) = 6 THEN T(0) = T(0) - 120
	IF pStat(i, 5) = 7 THEN T(0) = T(0) - 150
	IF pStat(i, 5) = 8 THEN T(0) = T(0) - 300
	IF T(0) < 0 THEN 60
	INPUT " How many extra credits do you want (x10)"; T(1)
	T(0) = T(0) - T(1)
	IF T(0) < 0 THEN 60
	pObjects(i, 0) = pObjects(i, 0) + T(1) * 10
	pStat(i, 10) = 1 'Errorlevel - lets you haves special events
NEXT i

DO '-----------------Begin Main-------------------------
	rounds = rounds + 1

	FOR p = 1 TO pNum
		IF pStat(p, 0) = -1 THEN p = p + 1
		time = 0
		CLS
		PRINT " Player "; p; ", your turn.                "
		INPUT " ", r$
		IF mDroid(1) = p THEN
			PRINT " A messenger droid from "; pName(mDroid(0)); " appears"
			PRINT " offering to trade "; mDroid(5); oName(mDroid(3))
			PRINT " for "; mDroid(4); oName(mDroid(2))
			PRINT " Do you accept (Y/N)?"
			k$ = ""
			DO
				k$ = LCASE$(INKEY$)
			LOOP WHILE k$ = ""
			IF k$ = "y" THEN GOSUB 7500
		END IF

		100 '------------------------Draw Menu--------------------
		CLS
		PRINT " Star Wars Planets - Party Edition"
		PRINT "   Day:     of 30. You are at   ,    on "; lName(pStat(p, 0))
		PRINT
		PRINT
		PRINT
		PRINT "  1. Build          N. North"
		PRINT "  2. Trade          S. South"
		PRINT "  3. Show Map       E. East"
		PRINT "  4. Show Objects   W. West"
		PRINT "  5. Holonet        F. Fly to next planet"
		PRINT "  6. Enter          X. End Turn"
		PRINT "  7. Information    P. Pause"
		PRINT "  8. Fight          H. Increase Health"
		PRINT
		PRINT " Your choice, "; pName(p); "?"
		200 '---------------------Time Generator---------------------------
		LOCATE 2, 31
		PRINT pStat(p, 1)
		LOCATE 2, 35
		PRINT pStat(p, 2)
		k$ = ""
		LOCATE 3, 1 '---print description
		IF lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2)) <> "" THEN
			PRINT " You are at "; lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2))
		END IF

		LOCATE 4, 1
		FOR i = 1 TO pNum
			IF i = p THEN i = i + 1
			IF pStat(i, 0) = pStat(p, 0) AND pStat(i, 1) = pStat(p, 1) AND pStat(i, 2) = pStat(p, 2) THEN
				PRINT " "; pName(i); " is here. ";
			END IF
		NEXT i
		FOR i = 1 TO 15
			IF aiStat(i, 0) = pStat(p, 0) AND aiStat(i, 1) = pStat(p, 1) AND aiStat(i, 2) = pStat(p, 2) THEN
				PRINT " "; aiName(i); " is here. ";
			END IF
		NEXT i

		PRINT

		DO
			time = time + 1
			LOCATE 2, 9
			PRINT Days
			k$ = INKEY$
		LOOP WHILE k$ = "" AND InMonth
		IF InMonth = 0 THEN 1000
		SELECT CASE k$
			CASE CHR$(0) + "H": k$ = "s"
			CASE CHR$(0) + "P": k$ = "n"
			CASE CHR$(0) + "K": k$ = "w"
			CASE CHR$(0) + "M": k$ = "e"
			CASE ELSE
		END SELECT
		k$ = LCASE$(k$)
		'-------------------------------------Main----------------------------
		IF k$ = "p" THEN SLEEP
		IF k$ = "n" AND pStat(p, 2) < 10 THEN pStat(p, 2) = pStat(p, 2) + 1: GOTO 100
		IF k$ = "s" AND pStat(p, 2) > 0 THEN pStat(p, 2) = pStat(p, 2) - 1: GOTO 100
		IF k$ = "e" AND pStat(p, 1) < 10 THEN pStat(p, 1) = pStat(p, 1) + 1: GOTO 100
		IF k$ = "w" AND pStat(p, 1) > 0 THEN pStat(p, 1) = pStat(p, 1) - 1: GOTO 100
		IF k$ = "f" THEN '-----------Hyperspace Travel (.3 pages)---------------
			FOR i = 25 TO 30
				IF pObjects(p, i) > 0 THEN
					pStat(p, 0) = pStat(p, 0) + 1
					PRINT "Traveling Through Hyperspace..."
					time = time + (6 * lps)
					SLEEP 3
					IF pStat(p, 0) = 4 THEN pStat(p, 0) = 0
					GOTO 100
				END IF
			NEXT
		END IF           '-------------------------------------------------------
		IF k$ = "x" THEN 1000
		IF k$ = "h" THEN 15000
		IF k$ = "1" THEN
			GOSUB 3000
			GOTO 100
		ELSEIF k$ = "2" THEN
			GOSUB 7000
			GOTO 100
		ELSEIF k$ = "3" THEN
			GOSUB 2000
			GOTO 100
		ELSEIF k$ = "4" THEN
			GOSUB 5000
			GOTO 100
		ELSEIF k$ = "5" THEN
			GOSUB 4000
			GOTO 100
		ELSEIF k$ = "6" THEN
			GOSUB 8000
			GOTO 100
		ELSEIF k$ = "7" THEN
			GOSUB 6000
			GOTO 100
		END IF
		GOTO 200
		'-----------------loop----------------
1000
		GOSUB 10000
		GOSUB 13000
	NEXT p
	GOSUB 11000
	CLS
	k$ = ""
	IF gStat(1) > 0 THEN
		FOR i = 1 TO pNum
			IF pObjects(i, gStat(0)) > aiThink(0, 0) THEN
				aiThink(0, 0) = pObjects(i, gStat(0))
				aiThink(0, 1) = i
			END IF
		NEXT
		IF aiThink(0, 0) >= gStat(1) THEN
			i = aiThink(0, 1)
			CLS
			PRINT " "; pName(i); " has won with "; pObjects(i, gStat(0)); " "; oName(gStat(0))
			PRINT
			PRINT "Do you want to see information about the other players(y/N)?"
			INPUT " ", k$
			IF LCASE$(k$) = "y" THEN 12000
			END
		END IF
	END IF
	FOR i = 1 TO lps: NEXT i
	PRINT "Years ("; p; " Months): "; rounds
	PRINT "Continue (y)/n?"
	time = 0
	DO
		k$ = LCASE$(INKEY$)
		time = time + 1
	LOOP WHILE time < (10 * lps) AND k$ = ""
	IF k$ = "n" THEN END
1900 LOOP
2000 '----------Map--------------------(2 pages)
	CLS
	COLOR 0, 15
	FOR i = 0 TO 11
		FOR ii = 0 TO 11
			LOCATE ii + 1, (i * 2) + 2
			IF lGrid(pStat(p, 0), i, ii, 0) = 3 THEN
				PRINT "H "' house
			ELSEIF lGrid(pStat(p, 0), i, ii, 0) = 4 THEN
				PRINT "S "' shop
			ELSEIF lGrid(pStat(p, 0), i, ii, 0) = 5 THEN
				PRINT "F "' farm
			ELSEIF lGrid(pStat(p, 0), i, ii, 0) = 6 THEN
				PRINT "R "' restuaunt
			ELSEIF lGrid(pStat(p, 0), i, ii, 0) = 7 THEN
				PRINT "S "' food shop
			ELSEIF lGrid(pStat(p, 0), i, ii, 0) = 8 THEN
				PRINT "W "' warehouse
			ELSEIF lGrid(pStat(p, 0), i, ii, 0) = 9 THEN
				PRINT "A "' spaceport
			ELSEIF lGrid(pStat(p, 0), i, ii, 0) = 10 THEN
				PRINT "D "'docking bay
			ELSEIF lGrid(pStat(p, 0), i, ii, 0) = 11 THEN
				PRINT "G "'guard station
			ELSEIF lGrid(pStat(p, 0), i, ii, 0) = 12 THEN
				PRINT "B "'business - guild
			ELSEIF lGrid(pStat(p, 0), i, ii, 0) = 13 THEN
				PRINT "B "'business - hire
			ELSEIF lGrid(pStat(p, 0), i, ii, 0) = 14 THEN
				PRINT "P "'palace
			ELSEIF lGrid(pStat(p, 0), i, ii, 0) = 15 THEN
				PRINT "B "'business - factory
			ELSEIF lGrid(pStat(p, 0), i, ii, 0) = 16 THEN
				PRINT "B "'business - office
			ELSE
				PRINT "  "
			END IF
		NEXT
	NEXT
	FOR i = 1 TO 12
		LOCATE i, 24
		PRINT "³"
		LOCATE i, 1
		PRINT " ³"
	NEXT
	LOCATE 1, 1
	PRINT " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
	LOCATE 13, 1
	PRINT " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄß "
	FOR i = 1 TO 15
		IF aiStat(i, 0) = pStat(p, 0) THEN
			LOCATE aiStat(i, 2) + 2, aiStat(i, 1) * 2 + 3
			PRINT "O"
		END IF
	NEXT
	FOR i = 1 TO pNum
		IF pStat(i, 0) = pStat(p, 0) THEN
			LOCATE pStat(i, 2) + 2, pStat(i, 1) * 2 + 3
			PRINT "0"
		END IF
	NEXT
	LOCATE pStat(p, 2) + 2, pStat(p, 1) * 2 + 3
	PRINT "X"
	COLOR 0, 2
	LOCATE 17, 1
	PRINT "Done?"
	k$ = ""
	DO
		k$ = LCASE$(INKEY$)
		time = time + 1
		LOCATE 18, 1
		PRINT " Day: "; Days 'days
	LOOP WHILE InMonth AND k$ = ""
RETURN
3000 '-----------------------Build---------------------(7 pages)
	CLS
	PRINT " Welcome to Kaa'sta's construction guild."
	PRINT " We have a wide range of building for you to create."
	PRINT " Choose one:"
	PRINT " 1. Housing (1000 credits)       2. Shop (3500 credits)"
	PRINT " 3. Farm (1500 credits)          4. Resturaunt (3500 credits)"
	PRINT " 5. Food Stall (3000 credits)    6. Warehouse (2500 credits)"
	PRINT " 7. Palace (10000 credits)       8. Exit"
	PRINT
	k$ = ""
	DO
		k$ = LCASE$(INKEY$)
		time = time + 1
		LOCATE 10, 1
		PRINT " Day: "; Days
	LOOP WHILE InMonth AND k$ = ""

	IF InMonth = 0 OR k$ = "8" THEN RETURN
	m = 1
	IF lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 2 THEN m = 2

	SELECT CASE k$
	CASE "1"
		IF pObjects(p, 0) >= 1000 AND lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 0 OR lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 2 THEN
			PRINT "Constructing Housing..."
			pObjects(p, 0) = pObjects(p, 0) - 1000
			time = time + (6 * lps * m)
			SLEEP 3 * m
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 3
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 1) = p
			lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2)) = pName(p) + "'s Housing"
		END IF
	CASE "2"
		IF pObjects(p, 0) >= 3500 AND lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 0 OR lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 2 THEN
			PRINT "Enter the ID for the first object you want to sell."
			DO
				INPUT "", T(0)
			LOOP UNTIL T(0) < 42
			PRINT "What is the price in credits to sell for?"
			INPUT "", T(1)
			PRINT "Enter the ID for the second object you want to sell. (0 for none)"
			DO
				INPUT "", T(2)
			LOOP UNTIL T(2) < 42
			IF T(2) > 0 THEN PRINT "What is the price in credits to sell for?"
			IF T(2) > 0 THEN INPUT "", T(3)
			PRINT "Constructing Shop..."
			pObjects(p, 0) = pObjects(p, 0) - 3500
			time = time + (6 * lps * m)
			SLEEP 3 * m
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 4
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 1) = p
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 2) = T(0)
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 3) = T(1)
			IF T(2) > 0 THEN lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 4) = T(2)
			IF T(2) > 0 THEN lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 5) = T(3)
			lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2)) = pName(p) + "'s Shop"
		   
		ELSEIF lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 1) = p THEN
			PRINT "Change Shop"
			PRINT "Enter the ID for the first object you want to sell."
			DO
				INPUT "", T(0)
			LOOP UNTIL T(0) < 42
			PRINT "What is the price in credits to sell for?"
			INPUT "", T(1)
			PRINT "Enter the ID for the second object you want to sell. (0 for none)"
			DO
				INPUT "", T(2)
			LOOP UNTIL T(2) < 42
			IF T(2) > 0 THEN PRINT "What is the price in credits to sell for?"
			IF T(2) > 0 THEN INPUT "", T(3)
			PRINT "Restocking Shop..."
			time = time + (6 * lps * m)
			SLEEP 3 * m
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 4
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 1) = p
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 2) = T(0)
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 3) = T(1)
			IF T(2) > 0 THEN lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 4) = T(2)
			IF T(2) > 0 THEN lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 5) = T(3)
			lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2)) = pName(p) + "'s Shop"
		   
		END IF

	CASE "3"
		IF pObjects(p, 0) >= 1500 AND lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 0 OR lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 2 THEN
			PRINT "Constructing Farm..."
			pObjects(p, 0) = pObjects(p, 0) - 1500
			time = time + (4 * lps * m)
			SLEEP 2 * m
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 5
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 1) = p
			lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2)) = pName(p) + "'s Farm"
		END IF

	CASE "4"
		IF pObjects(p, 0) >= 3500 AND lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 0 OR lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 2 THEN
			PRINT "Enter the ID for the first food you want to serve."
			DO
				INPUT "", T(0)
			LOOP UNTIL T(0) < 50 AND T(0) > 45
			PRINT "What is the price in credits to sell for?"
			INPUT "", T(1)
			PRINT "Enter the ID for the second food you want to serve. (0 for none)"
			DO
				INPUT "", T(2)
			LOOP UNTIL T(2) > 45 AND T(2) < 50
			IF T(2) > 0 THEN PRINT "What is the price in credits to sell for?"
			IF T(2) > 0 THEN INPUT "", T(3)
			   
			PRINT "Constructing Resturaunt..."
			pObjects(p, 0) = pObjects(p, 0) - 3500
			time = time + (6 * lps * m)
			SLEEP 3 * m
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 6
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 1) = p
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 2) = T(0)
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 3) = T(1)
			IF T(2) > 0 THEN lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 4) = T(2)
			IF T(2) > 0 THEN lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 5) = T(3)
			lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2)) = pName(p) + "'s Resturaunt"
		   
		ELSEIF lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 1) = p THEN
			PRINT "Changing Resturaunt"
			PRINT "Enter the ID for the first food you want to serve."
			DO
				INPUT "", T(0)
			LOOP UNTIL T(0) < 50 AND T(0) > 45
			PRINT "What is the price in credits to sell for?"
			INPUT "", T(1)
			PRINT "Enter the ID for the second food you want to serve. (0 for none)"
			DO
				INPUT "", T(2)
			LOOP UNTIL T(2) > 45 AND T(2) < 50
			IF T(2) > 0 THEN PRINT "What is the price in credits to sell for?"
			IF T(2) > 0 THEN INPUT "", T(3)
			  
			PRINT "Restocking Resturaunt..."
			time = time + (6 * lps * m)
			SLEEP 3 * m
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 6
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 1) = p
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 2) = T(0)
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 3) = T(1)
			IF T(2) > 0 THEN lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 4) = T(2)
			IF T(2) > 0 THEN lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 5) = T(3)
			lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2)) = pName(p) + "'s Resturaunt"

		END IF

	CASE "5"
		IF pObjects(p, 0) >= 3000 AND lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 0 OR lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 2 THEN
			PRINT "Enter the ID for the first food you want to sell."
			DO
				INPUT "", T(0)
			LOOP UNTIL T(0) > 45 AND T(0) < 50
			PRINT "What is the price in credits to sell for?"
			INPUT "", T(1)
			PRINT "Enter the ID for the second food you want to sell. (0 for none)"
			DO
				INPUT "", T(2)
			LOOP UNTIL T(0) > 45 AND T(0) < 50
			IF T(2) > 0 THEN PRINT "What is the price in credits to sell for?"
			IF T(2) > 0 THEN INPUT "", T(3)
			   
			PRINT "Constructing Food Stall..."
			pObjects(p, 0) = pObjects(p, 0) - 3000
			time = time + (6 * lps * m)
			SLEEP 3 * m
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 7
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 1) = p
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 2) = T(0)
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 3) = T(1)
			IF T(2) > 0 THEN lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 4) = T(2)
			IF T(2) > 0 THEN lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 5) = T(3)
			   
			lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2)) = pName(p) + "'s Food Stall"
		   
		ELSEIF lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 1) = p THEN
			PRINT "Changing food stall"
			PRINT "Enter the ID for the first food you want to sell."
			DO
				INPUT "", T(0)
			LOOP UNTIL T(0) > 45 AND T(0) < 50
			PRINT "What is the price in credits to sell for?"
			INPUT "", T(1)
			PRINT "Enter the ID for the second food you want to sell. (0 for none)"
			DO
				INPUT "", T(2)
			LOOP UNTIL T(0) > 45 AND T(0) < 50
			IF T(2) > 0 THEN PRINT "What is the price in credits to sell for?"
			IF T(2) > 0 THEN INPUT "", T(3)
			  
			PRINT "Restocking Food Stall..."
			pObjects(p, 0) = pObjects(p, 0) - 3000
			time = time + (6 * lps * m)
			SLEEP 3 * m
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 7
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 1) = p
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 2) = T(0)
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 3) = T(1)
			IF T(2) > 0 THEN lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 4) = T(2)
			IF T(2) > 0 THEN lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 5) = T(3)
			  
			lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2)) = pName(p) + "'s Food Stall"
		   
		END IF

	CASE "6"
		IF pObjects(p, 0) >= 2500 AND lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 0 OR lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 2 THEN
			PRINT "Constructing Warehouse..."
			pObjects(p, 0) = pObjects(p, 0) - 2500
			time = time + (6 * lps * m)
			SLEEP 3 * m
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 8
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 1) = p
			pStat(p, 3) = pStat(p, 3) + 50
			lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2)) = pName(p) + "'s Warehouse"
		END IF

	CASE "7"
		IF pObjects(p, 0) >= 10000 AND lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 0 OR lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 2 THEN
			PRINT "Constructing Palace..."
			pObjects(p, 0) = pObjects(p, 0) - 10000
			time = time + (10 * lps * m)
			SLEEP 5 * m
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 14
			lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 1) = p
			lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2)) = pName(p) + "'s Palace"
		END IF

	CASE "8"
	END SELECT
RETURN
4000 '--------------------------holonet--------------------------(1.5 pages)
	CLS
	PRINT " You have accessed the Holonet. "
	FOR i = 1 TO 10
		PRINT " "; holonet(i)
	NEXT
	LOCATE 13, 1
	PRINT " 1. Add statement        2. Exit"
	k$ = ""
	DO
		k$ = LCASE$(INKEY$)
		time = time + 1
		LOCATE 14, 1
		PRINT " Day: "; Days
	LOOP WHILE InMonth AND k$ = ""
	IF InMonth = 0 OR k$ = "2" THEN RETURN
	IF k$ = "1" THEN
		FOR i = 2 TO 10
			holonet(i - 1) = holonet(i)
		NEXT i
		holonet(10) = pName(p) + ": "
		LINE INPUT " Add line: ", s$
		holonet(10) = holonet(10) + s$
		CLS
	END IF
GOTO 4000
5000 '------------------------Show Objects------------------------(1.5 pages)
	CLS
	T(0) = 1
	FOR i = 0 TO 50
		IF pObjects(p, i) > 0 THEN
			PRINT " # "; i; ": "; pObjects(p, i); " "; oName(i)
			T(0) = T(0) + 1
		END IF
		IF T(0) = 22 THEN
			k$ = ""
			DO
				k$ = LCASE$(INKEY$)
				time = time + 1
				LOCATE 23, 1
				PRINT " Hit Enter to continue. Day: "; Days
			LOOP WHILE InMonth AND k$ = ""
			IF InMonth = 0 THEN RETURN
			T(0) = 1
			CLS
		END IF
	NEXT
	k$ = ""
	DO
		k$ = LCASE$(INKEY$)
		time = time + 1
		LOCATE 23, 1
		PRINT " Hit Enter to continue. Day: "; Days
	LOOP WHILE InMonth AND k$ = ""
RETURN
6000 '-----------------Informational Services-------------------( 1 page)
	CLS
	PRINT " Welcome to Karrde's Information Group. Do you wish to see"
	PRINT " (1) Other player's stats, or (2) Object information"
	k$ = LCASE$(INKEY$)
	DO
		k$ = INKEY$
		time = time + 1
		LOCATE 3, 1
		PRINT " Day: "; Days
	LOOP WHILE InMonth AND k$ = ""
	IF InMonth = 0 OR k$ > "2" THEN RETURN
	IF k$ = "2" THEN 6200
	PRINT " Here's what we can give you:"
	FOR i = 1 TO pNum
		PRINT
		PRINT " "; pName(i); " is at "; pStat(i, 1); ", "; pStat(i, 2); " on "; lName(pStat(i, 0))
		PRINT " He/she currently has "; pObjects(i, 0); " credits."
	NEXT i
	GOTO 6800
6200
	CLS
	PRINT " Here are the pricings and object ID's:"
	FOR i = 1 TO Objects
		'oProp(i, 1) = Fluctuate(oProp(i, 1), .1)
		PRINT " #"; i, oProp(i, 1); " cr.", oName(i)
		IF i = 22 THEN SLEEP
		IF i = 44 THEN SLEEP
		IF i = 66 THEN SLEEP
		IF i = 88 THEN SLEEP
		IF i = 110 THEN SLEEP
	NEXT i
	SLEEP
	CLS
6800
	k$ = ""
	DO
		k$ = LCASE$(INKEY$)
		time = time + 1
		LOCATE 19, 1
		PRINT " Hit Enter to continue. Day: "; Days
	LOOP WHILE InMonth AND k$ = ""
RETURN
7000 '--------------------Trade---------------------(4 pages)
	CLS
	PRINT " Who do you wish to trade with?"
	PRINT
	FOR i = 1 TO pNum
		PRINT " "; i; ": "; pName(i)
	NEXT i
	k$ = ""
	DO
		k$ = LCASE$(INKEY$)
		time = time + 1
		LOCATE 9, 1
		PRINT "Day: "; Days
	LOOP WHILE InMonth AND k$ = ""
	IF time >= (60 * lps) THEN RETURN
	T(0) = VAL(k$)
	IF T(0) < 1 OR T(0) > pNum THEN RETURN
	CLS
7100 CLS
	PRINT " Welcome to the Traders Negotation Center, "; pName(p); "."
	PRINT " Refer to the guide of objects for ID Numbers."
	PRINT
	PRINT " Enter ID for object to get: "
	INPUT "", T(1)
	IF pObjects(T(0), T(1)) = 0 THEN 7100
7150
	PRINT " Enter ID for object to trade, or i to see your inventory: "
	INPUT "", k$
	IF k$ = "i" THEN GOSUB 5000
	T(2) = VAL(k$)
	IF pObjects(p, T(2)) = 0 THEN 7150
7200
	PRINT
	PRINT "Please enter amount decided to recieve."
	INPUT "", T(3)
	IF pObjects(T(0), T(1)) < T(3) THEN GOTO 7200
7300
	PRINT
	PRINT "Please enter amount decided to trade, 0 to cancel"
	INPUT "", t5
	IF t5 = 0 THEN RETURN
	IF pObjects(p, T(2)) = t5 THEN 7300

	PRINT "Your request will be sent via messenger droid to "; pName(T(0))
	mDroid(0) = p
	mDroid(1) = T(0)
	mDroid(2) = T(1)
	mDroid(3) = T(2)
	mDroid(4) = T(3)
	mDroid(5) = t5
	T(0) = 0
	DO
		T(0) = T(0) + 1
	LOOP WHILE T(0) < lps * 2
RETURN
7500 ' ---------trade
	pObjects(mDroid(1), mDroid(2)) = pObjects(mDroid(1), mDroid(2)) - mDroid(4)
	pObjects(mDroid(0), mDroid(2)) = pObjects(mDroid(0), mDroid(2)) + mDroid(4)
	pObjects(mDroid(0), mDroid(3)) = pObjects(mDroid(0), mDroid(3)) - mDroid(6)
	pObjects(mDroid(1), mDroid(3)) = pObjects(mDroid(1), mDroid(3)) + mDroid(6)
	PRINT "Transfer Complete"
	FOR i = 0 TO 6
		mDroid(i) = 0
	NEXT
	T(0) = 0
	DO
		T(0) = T(0) + 1
	LOOP WHILE T(0) < lps * 2
RETURN
8000 '--------------------------Enter------------------------(UC)
	T(1) = lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 1) 'name
	T(2) = lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 2)
	T(3) = lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 3)
	T(4) = lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 4)
	T(5) = lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 5)
	SELECT CASE lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) 'type
	CASE 4'-------------Shop-------------
		IF lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 6) = 1 THEN
			PRINT " Welcome to "; lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2))
			PRINT " We have (1.) "; oName(T(2)); "for sale."
			PRINT " They cost "; T(3); " credits each."
			IF T(4) > 0 THEN
				PRINT " And we also have (2.) "; oName(lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 4)); " for sale."
				PRINT " They cost "; T(5); " credits each."
			END IF
			PRINT " (Q.) Quit"
			k$ = ""
			DO
				k$ = LCASE$(INKEY$)
				time = time + 1
				LOCATE 7, 1
				PRINT " Type in your selection:          Day: "; Days
			LOOP WHILE InMonth AND k$ = ""
			IF k$ = "1" AND pObjects(T(1), T(2)) > 0 AND pObjects(p, 0) >= T(3) THEN
				pObjects(p, T(2)) = pObjects(p, T(2)) + 1
				pObjects(p, 0) = pObject(p, 0) - T(3)
			END IF
			IF k$ = "2" AND T(4) > 0 AND pObjects(T(0), T(4)) > 0 AND pObjects(p, 0) >= T(5) THEN
				pObjects(p, T(4)) = pObjects(p, T(4)) + 1
				pObjects(p, 0) = pObject(p, 0) - T(5)
		 
			END IF

		ELSE
			CLS
			PRINT " Welcome to "; lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2))
			IF pObjects(T(1), T(2)) > 0 THEN
				PRINT " We have (1.) "; pObjects(T(1), T(2)); " "; oName(T(2)); "for sale."
				PRINT " They cost "; T(3); " credits each."
			END IF
			IF T(4) > 0 AND pObjects(T(1), T(4)) > 0 THEN
				PRINT " And we also have (2.) "; pObjects(T(1), T(4)); " "; oName(lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 4)); " for sale."
				PRINT " They cost "; T(5); " credits each."
			END IF
			PRINT " (Q.) Quit"
			k$ = ""
			DO
				k$ = LCASE$(INKEY$)
				time = time + 1
				LOCATE 7, 1
				PRINT " Type in your selection:          Day: "; Days
			LOOP WHILE InMonth AND k$ = ""
			IF k$ = "1" AND pObjects(T(1), T(2)) > 0 AND pObjects(p, 0) >= T(3) THEN
				pObjects(T(1), T(2)) = pObjects(T(1), T(2)) - 1
				pObjects(T(1), 0) = pObject(T(1), 0) + T(3)
				pObjects(p, T(2)) = pObjects(p, T(2)) + 1
				pObjects(p, 0) = pObject(p, 0) - T(3)
			END IF
			IF k$ = "2" AND T(4) > 0 AND pObjects(T(0), T(4)) > 0 AND pObjects(p, 0) >= T(5) THEN
				pObjects(T(1), T(4)) = pObjects(T(1), T(4)) - 1
				pObjects(T(1), 0) = pObject(T(1), 0) + T(5)
				pObjects(p, T(4)) = pObjects(p, T(4)) + 1
				pObjects(p, 0) = pObject(p, 0) - T(5)
		  
			END IF
		END IF
	CASE 5'-------------Farm-------------------

	CASE 6'-------------Resturaunt-------------
		IF lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 6) = 1 THEN
			PRINT " Welcome to "; lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2))
			PRINT " We have (1.) "; oName(T(2)); "."
			PRINT " They cost "; T(3); " credits each."
			IF T(4) > 0 THEN
				PRINT " And we also have (2.) "; oName(lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 4)); "."
				PRINT " They cost "; T(5); " credits each."
			END IF
			PRINT " (Q.) Quit"
			k$ = ""
			DO
				k$ = LCASE$(INKEY$)
				time = time + 1
				LOCATE 7, 1
				PRINT " Type in your menu selection:          Day: "; Days
			LOOP WHILE InMonth AND k$ = ""
			IF k$ = "1" AND pObjects(T(1), T(2)) > 0 AND pObjects(p, 0) >= T(3) THEN
				pObjects(p, T(2)) = pObjects(p, T(2)) + 1
				pObjects(p, 0) = pObject(p, 0) - T(3)
			END IF
			IF k$ = "2" AND T(4) > 0 AND pObjects(T(0), T(4)) > 0 AND pObjects(p, 0) >= T(5) THEN
				pObjects(p, T(4)) = pObjects(p, T(4)) + 1
				pObjects(p, 0) = pObject(p, 0) - T(5)

			END IF

		ELSE
			CLS
			PRINT " Welcome to "; lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2))
			IF pObjects(T(1), T(2)) > 0 THEN
				PRINT " We have (1.) "; pObjects(T(1), T(2)); " "; oName(T(2)); "."
				PRINT " They cost "; T(3); " credits each."
			END IF
			IF T(4) > 0 AND pObjects(T(1), T(4)) > 0 THEN
				PRINT " And we also have (2.) "; pObjects(T(1), T(4)); " "; oName(lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 4)); "."
				PRINT " They cost "; T(5); " credits each."
			END IF
			PRINT " (Q.) Quit"
			k$ = ""
			DO
				k$ = LCASE$(INKEY$)
				time = time + 1
				LOCATE 7, 1
				PRINT " Type in your menu selection:          Day: "; Days
			LOOP WHILE InMonth AND k$ = ""
			IF k$ = "1" AND pObjects(T(1), T(2)) > 0 AND pObjects(p, 0) >= T(3) THEN
				pObjects(T(1), T(2)) = pObjects(T(1), T(2)) - 1
				pObjects(T(1), 0) = pObject(T(1), 0) + T(3)
				pObjects(p, T(2)) = pObjects(p, T(2)) + 1
				pObjects(p, 0) = pObject(p, 0) - T(3)
			END IF
			IF k$ = "2" AND T(4) > 0 AND pObjects(T(0), T(4)) > 0 AND pObjects(p, 0) >= T(5) THEN
				pObjects(T(1), T(4)) = pObjects(T(1), T(4)) - 1
				pObjects(T(1), 0) = pObject(T(1), 0) + T(5)
				pObjects(p, T(4)) = pObjects(p, T(4)) + 1
				pObjects(p, 0) = pObject(p, 0) - T(5)

			END IF
		END IF


	CASE 7'-------------Food Stall-------------
		IF lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 6) = 1 THEN
			PRINT " Welcome to "; lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2))
			PRINT " We have (1.) "; oName(T(2)); "for sale."
			PRINT " They cost "; T(3); " credits each."
			IF T(4) > 0 THEN
				PRINT " And we also have (2.) "; oName(lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 4)); " for sale."
				PRINT " They cost "; T(5); " credits each."
			END IF
			PRINT " (Q.) Quit"
			k$ = ""
			DO
				k$ = LCASE$(INKEY$)
				time = time + 1
				LOCATE 7, 1
				PRINT " Type in your selection:          Day: "; Days
			LOOP WHILE InMonth AND k$ = ""
			IF k$ = "1" AND pObjects(T(1), T(2)) > 0 AND pObjects(p, 0) >= T(3) THEN
				pObjects(p, T(2)) = pObjects(p, T(2)) + 1
				pObjects(p, 0) = pObject(p, 0) - T(3)
			END IF
			IF k$ = "2" AND T(4) > 0 AND pObjects(T(0), T(4)) > 0 AND pObjects(p, 0) >= T(5) THEN
				pObjects(p, T(4)) = pObjects(p, T(4)) + 1
				pObjects(p, 0) = pObject(p, 0) - T(5)

			END IF

		ELSE
			CLS
			PRINT " Welcome to "; lGridName(pStat(p, 0), pStat(p, 1), pStat(p, 2))
			IF pObjects(T(1), T(2)) > 0 THEN
				PRINT " We have (1.) "; pObjects(T(1), T(2)); " "; oName(T(2)); "for sale."
				PRINT " They cost "; T(3); " credits each."
			END IF
			IF T(4) > 0 AND pObjects(T(1), T(4)) > 0 THEN
				PRINT " And we also have (2.) "; pObjects(T(1), T(4)); " "; oName(lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 4)); " for sale."
				PRINT " They cost "; T(5); " credits each."
			END IF
			PRINT " (Q.) Quit"
			k$ = ""
			DO
				k$ = LCASE$(INKEY$)
				time = time + 1
				LOCATE 7, 1
				PRINT " Type in your selection:          Day: "; Days
			LOOP WHILE InMonth AND k$ = ""
			IF k$ = "1" AND pObjects(T(1), T(2)) > 0 AND pObjects(p, 0) >= T(3) THEN
				pObjects(T(1), T(2)) = pObjects(T(1), T(2)) - 1
				pObjects(T(1), 0) = pObject(T(1), 0) + T(3)
				pObjects(p, T(2)) = pObjects(p, T(2)) + 1
				pObjects(p, 0) = pObject(p, 0) - T(3)
			END IF
			IF k$ = "2" AND T(4) > 0 AND pObjects(T(0), T(4)) > 0 AND pObjects(p, 0) >= T(5) THEN
				pObjects(T(1), T(4)) = pObjects(T(1), T(4)) - 1
				pObjects(T(1), 0) = pObject(T(1), 0) + T(5)
				pObjects(p, T(4)) = pObjects(p, T(4)) + 1
				pObjects(p, 0) = pObject(p, 0) - T(5)
		 
			END IF
		END IF

	CASE 10  '-------------Docking Bay---------------
		CLS
		PRINT " Hello, I'm a smuggler out of Talon Karrde's group. I will take you to"
		PRINT " the planet of your choice for "; T(1); " credits. Whadaya say?"
		PRINT " 1. Yes          2. No"
		k$ = ""
		DO
			k$ = LCASE$(INKEY$)
			time = time + 1
			LOCATE 5, 1
			PRINT " Day: "; Days
		LOOP WHILE InMonth AND k$ = ""
		IF k$ = "1" THEN
			LOCATE 5, 1
			
			PRINT " Where to?   "
			FOR i = 0 TO 3
				PRINT " "; i; ". "; lName(i)
			NEXT
			k$ = ""
			DO
				k$ = LCASE$(INKEY$)
				time = time + 1
				LOCATE 14, 1
				PRINT "Day: "; Days
			LOOP WHILE InMonth AND k$ = ""
			IF VAL(k$) > -1 AND VAL(k$) < 4 THEN
				pStat(p, 0) = VAL(k$)
				pStat(p, 1) = 5
				pStat(p, 2) = 6
				pObjects(p, 0) = pObjects(p, 0) - T(1)
			END IF
		END IF
	END SELECT
RETURN
9000 '--------------------------Battle-------------------------------(UC)
	CLS
	FOR i = 1 TO pNum
	IF pStat(i, 0) = pStat(p, 0) AND pStat(i, 1) = pStat(p, 1) AND pStat(i, 2) = pStat(p, 2) AND pName(p) <> pName(i) THEN
		GOTO 9100
	END IF
	NEXT
	PRINT " No other person in area"
	SLEEP 2
	time = time + lps * 2
RETURN
9100
	IF lGrid(pStat(p, 0), pStat(p, 1), pStat(p, 2), 0) = 3 THEN
		PRINT " Cannot fight here"
		time = time + lps * 2
		SLEEP 2
		RETURN
	END IF
	PRINT " Battle - "; pName(p); " vs. "; pName(i)
	PRINT
	PRINT
	PRINT
	PRINT
	PRINT "  Q. Fire"
	PRINT "  W. Random Attack"
	PRINT "  E. Raise Shield"
	'PRINT "  A. Run"
9200
	LOCATE 2, 1
	PRINT "HP: "; pStat(p, 3), , , "HP: "; pStat(i, 3)
	PRINT "Weapon: "; oName(pStat(p, 4)), "Weapon: "; oName(pStat(i, 4))
	PRINT "Shield: "; pStat(p, 5), , "Shield: "; pStat(i, 5)
	time = time + lps * 2
	SLEEP 2
RETURN
10000 '-------------------------AI Holonet Com---------------------(3 pages)
	a$ = LCASE$(holonet(10))
	RANDOMIZE TIMER
	T(0) = INT(RND * 4) + 1
	k$ = ""
	IF INSTR(a$, "naboo ") AND INSTR(a$, "trade ") THEN
		SELECT CASE T(0)
		CASE 1
			k$ = "NabooCitizen: I hope the Trade Fed. doesn't try their tricks on us again."
		CASE 2
			k$ = "Haix Geoi: BTW, I am a traider on Naboo looking for business. Hire Me!"
		CASE 3
			k$ = "Captain Tarpals: What else? Mesa has been a bity sore since da battle."
		CASE 4
			k$ = "NeimodianAtLarge: We really fumbled that one at Naboo."
		END SELECT
	ELSEIF INSTR(a$, " bounty hunt") THEN
		SELECT CASE T(0)
		CASE 1
			k$ = "Jango Fett: I'm for hire in twelve days at the Houn'gi system"
		CASE 2
			k$ = "Aurra Sing: Hire me!"
		CASE 3
			  k$ = "You'uoth Ioti: Where?"
		CASE 4
			k$ = "Me: Ditto."
		END SELECT
	ELSEIF INSTR(a$, "ship ") THEN
		SELECT CASE T(0)
		CASE 1
			k$ = "Geoi Solo: I've got a ship someone could use, for a fee,"
		CASE 2
			k$ = "SalesDept: Let us get you a ship that will be your Friend!"
		CASE 3
			k$ = "Joi Frezh: Wow."
		CASE 4
			k$ = "Straggler: I need a fast ship on Malastare in two days."
		END SELECT
	ELSEIF INSTR(a$, "i can't(0) ") OR INSTR(a$, "i can not ") THEN
		SELECT CASE T(0)
		CASE 1
			k$ = "Mace Windu: Have you tried?"
		CASE 2
			k$ = "Gorga: Me, either."
		CASE 3
			k$ = "Haiiuuo: Sure?"
		CASE 4
			k$ = "Kau'dio: Bummer."
		END SELECT
	ELSEIF INSTR(a$, "shop ") THEN
		SELECT CASE T(0)
		CASE 1
			k$ = "Watto: Watto has the best deals on tatooine."
		CASE 2
			k$ = "Ugatoii: It's nearby, I think."
		CASE 3
			k$ = "Yod'ayo: Trade or trade not; there is no buy"
		CASE 4
			k$ = "Hmmm..."
		END SELECT
	ELSEIF INSTR(a$, "where is ") OR INSTR(a$, "where are ") THEN
		SELECT CASE T(0)
		CASE 1
			k$ = "F6-Y22: I will look for credits."
		CASE 2
			k$ = "C'boath: Somewhat of a distance away. :-)"
		CASE 3
			k$ = "EmpHand: I can look into the matter if you meet me at Dantooine in 3 days"
		CASE 4
			k$ = "Con.Gel: Who cares?"
		END SELECT
	ELSEIF INSTR(a$, "jk ") OR INSTR(a$, "Just kiddin") THEN
		k$ = "Haui: Ha Ha Ha."
	ELSEIF INSTR(a$, "smuggl") OR INSTR(a$, " smugl") THEN
		SELECT CASE T(0)
		CASE 1
			k$ = "Talon Karrde: SMG RUN open in 4.5 days in sector 43.23.16.7"
		CASE 2
			k$ = "Geoi Solo: Where?!?"
		CASE 3
			k$ = "Security: This channel is being investigated by Republic Security. If you are   doing somthing illegal, we will find you."
		CASE 4
			k$ = "AMan: I need someone to do a Kessel Run for me."
		END SELECT
	ELSE
		RANDOMIZE TIMER
		T(0) = INT(RND * 40) + 1
		SELECT CASE T(0)
		CASE 1
			k$ = "Industrial Automation: Special deal on R2 units at Malastare - 1/2 off!"
		CASE 3
			k$ = "XimMan: Anyone know where the nearest antique store is?"
		CASE 5
			k$ = "10X-231-435V: Hello everyone!"
		CASE 7
			k$ = "Republic Security: If 10X-231-435V offers to send you a file, do not accept it"
		CASE 9
			k$ = "Sebulba: Podracer for sale; slightly damaged with orange paint."
		CASE 11
			k$ = "Dorsk 15: This is only a test...AHHHHHHHHHHHHHHHHHHHH! (fun.)"
		CASE 13
			k$ = "Ditto: Me, too."
		CASE 15
			k$ = "10X-231-435V: I'm giving away a program - It'll make your datapad do cool stuff!"
		CASE 17
			k$ = "E-Quote HoloNetwork: Yoda - Always two there are, a master and an apprentice."
		CASE 19
			k$ = "E-Quote HoloNetwork: Unknown - Wipe them out,  all of them."
		CASE 21
			k$ = "E-Quote HoloNetwork: Qui-Gon - Promise me you will train the boy."
		CASE 23
			k$ = "E-Quote HoloNetwork: Kai'guh'thii - Whatever he says goes. Don't make him mad."
		CASE 25
			k$ = "IMus Fan: I'm trying to play music with text - Da Dah Duh - Da Da Da"
		CASE 27
			k$ = "SellBob: Plans for the Death Star - only 2999.99 credits each!"
		CASE 29
			k$ = "Republic Security: Please do not respond to SellBob. He is only a con artist."
		CASE 31
			k$ = "Corellian Engineering: We have the new YT-2000 prototype out for only 24999 cr."
		CASE 33
			k$ = "Cyborg Galactica: Isn't it about time you bought a Cyborg(tm)?"
		CASE 35
			k$ = "Republic Traiders, Inc: Get 1/2 off shipping rates to the Mid-Rim!"
		END SELECT
	END IF
	IF k$ <> "" THEN
		FOR i = 2 TO 10
			holonet(i - 1) = holonet(i)
		NEXT i
		holonet(10) = k$
		k$ = ""
	END IF
RETURN
11000 '-------------------------------Vitals-----------------------------------
	FOR i = 1 TO pNum
		pStat(i, 4) = pStat(i, 4) - 50
11100
		IF pObjects(i, 49) >= 1 THEN
			pObjects(i, 49) = pObjects(i, 49) - 1
			pStat(i, 4) = pStat(i, 4) + 45
		ELSEIF pObjects(i, 46) >= 1 THEN
			pObjects(i, 46) = pObjects(i, 46) - 1
			pStat(i, 4) = pStat(i, 4) + 39
		END IF
		IF pObjects(i, 48) >= 1 AND pStat(i, 4) < 85 THEN
			pObjects(i, 48) = pObjects(i, 48) - 1
			pStat(i, 4) = pStat(i, 4) + 21
		END IF
		IF pObjects(i, 47) >= 1 AND pStat(i, 4) < 90 THEN
			pObjects(i, 47) = pObjects(i, 47) - 1
			pStat(i, 4) = pStat(i, 4) + 15
		END IF

		IF pStat(i, 4) < 90 THEN
			IF pObjects(i, 46) > 1 OR pObjects(i, 47) > 1 OR pObjects(i, 48) > 1 OR pObjects(i, 49) > 1 THEN 11100
		END IF

		IF pStat(i, 4) < 1 THEN
			CLS
			PRINT pName(i); " has died of starvation or sickness."
			PRINT "Do you wish to continue, "; pName(i); " (y/n)?"
			T = 0
			k$ = ""
			DO
				k$ = INKEY$
				LOCATE 4, 1
				PRINT 5 - INT(T / lps); " seconds left"
				T = T + 1
			LOOP WHILE k$ = "" AND T < 5 * lps
			IF LCASE$(k$) = "y" THEN 11500
			pStat(p, 0) = -1
			pStat(p, 3) = 0
		END IF
11200 NEXT
	RETURN
11500
	FOR ii = 1 TO 50
		pObjects(i, ii) = 0
	NEXT
	pStat(i, 3) = 200
	pObjects(i, 48) = 10
	pStat(i, 4) = 100
	pObjects(i, 0) = 2000
	GOTO 11200

	devCheat: ' for the rich developers
	'RETURN  'when the game is run by normal people they start out poor!
		  'All because of a '
	pObjects(i, 0) = 10000
	FOR ii = 1 TO 50
		RANDOMIZE TIMER
		IF INT(RND * 2) THEN pObjects(i, ii) = 5
	NEXT
	RETURN
12000
	time = 32000
	FOR i = 1 TO pNum
		PRINT i; ". "; pName(i)
	NEXT
	PRINT "Whose info do you want to see (0 to exit)?"
	INPUT " ", p
	IF p > pNum THEN 12000
	IF p < 1 THEN END
	GOSUB 5000
	PRINT " Do you want to see the holonet too(y/N)?"
	INPUT " ", k$
	IF LCASE$(k$) = "y" THEN GOSUB 4000
GOTO 12000
13000 '-----------------------AI-------------------------
	'Price fluctuations
	FOR i = 1 TO Objects
		oProp(i, 1) = Fluctuate(oProp(i, 1), .08)
	NEXT
	'Character movements
	FOR i = 1 TO 25
		GOTO 13500
13200
		RANDOMIZE TIMER
		IF lGrid(aiStat(i, 0), aiStat(i, 1), aiStat(i, 2), 0) = 10 THEN aiStat(i, 0) = INT(RND) * 4
		RANDOMIZE TIMER
		aiStat(i, 1) = aiStat(i, 1) + INT(RND * 4) - 2
		RANDOMIZE TIMER
		IF aiStat(i, 1) > 10 THEN aiStat(i, 1) = INT(RND * 3) + 7
		IF aiStat(i, 1) < 0 THEN aiStat(i, 1) = INT(RND * 3)
		RANDOMIZE TIMER
		aiStat(i, 2) = aiStat(i, 2) + INT(RND * 4) - 2
		RANDOMIZE TIMER
		IF aiStat(i, 2) > 10 THEN aiStat(i, 2) = INT(RND * 3) + 7
		IF aiStat(i, 2) < 0 THEN aiStat(i, 2) = INT(RND * 3)
		RANDOMIZE TIMER
		IF lGrid(aiStat(i, 0), aiStat(i, 1), aiStat(i, 2), 0) = 10 THEN aiStat(i, 0) = INT(RND) * 4
		RETURN
13500
		GOSUB 13200
		T(0) = 0
		' Search for population centers
		FOR ii = (-2 + aiStat(i, 1)) TO (2 + aiStat(i, 1))
			FOR i2 = (-2 + aiStat(i, 2)) TO (2 + aiStat(i, 2))
				IF lGrid(aiStat(i, 0), ii, i2, 0) > 6 THEN
					aiThink(T(0), 0) = ii
					aiThink(T(0), 1) = i2
					T(0) = T(0) + 1
				END IF
			NEXT
		NEXT
		FOR ii = 0 TO T(0)
			IF People(aiStat(i, 0), aiThink(T(0), 0), aiThink(T(0), 1)) > 1 THEN
			RANDOMIZE TIMER
			SELECT CASE INT(RND)
			CASE 1
				RANDOMIZE TIMER
				aiStat(i, 1) = INT(RND * 2) + aiThink(T, 0) - 1
			CASE ELSE
				RANDOMIZE TIMER
				aiStat(i, 2) = INT(RND * 2) + aiThink(T, 1) - 1
			END SELECT
			RANDOMIZE TIMER
			END IF
		NEXT
		IF INT(RND * 4) = 2 THEN GOSUB 13200
	NEXT
RETURN
14000 '-----------------------------Guild Jobs----------------------------
	SELECT CASE pStat(p, 7)
	CASE 0
		CLS
		PRINT " You spend 5 days doing odd jobs around the guild"
		pObjects(p, 0) = pObjects(p, 0) + 75
		time = time + (lps * 5)
	CASE 1
		CLS
		PRINT " The Weapons Guild welcomes you. Do you wish to"
		PRINT " (1.) Create a blueprint, or (2.) Manufacture a design?"
		DO
			k$ = LCASE$(INKEY$)
			time = time + 1
			LOCATE 18, 1
			PRINT " Day: "; Days
			IF InMonth THEN RETURN
		LOOP WHILE k$ = ""
		'IF k$ = "2" THEN
		'FOR i = 0 TO 10
		'FOR ii = 0 TO 10
		'IF lGrid(pStat(p, 0), i, ii, 0) = 15 THEN
			'PRINT " Which bluprint do you wish to manufacture"
			'INPUT " ", t(1)
			'if bPrint(p, t(1),0) =
			'RANDOMIZE TIMER
			't(0) = int(rn
	END SELECT
	DO
		k$ = LCASE$(INKEY$)
		time = time + 1
		LOCATE 18, 1
		PRINT " Hit Enter to continue. Day: "; Days
	LOOP WHILE InMonth AND k$ = ""
RETURN
15000 '-------------------------Health and HP Increase------------------------
	PRINT " You can increase your health by eating more. Your current health"
	PRINT " is "; pStat(p, 4); ". Right now you have "
	PRINT pObjects(p, 46); " "

FUNCTION Days
	Days = INT(time / (lps * 2))
END FUNCTION

SUB EnterMe (p)
END SUB

FUNCTION Fluctuate& (amt AS LONG, mul AS SINGLE)
	RANDOMIZE TIMER
	DIM ant AS DOUBLE
	ant = amt
	tms! = RND * 2 - 1
	tms! = (tms! * mul) + 1
	ant = ant * tms!
	RANDOMIZE TIMER
	IF INT(ant) = 0 THEN ant = INT(RND * 3) + 1
	Fluctuate& = INT(ant)
END FUNCTION

FUNCTION InMonth
	IF time <= (60) * lps THEN
		InMonth = 1
	ELSE
		InMonth = 0
	END IF
END FUNCTION

FUNCTION People (a AS INTEGER, b AS INTEGER, c AS INTEGER)
	abcd = 0
	FOR abc = 1 TO 15
		IF aiStat(abc, 0) = a AND aiStat(abc, 1) = b AND aiStat(abc, 2) = c THEN
			abcd = abcd + 1
		END IF
	NEXT
	FOR abc = 1 TO pNum
		IF pStat(abc, 0) = a AND pStat(abc, 1) = b AND pStat(abc, 2) = c THEN
			abcd = abcd + 1
		END IF
	NEXT
	People = abcd
END FUNCTION

