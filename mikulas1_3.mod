set gyerekek;
set jatekok;
param jatekar{jatekok};
param kivansag{gyerekek, jatekok};
set utcabeliek in gyerekek cross gyerekek;

var megkapja{gyerekek,jatekok} binary;

s.t. mindenki1ajandekot {g in gyerekek}:
	sum{j in jatekok} megkapja[g,j] = 1;


s.t. max3anKaphatnakUgyanazt {j in jatekok}:
	sum {g in gyerekek} megkapja[g,j] <=3;

s.t. kivansagfigelo {g in gyerekek, j in jatekok : kivansag[g,j] <> 1}:
	megkapja[g,j] = 0;

s.t. utcabelisegetfigyelo {(g1,g2) in utcabeliek, j in jatekok}:
	 megkapja[g1,j] + megkapja[g2,j] <=1;


minimize koltseg :
	sum {g in gyerekek, j in jatekok} (megkapja[g,j] * jatekar[j]);

solve;

printf "\n\n";
printf "\n\n";

printf "Költség: %d\n",koltseg;

for {g in gyerekek}
{
	printf "%s: \n",g;
	for {j in jatekok : megkapja[g,j] <> 0}
		printf "  -%s (%g)\n\n",j,jatekar[j];
		
}

printf "\n\n";
printf "Egy utcában laknak: \n";
for {(g1,g2) in utcabeliek}:
	printf " %s - %s \n",g1,g2;

printf "\n\n";
printf "\n\n";

data;

set gyerekek := Peti Evi Piroska Juliska Adam Rozi Janka Aladar Dani Zoli Tamas Balint Krisztian Karolina Marika Tibi;


set jatekok := baba kisauto yoyo maci bicikli puzzle;


param jatekar := 
baba  1000
kisauto 1500
yoyo 800
maci 1100
bicikli 1300
puzzle 900
;

param kivansag :

			baba 	kisauto 	yoyo 	maci 	bicikli		puzzle:=
Peti 		0		1			1		1		0			0
Evi 		1		0			0		1		1			1
Piroska 	1		0			0		1		1			1
Juliska 	1		0			1		1		1			0
Adam 		0		1			0		0		1			1
Rozi 		1		0			1		1		1			0
Janka 		1		0			1		0		0			0
Aladar 		0		1			0		1		0			1
Dani 		0		1			0		1		1			1
Zoli 		0		1			0		1		1			0
Tamas 		0		1			1		1		0			0
Balint 		0		1			1		1		1			1
Krisztian 	0		1			0		1		0			0
Karolina 	1		0			0		1		0			1
Marika 		1		0			0		0		0			0
Tibi 		0		1			1		0		1			0
;


set utcabeliek :=
	(Peti,Evi) (Peti,Aladar) (Evi,Aladar)
	(Janka,Dani) (Janka,Tibi)(Tibi,Dani)
	(Juliska,Adam)  
	(Tamas, Balint) (Tamas, Krisztian) (Balint, Krisztian) (Rozi,Zoli) (Tamas, Rozi) (Tamas, Zoli) (Balint, Rozi ) (Balint, Zoli) (Krisztian, Rozi) (Krisztian, Zoli)
	(Karolina, Marika)
;

# Ez a megoldás az eredeti adatokkal készült (prbáltam a javasolt megoldást is, de a halmazoknál elakadtam, amikor  a gyerekeket az utcákhoz kellene rendelni)


# A feladat a Mikulás gyárához készül. Minden gyerek kap egy ajándékot a Mikulástól.
# A télapó figyelembe veszi, hogy ki mit szeretne kapni. Minden gyerek egy ajándékot kaphat, és maximum 3 gyerek kaphatja ugyanazt az ajándékot. (Pl mert ennyi van a Mikulás raktárában készleten és nincs idejük a manóknak többet készíteni dec. 6-ig)
# A Télapó bár mindenkinek szeretne örömet okozni, sajnos a költségekre is figyelnie kell, így a feladat a költségek minimalizálása.
# Azonban azt is figyelembe veszi, hogy az egy utcában lakó gyerekek ne kapjanak ugyanolyan ajándékot, így tudnak egymás játékaival játszani.