y /: y^(n_/;n>=3) := Expand[y^Mod[n,3] * (3y - 4)^Quotient[n, 3]]

f = x^3 - 3x + 4
fy = FullSimplify@CoefficientList[f/.{x->a y^2 + b y + c}, y]

(* Solve[Map[EqualTo[0]][fy], Modulus -> 113] *)

R[p_] := Module[{sols, dis, rules, cs},
rules = Solve[Map[EqualTo[0]][fy], {a,b,c}, Modulus -> p];
cs = c/.rules;
sols = (a y^2 + b y + c)/.rules;
dis = Expand[(sols[[1]] - sols[[2]]) * (sols[[2]] - sols[[3]]) * (sols[[3]] - sols[[1]])];
Mod[(-1)^(If[B[p] ==  cs[[2]], 0, 1]) * dis/.{y->0}, p]
]

B[p_] := Module[{F},
  F = FiniteField[p, Function[x, x^3 - 3x + 4]];
  (FiniteFieldElement[F, {0, 1, 0}]^p)["Coefficients"][[1]]
]

ni = 1000000000
nf = ni/10 + ni
ps = ParallelSum[
  If[ PrimeQ[i] && IrreduciblePolynomialQ[f, Modulus -> i], R[i], 0 ],
{i, ni, nf}];
Print[ps]

(* ni = 1000000000 *)
(* nf = 1100000000 *)
(* ps = ParallelTable[ *)
(*   If[ *)
(*     PrimeQ[i] && IrreduciblePolynomialQ[f, Modulus -> i], *)
(*     i, *)
(*   Nothing *)
(*   ], *)
(* {i, ni, nf}]; *)

(* ParallelSum[R[p], {p, ps}] *)

  (* Mod[Mod[(y^p)/.{y->0}, p], 2] *)

(* tps = {109, 113, 137, 149, 157, 173, 193, 197, 229} *)
(* TableForm@Map[Function[p, {p, R[p]}]][tps] *)

(* CoefficientList[y^13//FullSimplify, y] *)
(* Thread[Mod[%, 13]] *)

(* testff = FiniteField[113, Function[x, x^3 - 3x + 4]] *)

(* testff[2] *)

(* testff[2]^113 *)

(* FiniteFieldElement[testff, {0, 1, 0}] *)
(* FiniteFieldElement[testff, {0, 1, 0}]^113 *)
(* %["Coefficients"][[1]] *)

(* (1* CoefficientList[y^4//FullSimplify, y] *1) *)
(* (1* Thread[Mod[%, 13]] *1) *)

(* Mod[y^109/.{y->0}, 109] *)
(* Mod[y^113/.{y->0}, 113] *)
(* Mod[y^137/.{y->0}, 137] *)

(* (1* B[ps[[1]]] *1) *)

(* (1* R[173] *1) *)
(* (1* Mod[ - 1, 3] *1) *)

(* (1* Mod[PowerMod[Discriminant[f, x], 1/2, ps[[1]]^3], ps[[1]]] *1) *)

(* FactorList[f, Modulus -> 13] *)

(* (1* Solve[f == 0, Modulus -> 101^3] *1) *)

(* (1* Solve[f == 0, Modulus -> 109^3] *1) *)

(* (1* Table[Solve[f == 0, Modulus -> 11^i], {i, 1,10}] *1) *)

(* (1* Solve[f == 0, Modulus -> ps[[1]]] *1) *)

(* (1* PowerMod[Discriminant[f, x], 1/2, ps[[1]]] *1) *)

(* (1* Mod[PowerMod[Discriminant[f, x], 1/2, 109^2], 109] *1) *)

(* (1* R[p_] := Module[{n = 2}, *1) *)
(* (1*   mf = Function[n, Mod[PowerMod[Discriminant[f, x], 1/2, p^n], p]] *1) *)
(* (1*   While[mf[n+1] != mf[n] , n += 1]; *1) *)
(* (1*   Mod[PowerMod[Discriminant[f, x], 1/2, p^n], p] *1) *)
(* (1* ] *1) *)

(* Q[p_, n_] := Mod[PowerMod[Discriminant[f, x], 1/2, p^n], p] *)

(* Qo[p_] := Mod[(-1)^(3 * Mod[p+1, 4]) PowerMod[Discriminant[f, x], 1/2, p^3], p] *)

(* Qm[p_, n_] := Mod[-PowerMod[Discriminant[f, x], 1/2, p^n], p] *)

(* R[p_] := Q[p, p + 5] *)

(* tps = {109, 113, 137, 149, 157, 173, 193, 197, 229} *)

(*                                                                        (1* (109, 60) *1) *)
(*                                                                        (1* (113, 44) *1) *)
(*                                                                        (1* (137, 19) *1) *)
(*                                                                        (1* (149, 47) *1) *)
(*                                                                        (1* (157, 33) *1) *)
(*                                                                        (1* (173, 117) *1) *)
(*                                                                        (1* (193, 107) *1) *)
(*                                                                        (1* (197, 142) *1) *)
(*                                                                        (1* (229, 94) *1) *)
(*                                                                        (1* (233, 29) *1) *)
(*                                                                        (1* (241, 188) *1) *)
(*                                                                        (1* (257, 226) *1) *)
(*                                                                        (1* (269, 131) *1) *)
(*                                                                        (1* (281, 111) *1) *)
(*                                                                        (1* (293, 153) *1) *)



(* (1* (a-b)(b-a)(c-a) *1) *)
(* (1* -(b-a)^2(c-a) *1) *)
(* (1* -(b-a)^2(c-a) *1) *)
(* (1* (x-a) (x - b) (x - c) *1) *)
(* (1* -(b-a)(c-b)(c-a) *1) *)
(* (1* +(b-a)(c-b)(c-a) *1) *)

(* MS[n_, p_] := If[n < p - n, n - p, n] *)
(* PP[n_, p_] := PowerMod[PowerMod[Q[p, n], 1/2, p], 2, p] *)

(* TableForm@Table[ *)
(*   {p, Qo[p]}, {p, tps} *)
(* ] *)

(* TableForm@Table[ *)
(*   {p, Q[p, n], Qm[p, n], PP[Q[p, n], p], PP[Qm[p, n], p]}, *)
(*   {n, 3, 3}, {p, tps} *)
(* ] *)


(* TableForm@Table[ *)
(*   {p, Q[p, n], Qm[p, n]}, *)
(*   {n, 3, 3}, {p, tps} *)
(* ] *)

(* TableForm@Table[ *)
(*   {p, Q[p, n]}, *)
(*   {n, 1, 10}, {p, tps} *)
(* ] *)

(* TableForm@Table[ *)
(*   {p, PowerMod[PowerMod[Q[p, 1 + n], 2, p], 1/2, p]}, *)
(*   {n, 0, 6}, {p, tps} *)
(* ] *)

(* TableForm@Table[ *)
(*   {p, Q[p, 3]}, *)
(*   {p, {109, 113, 137, 157, 173}} *)
(* ] *)

(* (1* Fold[ *1) *)
(* (1* Function[{x,y}, Mod[ x * y, ps[[1]] ]], Range[0, ps[[1]]] *1) *)
(* (1* ] *1) *)

(* (1* Mod[Discriminant[f, x], ps[[9]]^3] *1) *)
(* (1* Resultant[f, D[f,x], x, Modulus -> ps[[3]]] *1) *)

(* Sum[R[p], {p, ps}] *)
