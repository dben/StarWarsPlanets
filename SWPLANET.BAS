'                  David Presents:
'                     S T A R   W A R S : P L A N E T S
'                                        by David Benson
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'

CLS
PRINT "Star Wars Planets is loading..."
RANDOMIZE TIMER
DIM o(0 TO 50) AS STRING
DIM op(100, 2)
DIM p(0 TO 3)  AS STRING
DIM pb(10, 0 TO 20, 0 TO 20, 5) AS INTEGER
DIM c(40, 15)
DIM cob(10, 51) AS INTEGER
DIM time(5)
DIM cn(40) AS STRING
'--------------------------------------objects--------------------------------
o(0) = "nothing"
o(1) = "blissl tuner(s)"
o(2) = "podrace macrobinoculars(s)"
o(4) = "birdcage(s)"
o(5) = "pylat(s)"
o(7) = "faa(s)"
o(8) = "chuba(s)"
o(9) = "kaadu(s)"
o(10) = "fambaa(s)"
o(11) = "dewback(s)"
o(12) = "3P0 droid(s)"
o(13) = "R2 droid(s)"
o(14) = "datafile(s)"
o(15) = "pit droid(s)"
o(16) = "mechano-chair(s)"
o(18) = "2-1B droid(s)"
o(19) = "droid starfighter(s)"
o(20) = "battle droid(s)"
o(21) = "destroyer droid(s)"
o(22) = "probe droid(s)"
o(23) = "assasin droid(s)"
o(24) = "mantanince droid(s)"
o(26) = "credits"
o(27) = "truguts"
o(28) = "tyderium shuttle(s)"
o(29) = "landspeeder(s)"
o(30) = "corvette(s)"
o(31) = "x-wing(s)"
o(32) = "y-wing(s)"
o(33) = "nubian spacecraft(s)"
o(34) = "air taxi(s)"
o(35) = "podracer(s)"
o(37) = "swoop(s)"
o(38) = "lightsaber(s)"
o(39) = "double bladed lightsaber(s)"
o(40) = "S-5 blaster(s)"
o(41) = "blas-tech rifle(s)"
o(42) = "blas-tech pistol(s)"
o(43) = "thermal detinator(s)"
o(44) = "projectile rifle(s)"
o(3) = "garden tool(s)"
o(6) = "guard(s)"
o(47) = "servant(s)"
o(48) = "padawan"
o(49) = "food capsule(s)"
o(50) = "liters of juri juce"
o(17) = "liters of water"
o(36) = "bushels of food"
o(46) = "liters of bacta"
o(45) = "plastoid armor plate(s)"
o(25) = "skyhopper(s)"

'---------------------------------people--------------------------------------
c(1, 3) = 1: cob(1, 26) = 1000
c(2, 3) = 2: cob(2, 26) = 1000
c(3, 3) = 3: cob(3, 26) = 1000
c(4, 3) = INT(RND * 2) + 1: cob(4, 26) = 1000
FOR r = 1 TO 10
	c(r, 1) = 1
	c(r, 2) = 1
NEXT
cn(5) = "Watto":     c(5, 3) = 3
cn(6) = "Royal Guard": c(6, 3) = 1
cn(7) = "Jango Fett": c(7, 3) = 2
cn(8) = "Sebulba":    c(8, 3) = 3
cn(9) = "Viceroy":    c(9, 3) = 1
cn(10) = "Obi-Wan":   c(10, 3) = 3
cn(11) = "Jedi Temple"
cn(12) = "Naboo Royalty"
cn(13) = "Jabba"
cn(14) = "Oota Gunga"
cn(15) = "Graga"
cn(16) = "settler"
cn(17) = "Trade Fed."
cn(18) = "Naboo Cafe"
cn(19) = "Galactic Senate"
cn(20) = "someone"
'-----------------------------planets-----------------------------------------
p(0) = "No Where"
p(1) = "Naboo"
p(2) = "Coruscaunt"
p(3) = "Tatooine"

'------------------------------set locations----------------------------------

pb(1, 1, 1, 1) = 0
pb(1, 1, 1, 1) = 0
pb(1, 1, 1, 1) = 0
pb(1, 1, 1, 1) = 0

pb(1, 1, 1, 1) = 0
pb(1, 1, 1, 1) = 0
pb(1, 1, 1, 1) = 0
pb(1, 1, 1, 1) = 0

pb(1, 1, 1, 1) = 0
pb(1, 1, 1, 1) = 0
pb(1, 1, 1, 1) = 0
pb(1, 1, 1, 1) = 0

'------------------------------finish load------------------------------------
PRINT "Loading Complete!"
FOR i = 1 TO 1000: NEXT i
CLS
PRINT "Star Wars Planets": PRINT
INPUT "How many players(1 to 4)"; r
IF r < 1 THEN cn(1) = "Padme Naberrie"
IF r < 2 THEN cn(2) = "Darth Sidious"
IF r < 3 THEN cn(3) = "Gungan"
IF r < 4 THEN cn(4) = "Anakin Skywalker"
IF r > 0 THEN
	INPUT "Player 1", r2
	INPUT "What is your name"; cn(1)
	PRINT "You have 1000 character points"
	PRINT "There are 4 things to spend them on: HP, Training, Health,"
	PRINT "and Random Objects"
	DO
		r4 = 0
		r3 = 1000
		INPUT "How many HP"; c(1, 4)
		INPUT "How much Training"; c(1, 5)
		INPUT "How much Health"; c(1, 6)
		INPUT "How many Random Objects(200 CP each)"; r4
		IF (r4 * 200) + c(1, 6) + c(1, 5) + c(1, 4) <= 1000 THEN EXIT DO
	LOOP
	IF r4 > 0 THEN
		FOR i = 1 TO r4
			RANDOMIZE TIMER
        r3 = INT(RND * 50) + 1
        cob(1, r3) = cob(1, r3) + 1
		NEXT i
	END IF
END IF
IF r > 1 THEN
	INPUT "Player 2", r2
	INPUT "What is your name"; cn(2)
	PRINT "You have 1000 character points"
	PRINT "There are 4 things to spend them on: HP, Training, Health,"
	PRINT "and Random Objects"
	DO
		r4 = 0
		r3 = 1000
		INPUT "How many HP"; c(2, 4)
		INPUT "How much Training"; c(2, 5)
		INPUT "How much Health"; c(2, 6)
		INPUT "How many Random Objects(200 CP each)"; r4
		IF (r4 * 200) + c(2, 6) + c(2, 5) + c(2, 4) <= 1000 THEN EXIT DO
	LOOP
	IF r4 > 0 THEN
		FOR i = 1 TO r4
			RANDOMIZE TIMER
            r3 = INT(RND * 50) + 1
            cob(2, r3) = cob(2, r3) + 1
		NEXT i
	END IF
END IF

'cob(1, 1, 1) = 28
'cob(1, 1, 2) = 1
CLS
GOTO game

play1:
	nearby$ = ""
	FOR r = 2 TO 10
        IF p(c(r, 3)) = p(c(1, 3)) THEN nearby$ = nearby$ + LEFT$(cn(r), 5) + ". "
	NEXT r
	LOCATE 1, 1
	PRINT cn(1)
	PRINT
	PRINT "You are at "; c(1, 1); ","; c(1, 2); " on "; p(c(1, 3)); "."
    PRINT "You are near "; LEFT$(nearby$, 35)
	LOCATE 5, 1
    PRINT "You have "; cob(1, 26); " credits."
	PRINT p1d$
	PRINT "1. North         6. Inventory"
	PRINT "2. South         7. Give"
	PRINT "3. East          8. Fight             "
	PRINT "4. West          9. Use spaceship     "
	PRINT "5. Farm          0. Build             "
RETURN

play2:
	nearby$ = ""
	FOR r = 1 TO 10
		IF r = 2 THEN r = 3
        IF p(c(r, 3)) = p(c(2, 3)) THEN nearby$ = nearby$ + LEFT$(cn(r), 5) + ". "
	NEXT
	LOCATE 1, 40
	PRINT cn(2)
	LOCATE 3, 40
	PRINT "You are at "; c(2, 1); ","; c(2, 2); " on "; p(c(2, 3)); "."
	LOCATE 4, 36
    PRINT "... You are near "; LEFT$(nearby$, 35)
	LOCATE 5, 40
    PRINT "You have "; cob(2, 26); " credits."
	LOCATE 6, 40
	PRINT p2d$
	LOCATE 7, 40
	PRINT "Q. North         X. Inventory"
	LOCATE 8, 40
	PRINT "A. South         E. Give"
	LOCATE 9, 40
	PRINT "Z. East          D. Fight"
	LOCATE 10, 40
	PRINT "W. West          C. Use spaceship"
	LOCATE 11, 40
	PRINT "S. Farm          R. Build"
RETURN

play3:
	nearby$ = ""
	FOR r = 1 TO 10
		IF r = 3 THEN r = 4
        IF p(c(r, 3)) = p(c(3, 3)) THEN nearby$ = nearby$ + LEFT$(cn(r), 5) + ". "
	NEXT
	LOCATE 13, 1
	PRINT cn(3)
	PRINT
	PRINT "You are at "; c(3, 1); ","; c(3, 2); " on "; p(c(3, 3)); "."
    PRINT "You are near "; LEFT$(nearby$, 35)
	LOCATE 17, 1
    PRINT "You have "; cob(3, 26); " credits."
	PRINT p3d$
	PRINT "N. North         K. Inventory"
	PRINT "U. South         O. Give"
	PRINT "J. East          L. Fight             "
	PRINT "M. West          P. Use spaceship     "
	PRINT "I. Farm          -. Build             "
RETURN

play4:
	nearby$ = ""
	FOR r = 1 TO 10
		IF r = 4 THEN r = 5
        IF p(c(r, 3)) = p(c(4, 3)) THEN nearby$ = nearby$ + LEFT$(cn(r), 5) + ". "
	NEXT
	LOCATE 13, 40
	PRINT cn(4)
	LOCATE 15, 40
	PRINT "You are at "; c(4, 1); ","; c(4, 2); " on "; p(c(4, 3)); "."
	LOCATE 16, 36
    PRINT "... You are near "; LEFT$(nearby$, 35)
	LOCATE 17, 40
    PRINT "You have "; cob(4, 26); " credits."
	LOCATE 18, 40
	PRINT p4d$
	LOCATE 19, 40
	PRINT ". North         /. Inventory"
	LOCATE 20, 40
	PRINT ". South         '. Give"
	LOCATE 21, 40
	PRINT ". East          [. Fight"
	LOCATE 22, 40
	PRINT ". West          ]. Use spaceship"
	LOCATE 23, 40
	PRINT ". Farm          \. Build"
RETURN


game: '------------------------------game eng.--------------------------------
	CLS
	GOSUB play1
	GOSUB play2
    'GOSUB play3
    'GOSUB play4
	DO
		k$ = INKEY$
		time(5) = time(5) + 1
		IF time(5) = 240 THEN time(1) = time(1) + 1: time(2) = time(2) + 1: time(3) = time(3) + 1: time(4) = time(4) + 1: time(5) = 0
        IF time(1) = 365 THEN p1d$ = "Year up.": time(1) = 366: r = 1: GOSUB consume: GOTO game
        IF time(2) = 365 THEN p2d$ = "Year up.": time(2) = 366: r = 2: GOSUB consume: GOTO game
        IF time(3) = 365 THEN p3d$ = "Year up.": time(3) = 366: r = 3: GOSUB consume: GOTO game
        IF time(4) = 365 THEN p4d$ = "Year up.": time(4) = 366: r = 4: GOSUB consume: GOTO game
	LOOP WHILE k$ = ""

	IF k$ = CHR$(27) THEN
			CLS
			PRINT "1. Quit"
			PRINT "2. Continue"
			INPUT "", r
			IF r = 1 THEN END ELSE GOTO game
	END IF
play6: '-----------------------------player 1---------------------------------
	IF k$ = "1" AND c(1, 1) < 20 THEN
			c(1, 1) = c(1, 1) + 1
			r = 1
			GOSUB loca
	END IF
	IF k$ = "2" AND c(1, 1) > 1 THEN
			c(1, 1) = c(1, 1) - 1
			r = 1
			GOSUB loca
	END IF
	IF k$ = "3" AND c(1, 2) < 20 THEN
			c(1, 2) = c(1, 2) + 1
			r = 1
			GOSUB loca
	END IF
	IF k$ = "4" THEN
			IF c(1, 2) > 1 THEN c(1, 2) = c(1, 2) - 1
			r = 1
			GOSUB loca
	END IF
	IF k$ = "5" THEN
        IF cob(1, 26) > 150 AND pb(c(1, 3), c(1, 1), c(1, 2), 1) = 0 THEN
            cob(1, 26) = cob(1, 26) - 150
			pb(c(1, 3), c(1, 1), c(1, 2), 1) = 1
			LOCATE 2, 40: PRINT "Please Wait..."
			LOCATE 14, 1: PRINT "Please Wait..."
			LOCATE 14, 40: PRINT "Please Wait..."
			LOCATE 2, 1: INPUT "What kind (1. moisture 2. food)"; r
			pb(c(1, 3), c(1, 1), c(1, 2), 2) = r
			p1d$ = "You made a farm."
		ELSE 
			IF pb(c(1, 3), c(1, 1), c(1, 2), 1) = 1 THEN
                r$ = ""
				r = 0
				r2 = 1
				r3 = 1
				r4 = 1
                IF cob(1, 47) > 0 THEN LOCATE 2, 1: INPUT "Do you want to assign a worker here(y/n)"; r$
                IF r$ = "y" THEN pb(c(1, 3), c(1, 1), c(1, 2), 3) = pb(c(1, 3), c(1, 1), c(1, 2), 3) + 1: cob(1, 47) = cob(1, 47) - 1
				RANDOMIZE TIMER
				IF time(1) > 360 THEN
					time(1) = time(1) - 365
					RANDOMIZE TIMER
                    IF pb(c(1, 3), c(1, 1), c(1, 2), 2) = 2 THEN r3 = INT(RND * 50) + 52: cob(1, 36) = cob(1, 36) + r3: p1d$ = "Grain harvested."
                    IF pb(c(1, 3), c(1, 1), c(1, 2), 2) = 1 THEN r3 = INT(RND * 50) + 50: cob(1, 17) = cob(1, 17) + r3: p1d$ = "Juice harvested."
				END IF
			ELSE
                p1d$ = "Can't build farm here."
  			END IF
		END IF
	END IF
	IF k$ = "6" THEN
		LOCATE 2, 40: PRINT "Please Wait..."
		LOCATE 14, 1: PRINT "Please Wait..."
		LOCATE 14, 40: PRINT "Please Wait..."
        GOSUB list1
	END IF

	IF k$ = "7" THEN
		LOCATE 2, 40: PRINT "Please Wait..."
		LOCATE 14, 1: PRINT "Please Wait..."
		LOCATE 14, 40: PRINT "Please Wait..."
        GOSUB list1
		GOSUB clear1
		INPUT "Number of gift"; r3
		INPUT "How many"; r
		LOCATE 1, 1
		FOR r2 = 1 TO 10
			PRINT r2; ". "; cn(r2)
		NEXT
		INPUT "To who"; r2
        IF cob(1, r3) >= r THEN
            cob(r2, r3) = cob(r2, r3) + r
            cob(1, r3) = cob(1, r3) - r
        END IF
    END IF

    IF k$ = "8" THEN
        IF NOT pb(c(1, 3), c(1, 1), c(1, 2), 2) = 4 THEN
        LOCATE 2, 40: PRINT "Please Wait..."
        LOCATE 14, 1: PRINT "Please Wait..."
        LOCATE 14, 40: PRINT "Please Wait..."
        GOSUB clear1
        PRINT "1. Launch Droids"
        PRINT "2. Radar"
        PRINT "3. Battle"
        PRINT
        INPUT "Choose:", r
        IF r = 2 THEN
            LOCATE 1, 1
            FOR r2 = 1 TO 10
            PRINT r2; ". "; cn(r2)
            NEXT
            INPUT "Find Who"; r2
            GOSUB clear1
            PRINT "Name: "; cn(r2)
            PRINT "HP: "; c(r2, 4)
            PRINT "Training: "; c(r2, 5) / 10; "% mastery"
            PRINT "Health: "; c(r2, 6); "% Health"
            PRINT "Location: "; c(r2, 1); ","; c(r2, 2); " on "; p(c(r2, 3))
            INPUT "", r3
        END IF
        IF r = 1 THEN
        END IF
        IF r = 3 THEN
        END IF
		ELSE
            p1d$ = "Can't fight at hotel"
		END IF
	END IF

	IF k$ = "9" THEN '28 ,30, 31, 32, 33
		r = 0
		r = r + 1
        IF cob(1, 28) >= 1 OR cob(1, 30) >= 1 OR cob(1, 31) >= 1 OR cob(1, 32) >= 1 OR cob(1, 33) >= 1 THEN
			c(1, 3) = c(1, 3) + 1: IF c(1, 3) = 4 THEN c(1, 3) = 1
			p1d$ = "You fly to " + p(c(1, 3))
			c(1, 1) = 1
			c(1, 2) = 1
		ELSE
			p1d$ = "You do not have a spaceship."
		END IF
	END IF

	IF k$ = "0" THEN
        IF cob(1, 26) > 250 AND pb(c(1, 3), c(1, 1), c(1, 2), 1) = 0 THEN
            cob(1, 26) = cob(1, 26) - 250
			pb(c(1, 3), c(1, 1), c(1, 2), 1) = 1
			LOCATE 2, 40: PRINT "Please Wait..."
			LOCATE 14, 1: PRINT "Please Wait..."
			LOCATE 14, 40: PRINT "Please Wait..."
			GOSUB clear1
			PRINT "Buildings:"
			PRINT "1. Shop"
			PRINT "2. Hotel"
			PRINT "3. House"
			PRINT "4. Room"
			PRINT "5. Resturant"
			INPUT "Choose a number ", r
			pb(c(1, 3), c(1, 1), c(1, 2), 2) = r + 2
			IF r = 1 THEN
                GOSUB list1
                INPUT "Item sold"; r3
                pb(c(1, 3), c(1, 1), c(1, 2), 1) = 1
                pb(c(1, 3), c(1, 1), c(1, 2), 4) = cob(1, r3)
                INPUT "Price"; r3
                pb(c(1, 3), c(1, 1), c(1, 2), 5) = r3
            END IF
            IF r = 2 THEN
                INPUT "How many rooms($25 a room)"; r2
                pb(c(1, 3), c(1, 1), c(1, 2), 4) = r3
                cob(1, 26) = cob(1, 26) - ((r2 * 25) + 100)
                INPUT "Price"; r2
                pb(c(1, 3), c(1, 1), c(1, 2), 5) = r2
            END IF
            IF r = 5 THEN
                r3 = 0
                DO
                    r3 = r3 + 1
                    IF cob(1, r3) > 1 AND (r3 = 49 OR r3 = 50 OR r3 = 17 OR r3 = 36) THEN LOCATE 1, 1: PRINT o(r3): INPUT "Do you want to sell this(y/n)"; r$: IF r$ = "y" THEN EXIT DO
                LOOP WHILE r3 < 51
                IF r3 < 25 THEN
                    pb(c(1, 3), c(1, 1), c(1, 2), 4) = r3
                    INPUT "Price"; r2
                    pb(c(1, 3), c(1, 1), c(1, 2), 5) = r2
                ELSE
                    cob(1, 26) = cob(1, 26) + 250
                    pb(c(1, 3), c(1, 1), c(1, 2), 2) = 0
                    pb(c(1, 3), c(1, 1), c(1, 2), 1) = 0
                END IF
            END IF
            p1d$ = "You made a building."

		END IF

	END IF
'-------------------------player 2--------------------------------------------
	IF k$ = "q" AND c(2, 1) < 20 THEN
		c(2, 1) = c(2, 1) + 1
		r = 2
		GOSUB loca
	END IF
	IF k$ = "a" AND c(2, 1) > 1 THEN
		c(2, 1) = c(2, 1) - 1
		r = 2
		GOSUB loca
	END IF
	IF k$ = "z" AND c(2, 2) < 20 THEN
		c(2, 2) = c(2, 2) + 1
		r = 2
		GOSUB loca
	END IF
    IF k$ = "w" THEN
        IF c(2, 2) > 1 THEN c(2, 2) = c(2, 2) - 1
		r = 2
		GOSUB loca
	END IF
	IF k$ = "s" THEN
        IF cob(2, 26) > 150 AND pb(c(2, 3), c(2, 1), c(2, 2), 1) = 0 THEN
            cob(2, 26) = cob(2, 26) - 150
			pb(c(2, 3), c(2, 1), c(2, 2), 1) = 2
			LOCATE 2, 1: PRINT "Please Wait..."
			LOCATE 14, 1: PRINT "Please Wait..."
			LOCATE 14, 40: PRINT "Please Wait..."
			LOCATE 2, 40: INPUT "What kind (1. moisture 2. food)"; r
			pb(c(2, 3), c(2, 1), c(2, 2), 2) = r
			p2d$ = "You made a farm."

		ELSE
			IF pb(c(2, 3), c(2, 1), c(2, 2), 1) = 2 THEN
                r$ = ""
				r = 0
				r2 = 1
				r3 = 1
				r4 = 1
                IF cob(2, 47) > 0 THEN LOCATE 2, 40: INPUT "Do you want to assign a worker here(y/n)"; r$
                IF r$ = "y" THEN pb(c(2, 3), c(2, 1), c(2, 2), 3) = pb(c(2, 3), c(2, 1), c(2, 2), 3) + 1: cob(2, 47) = cob(2, 47) - 1
				RANDOMIZE TIMER
				IF time(2) > 360 THEN
					time(2) = time(2) - 365
                    RANDOMIZE TIMER
                    IF pb(c(2, 3), c(2, 1), c(2, 2), 2) = 2 THEN r3 = INT(RND * 50) + 52: cob(2, 36) = cob(2, 36) + r3: p2d$ = "Grain harvested."
                    IF pb(c(2, 3), c(2, 1), c(2, 2), 2) = 1 THEN r3 = INT(RND * 50) + 50: cob(2, 17) = cob(2, 17) + r3: p2d$ = "Juice harvested."
                END IF
            ELSE
                p2d$ = "Can't build farm here."
            END IF
        END IF
    END IF
	IF k$ = "x" THEN
		LOCATE 2, 1: PRINT "Please Wait..."
		LOCATE 14, 1: PRINT "Please Wait..."
		LOCATE 14, 40: PRINT "Please Wait..."
        GOSUB list2
	END IF

	IF k$ = "e" THEN
		LOCATE 2, 1: PRINT "Please Wait..."
		LOCATE 14, 1: PRINT "Please Wait..."
		LOCATE 14, 40: PRINT "Please Wait..."
        GOSUB list2
		GOSUB clear2
		INPUT "Number of gift"; r3
		INPUT "How many"; r
		FOR r2 = 1 TO 10
			LOCATE r2, 40
			PRINT r2; ". "; cn(r2)
		NEXT
		LOCATE 11, 40
		INPUT "To who"; r2
        IF cob(2, r3) >= r THEN
            cob(r2, r3) = cob(r2, r3) + r
            cob(2, r3) = cob(2, r3) - r
		END IF
	END IF

	IF k$ = "d" THEN c(2, 1) = c(2, 1) + 1

	IF k$ = "c" THEN '28 ,30, 31, 32, 33
		r = 0
        r = r + 1
        IF cob(2, 28) >= 1 OR cob(2, 30) >= 1 OR cob(2, 31) >= 1 OR cob(2, 32) >= 1 OR cob(2, 33) >= 1 THEN
			c(2, 3) = c(2, 3) + 1: IF c(2, 3) = 4 THEN c(2, 3) = 1
			p2d$ = "You fly to " + p(c(2, 3))
			c(2, 1) = 1
			c(2, 2) = 1
		ELSE
			p2d$ = "You do not have a spaceship."
		END IF
	END IF

	IF k$ = "r" THEN
        IF cob(2, 26) > 250 AND pb(c(2, 3), c(2, 1), c(2, 2), 1) = 0 THEN
            cob(2, 26) = cob(2, 26) - 250
			pb(c(2, 3), c(2, 1), c(2, 2), 1) = 2
			LOCATE 2, 1: PRINT "Please Wait..."
			LOCATE 14, 1: PRINT "Please Wait..."
			LOCATE 14, 40: PRINT "Please Wait..."
			GOSUB clear2
            LOCATE 1, 40
			PRINT "Buildings:"
			LOCATE 2, 40
			PRINT "1. Shop"
			LOCATE 3, 40
			PRINT "2. Hotel"
			LOCATE 4, 40
			PRINT "3. House"
			LOCATE 5, 40
			PRINT "4. Room"
			LOCATE 6, 40
			PRINT "5. Resturant"
			LOCATE 7, 40
			INPUT "Choose a number ", r
			pb(c(2, 3), c(2, 1), c(2, 2), 2) = r + 2
			IF r = 1 THEN
                GOSUB list2
                LOCATE 1, 40
				INPUT "Item sold"; r3
				pb(c(2, 3), c(2, 1), c(2, 2), 1) = 2
                pb(c(2, 3), c(2, 1), c(2, 2), 4) = cob(2, r3)
				LOCATE 2, 40
				INPUT "Price"; r3
				pb(c(2, 3), c(2, 1), c(2, 2), 5) = r3
			END IF
			IF r = 2 THEN
                LOCATE 1, 40
				INPUT "How many rooms($25 a room)"; r2
				pb(c(2, 3), c(2, 1), c(2, 2), 4) = r3
                cob(2, 26) = cob(2, 26) - ((r2 * 25) + 100)
				LOCATE 2, 40
				INPUT "Price"; r2
				pb(c(2, 3), c(2, 1), c(2, 2), 5) = r2
			END IF
			IF r = 5 THEN
				r3 = 0
				DO
					r3 = r3 + 1
                    IF cob(2, r3) > 1 AND (r3 = 49 OR r3 = 50 OR r3 = 17 OR r3 = 36) THEN LOCATE 1, 40: PRINT o(r3): LOCATE 2, 40: INPUT "Do you want to sell this(y/n)"; r$: IF r$ = "y" THEN EXIT DO
                LOOP WHILE r3 < 51
                IF r3 < 51 THEN
                    pb(c(2, 3), c(2, 1), c(2, 2), 4) = r3
                    INPUT "Price"; r2
                    pb(c(2, 3), c(2, 1), c(2, 2), 5) = r2
                ELSE
                    cob(1, 26) = cob(1, 26) + 250
                    pb(c(2, 3), c(2, 1), c(2, 2), 2) = 0
                    pb(c(2, 3), c(2, 1), c(2, 2), 1) = 0
                END IF
			END IF
			p2d$ = "You made a building."
		END IF
	END IF
GOTO game

clear2:
	FOR i = 1 TO 12
		LOCATE i, 40
		PRINT "                                       "
	NEXT
	LOCATE 1, 40
RETURN


clear1:
	LOCATE 1, 1
	PRINT "                                       "
	PRINT "                                       "
	PRINT "                                       "
	PRINT "                                       "
	PRINT "                                       "
	PRINT "                                       "
	PRINT "                                       "
	PRINT "                                       "
	PRINT "                                       "
	PRINT "                                       "
	PRINT "                                       "
	PRINT "                                       "
	LOCATE 1, 1
RETURN

loca:
	IF r = 1 THEN p1d$ = ""
	IF r = 2 THEN p2d$ = ""
	IF r = 3 THEN p3d$ = ""
	IF r = 4 THEN p4d$ = ""
    pd$ = ""
	IF pb(c(r, 3), c(r, 1), c(r, 2), 2) = 1 THEN pd$ = "You are at " + cn(pb(c(r, 3), c(r, 1), c(r, 2), 1)) + "'s moisture farm"
	IF pb(c(r, 3), c(r, 1), c(r, 2), 2) = 2 THEN pd$ = "You are at " + cn(pb(c(r, 3), c(r, 1), c(r, 2), 1)) + "'s food farm"
	IF pb(c(r, 3), c(r, 1), c(r, 2), 2) = 3 THEN
        IF pb(c(r, 3), c(r, 1), c(r, 2), 1) < 11 THEN ok = 1 ELSE ok = 0
		pd$ = "You are at " + cn(pb(c(r, 3), c(r, 1), c(r, 2), 1)) + "'s shop"
		IF r = 1 THEN LOCATE 3, 1
		IF r = 2 THEN LOCATE 3, 40
		IF r = 3 THEN LOCATE 15, 1
		IF r = 4 THEN LOCATE 15, 40
        IF pb(c(r, 3), c(r, 1), c(r, 2), 1) <> r THEN
            PRINT o(pb(c(r, 3), c(r, 1), c(r, 2), 4)); " is sold here."
            IF r = 1 THEN LOCATE 4, 1
            IF r = 2 THEN LOCATE 4, 40
            IF r = 3 THEN LOCATE 16, 1
            IF r = 4 THEN LOCATE 16, 40
            INPUT "Do you want to buy one(y/n)"; r$
            IF r$ = "y" AND cob(r, 26) >= (pb(c(r, 3), c(r, 1), c(r, 2), 5)) AND cob(pb(c(r, 3), c(r, 1), c(r, 2), 1), pb(c(r, 3), c(r, 1), c(r, 2), 4)) > 0 THEN
            cob(r, 26) = cob(r, 26) - (pb(c(r, 3), c(r, 1), c(r, 2), 5))
            IF ok = 1 THEN cob(pb(c(r, 3), c(r, 1), c(r, 2), 1), 26) = cob(pb(c(r, 3), c(r, 1), c(r, 2), 1), 26) + pb(c(r, 3), c(r, 1), c(r, 2), 5)
            cob(pb(c(r, 3), c(r, 1), c(r, 2), 1), pb(c(r, 3), c(r, 1), c(r, 2), 4)) = cob(pb(c(r, 3), c(r, 1), c(r, 2), 1), pb(c(r, 3), c(r, 1), c(r, 2), 4)) - 1
            IF ok = 1 THEN cob(r, pb(c(r, 3), c(r, 1), c(r, 2), 4)) = cob(r, pb(c(r, 3), c(r, 1), c(r, 2), 4)) + 1
		ELSE
            pd$ = "Can't buy"
        END IF
    END IF
END IF
1000
	IF pb(c(r, 3), c(r, 1), c(r, 2), 2) = 4 THEN
		pd$ = "You are at " + cn(pb(c(r, 3), c(r, 1), c(r, 2), 1)) + "'s hotel"
        cob(r, 26) = cob(r, 26) - (pb(c(r, 3), c(r, 1), c(r, 2), 5) + 2 * pb(c(r, 3), c(r, 1), c(r, 2), 4))
        IF ok = 1 THEN cob(pb(c(r, 3), c(r, 1), c(r, 2), 1), 26) = cob(pb(c(r, 3), c(r, 1), c(r, 2), 1), 26) + pb(c(r, 3), c(r, 1), c(r, 2), 5) + 2 * pb(c(r, 3), c(r, 1), c(r, 2), 4)
	END IF
	IF pb(c(r, 3), c(r, 1), c(r, 2), 2) = 5 THEN pd$ = "You are at " + cn(pb(c(r, 3), c(r, 1), c(r, 2), 1)) + "'s home"
	IF pb(c(r, 3), c(r, 1), c(r, 2), 2) = 6 THEN pd$ = "You are at " + cn(pb(c(r, 3), c(r, 1), c(r, 2), 1)) + "'s conf. room"
	IF pb(c(r, 3), c(r, 1), c(r, 2), 2) = 7 THEN pd$ = "You are at " + cn(pb(c(r, 3), c(r, 1), c(r, 2), 1)) + "'s resturaunt"
	IF r = 1 THEN p1d$ = pd$
	IF r = 2 THEN p2d$ = pd$
	IF r = 3 THEN p3d$ = pd$
	IF r = 4 THEN p4d$ = pd$
RETURN

list1:
    LOCATE 1, 1
    GOSUB clear1
    LOCATE 1, 1
    FOR r = 1 TO 12
        PRINT r; ". "; cob(1, r); " "; o(r)
    NEXT r
    INPUT r
    GOSUB clear1
    FOR r = 13 TO 24
        PRINT r; ". "; cob(1, r); " "; o(r)
    NEXT r
    INPUT r
    LOCATE 1, 1
    GOSUB clear1
    LOCATE 1, 1
    FOR r = 25 TO 37
        PRINT r; ". "; cob(1, r); " "; o(r)
    NEXT r
    INPUT r
    GOSUB clear1
    FOR r = 38 TO 50
        PRINT r; ". "; cob(1, r); " "; o(r)
    NEXT r
    INPUT r
RETURN

list2:
    LOCATE 1, 40
    GOSUB clear2
    LOCATE 1, 40
    FOR r = 1 TO 12
        LOCATE r, 40
        PRINT r; ". "; cob(1, r); " "; o(r)
    NEXT r
    LOCATE 13, 40
    INPUT r
    GOSUB clear2
    FOR r = 13 TO 24
        LOCATE r - 12, 40
        PRINT r; ". "; cob(1, r); " "; o(r)
    NEXT r
    LOCATE 13, 40
    INPUT r
    LOCATE 1, 40
    GOSUB clear2
    LOCATE 1, 40
    FOR r = 25 TO 37
        LOCATE r - 24, 40
        PRINT r; ". "; cob(1, r); " "; o(r)
    NEXT r
    LOCATE 13, 40
    INPUT r
    GOSUB clear2
    FOR r = 38 TO 50
        LOCATE r - 37, 40
        PRINT r; ". "; cob(1, r); " "; o(r)
    NEXT r
    LOCATE 13, 40
    INPUT r
RETURN


consume:
    IF cob(r, 49) <= 25 AND cob(r, 50) <= 25 AND cob(r, 17) <= 25 AND cob(r, 36) <= 25 THEN
        c(r, 6) = c(r, 6) - 70
        IF c(r, 6) <= 0 THEN
            c(r, 1) = 1
            c(r, 2) = 1
            c(r, 3) = 1
            c(r, 4) = 100
            c(r, 5) = 0
            c(r, 6) = 100
            FOR i = 1 TO 50
                cob(r, i) = 0
            NEXT
            cob(r, 26) = 300
            IF r = 1 THEN p1d$ = "You die of starvation."
            IF r = 2 THEN p2d$ = "You die of starvation."
            IF r = 3 THEN p3d$ = "You die of starvation."
            IF r = 4 THEN p4d$ = "You die of starvation."
        END IF
        IF cob(r, 49) > 24 THEN
            cob(r, 49) = cob(r, 49) - 25
        ELSE
            IF cob(r, 36) > 24 THEN
                cob(r, 36) = cob(r, 36) - 25
            ELSE
                IF cob(r, 50) > 24 THEN
                    cob(r, 50) = cob(r, 50) - 25
                ELSE
                    IF cob(r, 17) > 24 THEN
                        cob(r, 17) = cob(r, 17) - 25
                    END IF
                END IF
            END IF
        END IF
    END IF
RETURN

