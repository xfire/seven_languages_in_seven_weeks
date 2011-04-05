instrument('bill dixon', trumpete).
instrument('eddie gale', trumpete).
instrument('arthur doyle', sax).
instrument('keith abrams', drummer).
instrument('del casher', guitar).
instrument('nil', guitar).

grene('bill dixon', jazz).
grene('eddie gale', jazz).
grene('arthur doyle', jazz).
grene('keith abrams', rock).
grene('del casher', rock).
grene('nil', metal).

grene_instrument_musician(G, I, M) :- instrument(M, I), grene(M, G).
