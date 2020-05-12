
sentence(Sentence,sentence(Noun_Phrase,Verb_Phrase)):-
		np(Sentence,Noun_Phrase,Rem),
	vp(Rem,Verb_Phrase).

np([X|T],np(det(X),NP2),Rem):-
	det(X),
	np2(T,NP2,Rem).
np(Sentence,Parse,Rem):- np2(Sentence,Parse,Rem).
np(Sentence,np(NP,PP),Rem):-
	np(Sentence,NP,Rem1),
	pp(Rem1,PP,Rem).

np2([H|T],np2(noun(H)),T):- noun(H).
np2([H|T],np2(adj(H),Rest),Rem):- adj(H),np2(T,Rest,Rem).  pp([H|T],pp(prep(H),Parse),Rem):-
	prep(H),
	np(T,Parse,Rem).

vp([H|[]],verb(H)):-
	verb(H).

vp([H|Rest],vp(verb(H),RestParsed)):-
	verb(H),
	pp(Rest,RestParsed,_H).
vp([H|Rest],vp(verb(H),RestParsed)):-
	verb(H),
	np(Rest,RestParsed,_H).

det(the).
det(a).
det(an).
noun(cat).
noun(mat).
noun(father).
noun(book).
noun(boy).
noun(horses).
noun(grandfather).
noun(person).
noun(student).
noun(guitar).
noun(car).
noun(chat).
noun(petrolhead).
noun(walk).
noun(racing).
verb(likes).
verb(loves).
verb(sat).
prep(a).
prep(on).
adj(young).
adj(sprightly).
adj(teenage).
adj(good).
adj(old).
adj(social).
adj(long).
adj(avid).
adj(big).
adj(fat).
adj(comfy).

mymember(Item, [Item|_]).

mymember(Item, [_|Rest]):-
    mymember(Item, Rest).

recommend(likes,books, 'he joins the book club').
recommend(loves,horses, 'they join a riding club').
recommend(loves,walk, 'he joins a rambling club').
recommend(likes,chat, 'they join a social club').
recommend(likes,guitar, 'they should join a band').
recommend(loves,car, 'they should go to the races').

put_if(S, Cond) :-
    Cond,
    S.
put_if(_, Cond) :-
    not(Cond).

ppargs([], _).
ppargs([H|T], N) :-
    pptree(H, N),
    put_if(nl, T \== []),
    ppargs(T, N).

pptree(E, N) :-
    E =.. [H|T],
    length(T, Len),
    put_if(tab(N), Len >= 1),
    write(H),
    put_if(write('|-- '), Len >= 1),
    put_if(nl, Len >= 2),
    Nx is N + 3,
    ppargs(T, Nx),
    put_if(write(' '), Len >= 1).

pptree(E) :-
    pptree(E, 0).


agent:-
	nl,
	write('Enter sentence : '),
	read(Input),
	sentence(Input,Z),
	pptree(Z),
	nl,
/*	mymember(likes,Input),
	writeln('He joins the book club.'),
*/	agent.


/*
agent:-
	nl,
	write('Enter promt as list : '),
	perceive(Percepts),
	action(Percepts),
	nl,
	mymember(likes,Percepts),
	writeln('He joins the book club.'),
	agent.
*/

