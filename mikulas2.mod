set gyerekek;
set jatekok;
param jatekar{jatekok};
param kivansag{gyerekek, jatekok};
set utcak;
set BenneLakik{utcak} within gyerekek;

var megkapja{gyerekek,jatekok} binary;
var ottlakik{gyerekek} binary; # minden gyerekre megn�zi hogy adott utc�ban lakik e (1) vagy nem (0)


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

printf "K�lts�g: %d\n",koltseg;

for {g in gyerekek}
{
	printf "%s: \n",g;
	for {j in jatekok : megkapja[g,j] <> 0}
		printf "  -%s (%g)\n\n",j,jatekar[j];
		
}

printf "\n\n";
printf "Egy utc�ban laknak: \n";


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


# A feladat a Mikul�s gy�r�hoz k�sz�l. Minden gyerek kap egy aj�nd�kot a Mikul�st�l.
# A t�lap� figyelembe veszi, hogy ki mit szeretne kapni. Minden gyerek egy aj�nd�kot kaphat, �s maximum 3 gyerek kaphatja ugyanazt az aj�nd�kot. (Pl mert ennyi van a Mikul�s rakt�r�ban k�szleten �s nincs idej�k a man�knak t�bbet k�sz�teni dec. 6-ig)
# A T�lap� b�r mindenkinek szeretne �r�met okozni, sajnos a k�lts�gekre is figyelnie kell, �gy a feladat a k�lts�gek minimaliz�l�sa.
# Azonban azt is figyelembe veszi, hogy az egy utc�ban lak� gyerekek ne kapjanak ugyanolyan aj�nd�kot, �gy tudnak egym�s j�t�kaival j�tszani.