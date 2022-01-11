set gyerekek;
set jatekok;
param jatekar{jatekok};
param kivansag{gyerekek, jatekok};
set utcak;
set BenneLakik{utcak} within gyerekek;

var megkapja{gyerekek,jatekok} binary;
var ottlakik{gyerekek} binary; # minden gyerekre megnézi hogy adott utcában lakik e (1) vagy nem (0)


s.t. mindenki1ajandekot {g in gyerekek}:
	sum{j in jatekok} megkapja[g,j] = 1;

s.t. max3anKaphatnakUgyanazt {j in jatekok}:
	sum {g in gyerekek} megkapja[g,j] <=3;

s.t. kivansagfigelo {g in gyerekek, j in jatekok : kivansag[g,j] <> 1}:
	megkapja[g,j] = 0;

s.t. utcabelisegetfigyelo {u in utcak, j in jatekok }: 
	 sum {g in gyerekek, b in BenneLakik[u]} ottlakik[b] * megkapja[g,j] > 0;
#   1	1	1
#   1	0	0
#   0	1	0
#   0	0	0

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


printf "\n\n";
printf "\n\n";

data;

set gyerekek := Peti Evi Piroska Juliska Adam Rozi Janka Aladar Dani Zoli Tamas Balint Krisztian Karolina Marika;


set jatekok := baba kisauto yoyo maci bicikli puzzle;


param jatekar := 
baba  1200
kisauto 1300
yoyo 500
maci 700
bicikli 1500
puzzle 1000
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
;


set utcak := Petofi Ady Fo Beke Szabadsag;

set BenneLakik[Petofi] := Peti Evi;
set BenneLakik[Ady] := Piroska Juliska Rozi Janka;
set BenneLakik[Fo] := Adam Zoli;
set BenneLakik[Beke] := Aladar Tamas Krisztian Karolina;
set BenneLakik[Szabadsag] := Dani Balint Marika;


# A feladat a Mikulás gyárához készül. Minden gyerek kap egy ajándékot a Mikulástól.
# A télapó figyelembe veszi, hogy ki mit szeretne kapni. Minden gyerek egy ajándékot kaphat, és maximum 3 gyerek kaphatja ugyanazt az ajándékot. (Pl mert ennyi van a Mikulás raktárában készleten és nincs idejük a manóknak többet készíteni dec. 6-ig)
# A Télapó bár mindenkinek szeretne örömet okozni, sajnos a költségekre is figyelnie kell, így a feladat a költségek minimalizálása.
# Azonban azt is figyelembe veszi, hogy az egy utcában lakó gyerekek ne kapjanak ugyanolyan ajándékot, így tudnak egymás játékaival játszani.